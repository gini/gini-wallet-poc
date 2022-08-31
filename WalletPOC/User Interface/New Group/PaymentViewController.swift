//
//  InvoiceViewController.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import Foundation
import UIKit
import PDFKit

class PaymentViewController: UIViewController {
    
    private let titleLabel = UILabel.autoLayout()
    private let fromLabel = UILabel.autoLayout()
    private let toLabel = UILabel.autoLayout()
    private let invoiceLabel = UILabel.autoLayout()
    
    private let grayView = UIView.autoLayout()
    private let savingsAccountLabel = UILabel.autoLayout()
    private let fromAccountLabel = UILabel.autoLayout()
    private let fromAmountLabel = UILabel.autoLayout()
    private let switchAccountButton = UIButton.autoLayout()
    
    private let tinyView = UIView.autoLayout()
    
    
    private let grayViewSecond = UIView.autoLayout()
    private let merchantAccountLabel = UILabel.autoLayout()
    private let toAccountLabel = UILabel.autoLayout()
    private let toAmountLabel = UILabel.autoLayout()
    private let merchantLogo = UIButton.autoLayout()
    
    private let pdfView = PDFView.autoLayout()
    private let scrollView = UIScrollView.autoLayout()
    private let contentView = UIView.autoLayout()
    
    private let bottomView = UIView.autoLayout()
    private let amountLabel = UILabel.autoLayout()
    private let payNowButton = UIButton.autoLayout()
    private let payLaterButton = UIButton.autoLayout()
    private let refuseButton = UIButton.autoLayout()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Online Payment"
        
        toLabel.text = "To"
        toLabel.textAlignment = .left

        fromLabel.text = "From"
        fromLabel.textAlignment = .left
        
        invoiceLabel.text = "Invoice"
        
        grayView.backgroundColor = .lightGray
        //mocked
        savingsAccountLabel.text = "Savings Account"
        savingsAccountLabel.textColor = .gray
        
        fromAccountLabel.text = "DE23 3701 0044 1344 8291 01"
        fromAccountLabel.textColor = .gray
        
        fromAmountLabel.text = "€6.231,40"
        fromAmountLabel.textColor = .gray
        
        switchAccountButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        switchAccountButton.tintColor = .black
        
        grayViewSecond.backgroundColor = .lightGray
        merchantAccountLabel.text = "Zalando AG"
        toAccountLabel.text  = "DE 88762181787817687"
        toAmountLabel.text = "Ref: Invoice #378981798"
        
        
        merchantLogo.setImage(UIImage(named: "zalandoLogo"), for: .normal)
        
        
        tinyView.backgroundColor = .lightGray
        
        pdfView.autoScales = true

        contentView.backgroundColor = .green
        
        scrollView.backgroundColor = .yellow
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true

        view.backgroundColor = .blue
        
        bottomView.backgroundColor = .systemPink
        amountLabel.text = "€255.00"
        
        payNowButton.setTitle("Pay Now", for: .normal)
        payNowButton.backgroundColor = .green
        
        payLaterButton.setTitle("Pay Later", for: .normal)
        payLaterButton.backgroundColor = .blue
        
        refuseButton.setTitle("Refuse", for: .normal)
        
        view.addSubview(bottomView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [titleLabel, fromLabel, toLabel, grayView, grayViewSecond, tinyView, invoiceLabel, pdfView].forEach { contentView.addSubview($0) }
        
        [savingsAccountLabel, fromAccountLabel, fromAmountLabel, switchAccountButton].forEach{ grayView.addSubview($0) }
        
        [merchantAccountLabel, toAccountLabel, toAmountLabel, merchantLogo].forEach{ grayViewSecond.addSubview($0) }
        
        [amountLabel, payNowButton, payLaterButton, refuseButton].forEach{ bottomView.addSubview($0) }
        
        guard let path = Bundle.main.url(forResource: "pdfMock2", withExtension: "pdf") else {
            return }

        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    
    private func setupConstraints() {
        
        let constraints = [
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150),
            
            amountLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            amountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            
            payNowButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 2/3),
            payNowButton.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15),
            payNowButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            payLaterButton.centerYAnchor.constraint(equalTo: payNowButton.centerYAnchor),
            payNowButton.leadingAnchor.constraint(greaterThanOrEqualTo: payLaterButton.trailingAnchor, constant: 10),
            payLaterButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 1/3),
            payLaterButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            refuseButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            refuseButton.topAnchor.constraint(equalTo: payLaterButton.bottomAnchor, constant: 15),
            refuseButton.leadingAnchor.constraint(greaterThanOrEqualTo: bottomView.leadingAnchor, constant: 20),

            
            
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            fromLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            fromLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            grayView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 20),
            grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            grayView.heightAnchor.constraint(equalToConstant: 100),
            
            savingsAccountLabel.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 15),
            savingsAccountLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 15),
            savingsAccountLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            fromAccountLabel.topAnchor.constraint(equalTo: savingsAccountLabel.bottomAnchor, constant: 5),
            fromAccountLabel.leadingAnchor.constraint(equalTo: savingsAccountLabel.leadingAnchor),
            
            fromAmountLabel.topAnchor.constraint(equalTo: fromAccountLabel.bottomAnchor, constant: 5),
            fromAmountLabel.leadingAnchor.constraint(equalTo: savingsAccountLabel.leadingAnchor),
            
            switchAccountButton.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            switchAccountButton.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -15),
            switchAccountButton.widthAnchor.constraint(equalToConstant: 40),
            switchAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            tinyView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 20),
            tinyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tinyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tinyView.heightAnchor.constraint(equalToConstant: 1),
            
            toLabel.topAnchor.constraint(equalTo: tinyView.bottomAnchor, constant: 20),
            toLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            grayViewSecond.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 20),
            grayViewSecond.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            grayViewSecond.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            grayViewSecond.heightAnchor.constraint(equalToConstant: 100),
            
            merchantAccountLabel.topAnchor.constraint(equalTo: grayViewSecond.topAnchor, constant: 15),
            merchantAccountLabel.leadingAnchor.constraint(equalTo: grayViewSecond.leadingAnchor, constant: 15),
            merchantAccountLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            toAccountLabel.topAnchor.constraint(equalTo: merchantAccountLabel.bottomAnchor, constant: 5),
            toAccountLabel.leadingAnchor.constraint(equalTo: merchantAccountLabel.leadingAnchor),
            
            toAmountLabel.topAnchor.constraint(equalTo: toAccountLabel.bottomAnchor, constant: 5),
            toAmountLabel.leadingAnchor.constraint(equalTo: merchantAccountLabel.leadingAnchor),
            
            merchantLogo.centerYAnchor.constraint(equalTo: grayViewSecond.centerYAnchor),
            merchantLogo.trailingAnchor.constraint(equalTo: grayViewSecond.trailingAnchor, constant: -15),
            merchantLogo.widthAnchor.constraint(equalToConstant: 40),
            merchantLogo.heightAnchor.constraint(equalToConstant: 40),

            
            invoiceLabel.topAnchor.constraint(equalTo: grayViewSecond.bottomAnchor, constant: 20),
            invoiceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            pdfView.topAnchor.constraint(equalTo: invoiceLabel.bottomAnchor, constant: 20),
            pdfView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pdfView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pdfView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            pdfView.heightAnchor.constraint(equalToConstant: 400)
            ]
        NSLayoutConstraint.activate(constraints)
    }
}
