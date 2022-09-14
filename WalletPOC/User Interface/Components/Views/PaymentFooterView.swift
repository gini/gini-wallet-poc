//
//  PaymentFooterView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 13.09.2022.
//

import Foundation

import UIKit
import PDFKit

final class PaymentFooterView: UIView {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = .padding3x
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
     
    private lazy var merchantDetailsView: AccountView = {
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
    
    private lazy var invoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Invoice"
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        guard let path = Bundle.main.url(forResource: "pdfMock2", withExtension: "pdf") else {
            return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        
        merchantDetailsView.accountNameLabel.text = "Rainbow Store"
        merchantDetailsView.ibanLabel.text  = "DE 88762181787817687"
        merchantDetailsView.amountInvoiceLabel.text = "Ref: Invoice #378981798"
        merchantDetailsView.decorate(with: CornerRadiusDecorator(radius: .viewRadius))
        
        addSubview(stackView)
        stackView.addArrangedSubview(toStackView)
        stackView.addArrangedSubview(invoiceStackView)

        toStackView.addArrangedSubview(toLabel)
        toStackView.addArrangedSubview(merchantDetailsView)
        invoiceStackView.addArrangedSubview(invoiceLabel)
        invoiceStackView.addArrangedSubview(pdfView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: .padding3x),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding3x),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding3x),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x),
            
            pdfView.heightAnchor.constraint(equalToConstant: 420),
            merchantDetailsView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
