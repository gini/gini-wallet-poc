//
//  MonthlyPaymentViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 13.09.2022.
//

import Foundation
import UIKit

final class MonthlyPaymentViewController: BaseViewController {
    
    // MARK: - Properties
    private lazy var footerView: PaymentFooterView = {
        let footerView = PaymentFooterView()
        return footerView
    }()
    
    private lazy var progressView: ProgressView = {
        let view = ProgressView(totalPortions: viewModel.totalMonths, portionsDone: viewModel.paidMonths, totalWidth: view.frame.width - Double(2 * .padding3x))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .body
        label.textColor = .secondaryText
        label.text = "Full amount"
        return label
    }()
    
    private lazy var fullAmountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .bodyLarge
        label.textColor = .primaryText
        label.text = viewModel.totalAmountText
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.blueishGray.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var actionButton: ActionButton = {
        let button = ActionButton(style: .constructive)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pay next installment", for: .normal)
        return button
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .borderColor
        return view
    }()
    
    private let viewModel: MonthlyPaymentViewModel
    
    var transactionUpdated: ((Transaction) -> ())? = nil
    
    // MARK: - Lifecycle
    
    init(viewModel: MonthlyPaymentViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.decorate(with: CornerRadiusDecorator(radius: 16))

        guard let footerView = tableView.tableFooterView else {
            return
        }

        let size = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
            tableView.tableFooterView = footerView
            tableView.layoutIfNeeded()
        }
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Monthly payment"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerHeader(viewType: WalletSectionHeader.self)
        tableView.register(cellType: TransactionCell.self)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        
        view.addSubview(grayView)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        grayView.addSubview(progressView)
        grayView.addSubview(fullAmountLabel)
        grayView.addSubview(fullAmountValueLabel)
        bottomView.addSubview(actionButton)
        bottomView.addSubview(separatorView)
        
        footerView.merchantDetailsView.ibanLabel.text = viewModel.merchantIban
        
        actionButton.addTarget(self, action: #selector(didTapPayNext), for: .touchUpInside)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: view.topAnchor),
            grayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            grayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .padding),
            progressView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: .padding3x),
            progressView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -.padding3x),
            
            fullAmountLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: .padding2x),
            fullAmountLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: .padding3x),
            fullAmountLabel.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -.padding5x),
            
            fullAmountValueLabel.centerYAnchor.constraint(equalTo: fullAmountLabel.centerYAnchor),
            fullAmountValueLabel.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -.padding3x),
            
            actionButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: .padding3x),
            actionButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: .padding3x),
            actionButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -.padding3x),
            actionButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -.padding3x),

            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 98),

            separatorView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapPayNext() {
        let paymentViewController = PaymentViewController(viewModel: PaymentViewModelImpl(type: .installment(total: viewModel.totalMonths, paid: viewModel.paidMonths), transactionViewModel: TransactionViewModel(merchantAppScheme: "", transactionId: "", buyNowPayLater: "", transactionAmount: viewModel.totalAmount), transaction: viewModel.transaction))
        if paymentViewController.walletDelegate == nil {
            paymentViewController.walletDelegate = viewModel
        }
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
}

extension MonthlyPaymentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(viewType: WalletSectionHeader.self)
        view?.title = viewModel.sectionModels[section].title
        view?.canSchedule = viewModel.sectionModels[section].canSchedulePayment
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionCell.self)
        cell.viewModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        cell.contentView.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section + 1 == viewModel.sectionModels.count {
            footerView.delegate = self
            return footerView
        }
        return nil
    }
}

extension MonthlyPaymentViewController: SchedulePaymentsAlertViewDelegate {
    
    func didConfirm(isScheduled: Bool, checkedCellModels: [SchedulePaymentCellModel]) {
        dismiss(animated: true)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension MonthlyPaymentViewController: MonthlyPaymentViewUpdater {
    func update(with transaction: Transaction) {
        transactionUpdated?(transaction)
        navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {
        progressView.portionsDone = viewModel.paidMonths
        tableView.reloadData()
    }
}

extension MonthlyPaymentViewController: PaymentFooterViewDelegate {
    
    func openPDFDetail() {
        let pdfVC = PDFViewController()
        pdfVC.modalPresentationStyle = .overFullScreen
        present(pdfVC, animated: true)
    }
}
