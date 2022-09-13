//
//  WalletViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class WalletViewController: BaseViewController {
    
    // MARK: - Properties
    
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
    
    // MARK: - Actions
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
//        if cellModel.type == .scheduledUpcoming {
//
//        }
        let monthlyPaymentVC = MonthlyPaymentViewController(viewModel: MonthlyPaymentViewModel(totalMonths: 3, paidMonths: 2, totalAmount: 190))
        navigationController?.pushViewController(monthlyPaymentVC, animated: true)
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
