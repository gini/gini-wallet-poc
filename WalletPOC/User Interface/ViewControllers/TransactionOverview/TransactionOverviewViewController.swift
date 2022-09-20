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
        label.text = "To"
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    lazy var senderDetailsView: AccountView = {
        let view = AccountView(type: .sender)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var invoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Invoice"
        label.font = .subtitleSmall
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
        navigationItem.title = "Online payment"
        
        guard let path = Bundle.main.url(forResource: "receipt", withExtension: "pdf") else {
            return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPDFView))
        pdfView.addGestureRecognizer(tapGesture)
        
        merchantDetailsView.accountNameLabel.text = "Rainbow Store"
        merchantDetailsView.ibanLabel.text  = "DE 88762181787817687"
        merchantDetailsView.amountInvoiceLabel.text = "Ref: Invoice #378981798"
        merchantDetailsView.decorate(with: CornerRadiusDecorator(radius: .viewRadius))
        
        senderDetailsView.accountNameLabel.text = "Rainbow Store"
        senderDetailsView.ibanLabel.text  = "DE 88762181787817687"
        senderDetailsView.amountInvoiceLabel.text = "Ref: Invoice #378981798"
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
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .padding3x),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.padding3x),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding3x),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding3x),
            
            pdfView.heightAnchor.constraint(equalToConstant: 420),
            merchantDetailsView.heightAnchor.constraint(equalToConstant: 100),
            senderDetailsView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func didTapPDFView() {
        let pdfVC = PDFViewController()
        pdfVC.modalPresentationStyle = .overFullScreen
        present(pdfVC, animated: true)
    }
}
