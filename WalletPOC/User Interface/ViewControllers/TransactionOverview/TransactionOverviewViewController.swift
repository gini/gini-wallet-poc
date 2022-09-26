//
//  TransactionOverviewViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 20.09.2022.
//

import Foundation
import UIKit
import PDFKit

final class TransactionOverviewViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = .padding2x
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var toStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = .padding2x
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var fromStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = .padding2x
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var invoiceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = .padding2x
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoScales = true
        return view
    }()
    
    lazy var merchantDetailsView: AccountView = {
        let view = AccountView(type: .merchant)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.to
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    lazy var senderDetailsView: AccountView = {
        let view = AccountView(type: .sender)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isIconHidden = true

        return view
    }()
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.fromPaymentvc
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var invoiceLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.invoice
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .borderColor
        return view
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headig2
        label.textColor = .primaryText
        return label
    }()
    
    private var transaction: Transaction
    
    // MARK: - Lifecycle
    
    init(transaction: Transaction) {
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = L10n.onlinePayment
        
        guard let path = Bundle.main.url(forResource: "Rainbow_store_invoice", withExtension: "pdf") else {
            return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPDFView))
        pdfView.addGestureRecognizer(tapGesture)
        
        merchantDetailsView.accountNameLabel.text = transaction.merchantName
        merchantDetailsView.ibanLabel.text  = transaction.merchantIban
        merchantDetailsView.amountInvoiceLabel.text = "Ref: \(L10n.invoice) #378981798"
        merchantDetailsView.decorate(with: CornerRadiusDecorator(radius: .viewRadius))
        merchantDetailsView.switchAccountIcon.image = transaction.merchantLogo
        
        senderDetailsView.accountNameLabel.text = transaction.account.name
        senderDetailsView.ibanLabel.text  = transaction.account.iban
        senderDetailsView.amountInvoiceLabel.text = "€6.231,40"
        senderDetailsView.decorate(with: CornerRadiusDecorator(radius: .viewRadius))
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(fromStackView)
        stackView.addArrangedSubview(toStackView)
        stackView.addArrangedSubview(invoiceStackView)

        toStackView.addArrangedSubview(toLabel)
        toStackView.addArrangedSubview(merchantDetailsView)
        
        fromStackView.addArrangedSubview(fromLabel)
        fromStackView.addArrangedSubview(senderDetailsView)
        
        invoiceStackView.addArrangedSubview(invoiceLabel)
        invoiceStackView.addArrangedSubview(pdfView)
        
        view.addSubview(bottomView)
        bottomView.addSubview(amountLabel)
        amountLabel.text = "€\(String(format: "%.2f", transaction.value))".replacingOccurrences(of: ".", with: ",")
        bottomView.addSubview(separatorView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .padding3x),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.padding3x),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding3x),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding3x),
            
            pdfView.heightAnchor.constraint(equalToConstant: 420),
            merchantDetailsView.heightAnchor.constraint(equalToConstant: 100),
            senderDetailsView.heightAnchor.constraint(equalToConstant: 100),
            
            amountLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness),
            separatorView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
    
    @objc private func didTapPDFView() {
        let pdfVC = PDFViewController()
        pdfVC.modalPresentationStyle = .overFullScreen
        present(pdfVC, animated: true)
    }
}
