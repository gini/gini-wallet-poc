//
//  WalletViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit
import Core

final class WalletViewController: BaseViewController {
    
    // MARK: - Properties
    var transactionViewModel: TransactionViewModel? {
        didSet {
            presentPaymentIfNeeded()
        }
    }
    
    private var transactionService = TransactionService()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.backgroundGradient.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var headerView: WalletHeaderView = {
        let header = WalletHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let viewModel: WalletViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        viewModel.viewUpdater = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBackButtonTitle()
        setupUI()
        setupLayout()
        
        self.hidesBottomBarWhenPushed = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            guard let headerView = tableView.tableHeaderView else {
                return
            }

            let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            if headerView.frame.size.height != size.height {
                headerView.frame.size.height = size.height
                tableView.tableHeaderView = headerView
                tableView.layoutIfNeeded()
            }
        }
    
    // MARK: - UI
    
    private func setupUI() {
        navigationItem.title = "My wallet"
        viewModel.viewUpdater = self
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.registerHeader(viewType: WalletSectionHeader.self)
        tableView.register(cellType: TransactionCell.self)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func presentPaymentIfNeeded() {
        guard let transactionViewModel = transactionViewModel else {
            return
        }
        
        let vc = FaceIDViewController(isLoader: true)
        vc.modalPresentationStyle = .overFullScreen
        vc.didAuthorize = { isEnabled in
            guard isEnabled else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                let walletVc = PaymentViewController(viewModel: PaymentViewModelImpl(type: transactionViewModel.buyNowPayLater == "true" ? .buyLater : .buyNow, transactionViewModel: transactionViewModel, transaction: Transaction(merchantName: "Rainbow store", value: 300, merchantLogo: Asset.Images.rainbowStore.image, dueDate: Date(), mention: "")))
                walletVc.walletDelegate = self.viewModel
                self.navigationController?.pushViewController(walletVc, animated: true)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            self.transactionService.loadTransactionState(transactionId: transactionViewModel.transactionId) { result in
                
                switch result {
                case .success(let isEnabled):
                    if isEnabled {
                        vc.didAuthorize?(isEnabled)
                        vc.dismiss(animated: true)
                    }
                case .failure:
                    print("Error while loading transaction state")
                }
            }
        }
        
        self.transactionViewModel = nil
        present(vc, animated: true)
    }
    
    // MARK: - Actions
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        let sectionModel = viewModel.sectionModels[indexPath.section]
        let transaction: Transaction
        if sectionModel.isUpcoming {
            transaction = viewModel.upcomingTransactions[indexPath.row]
        } else {
            transaction = viewModel.paidTransactions[indexPath.row]
        }
        
        switch cellModel.type {
        case .open:
            viewModel.upcomingTransactions.remove(at: indexPath.row)
            let paymentVC = PaymentViewController(viewModel: PaymentViewModelImpl(type: .buyNow, transactionViewModel: TransactionViewModel(merchantAppScheme: "", transactionId: transaction.id, buyNowPayLater: "false", transactionAmount: transaction.value), transaction: transaction))
            if paymentVC.walletDelegate == nil {
                paymentVC.walletDelegate = viewModel
            }
            navigationController?.pushViewController(paymentVC, animated: true)
            
        case .scheduledUpcoming(let totalInstallments, let paidInstallments):
            let monthlyPaymentVC = MonthlyPaymentViewController(viewModel: MonthlyPaymentViewModel(totalMonths: totalInstallments, paidMonths: paidInstallments, transaction: transaction))
            monthlyPaymentVC.transactionUpdated = { transaction in
                self.viewModel.updateList(with: transaction, at: indexPath.row)
                self.reloadData()
                self.navigationController?.popToRootViewController(animated: true)
            }
            navigationController?.pushViewController(monthlyPaymentVC, animated: true)
            
        default:
            // TODO: [Noemi] open already payed transaction overview
            print("Should open payed transactions overview")
            let transactionOverviewVC = TransactionOverviewViewController(transaction: transaction)
            navigationController?.pushViewController(transactionOverviewVC, animated: true)
        }
    }
}

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(viewType: WalletSectionHeader.self)
        view?.title = viewModel.sectionModels[section].title
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionCell.self)
        cell.viewModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        return cell
    }
}

extension WalletViewController: WalletViewUpdater {
    func reloadData() {
        tableView.reloadData()
    }
}
