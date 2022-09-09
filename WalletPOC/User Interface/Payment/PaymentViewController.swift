//
//  InvoiceViewController.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import Foundation
import UIKit
import PDFKit
import Alamofire

class PaymentViewController: UIViewController, XMLParserDelegate {
    
    private let titleLabel = UILabel.autoLayout()
    private let fromLabel = UILabel.autoLayout()
    private let toLabel = UILabel.autoLayout()
    private let invoiceLabel = UILabel.autoLayout()
    
    private let senderDetailsView = AccountView(type: .sender)
    
    private let tinyView = UIView.autoLayout()
    
    private let merchantDetailsView = AccountView(type: .merchant)
    
    private let pdfView = PDFView.autoLayout()
    private let scrollView = UIScrollView.autoLayout()
    private let contentView = UIStackView.autoLayout()
    
    private let bottomView = UIView.autoLayout()
    private let amountLabel = UILabel.autoLayout()
    private let payNowButton = UIButton.autoLayout()
    private let payLaterButton = UIButton.autoLayout()
    private let refuseButton = UIButton.autoLayout()
    
    private let bottomTinyView = UIView.autoLayout()
    
    private let payFullButton = CustomInstallmentButton(type: .payButton(type: .payNowFull))
    private let buyNowPayLaterButton = CustomInstallmentButton(type: .payButton(type: .buyNowPayLater))
    
    private let installmentsLabel = UILabel.autoLayout()
    
    private let threeMonthsButton = CustomInstallmentButton(type: .installmentButton(type: .threeMonths))
    private let sixMonthsButton = CustomInstallmentButton(type: .installmentButton(type: .sixMonths))
    private let nineMonthsButton = CustomInstallmentButton(type: .installmentButton(type: .nineMonths))
    
    private let horizontalScrollView = UIScrollView.autoLayout()
    private let horizontalContentView = UIView.autoLayout()
    
    private let acceptLabel = UILabel.autoLayout()
    private let termsConditionsButton = UIButton.autoLayout()
    private var checkmarkButton = CheckmarkButton(isChecked: false)
    
    private let viewModel: PaymentViewModel
    
    private var IsSavingsAccount = false
    
    init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        //        loadMerchantData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = viewModel.titleText
        titleLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 18)
        titleLabel.textAlignment = .left
        
        toLabel.text = viewModel.toText
        toLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        toLabel.textAlignment = .left
        
        fromLabel.text = viewModel.fromText
        fromLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        fromLabel.textAlignment = .left
        
        invoiceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        invoiceLabel.text = viewModel.invoiceText
        
        //senderDetailsView.backgroundColor = UIColor(named: "giniLightGray")

        //mocked
        senderDetailsView.accountNameLabel.text = viewModel.userAccountText
        senderDetailsView.ibanLabel.text = viewModel.userAccountNumber
        senderDetailsView.amountInvoiceLabel.text = viewModel.userAccountAmount
        senderDetailsView.switchAccountButton.tintColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        senderDetailsView.addGestureRecognizer(tap)
        
        //merchantDetailsView.backgroundColor = UIColor(named: "giniLightGray")

        merchantDetailsView.accountNameLabel.text = viewModel.merchantNameText
        merchantDetailsView.ibanLabel.text  = viewModel.merchantIban
        merchantDetailsView.amountInvoiceLabel.text = viewModel.merchantInvoice
        
        tinyView.backgroundColor = UIColor(named: "giniLightGray")
        bottomTinyView.backgroundColor = UIColor(named: "giniLightGray")
        pdfView.autoScales = true
        
        contentView.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true
        
        bottomView.backgroundColor = .white
        amountLabel.text = viewModel.priceText
        amountLabel.font = UIFont(name: "PlusJakartaSans-Bold", size: 32)
        
        payNowButton.setTitle("Pay Now", for: .normal)
        payNowButton.addTarget(self, action: #selector(didTapPayNow), for: .touchUpInside)
        payNowButton.backgroundColor = UIColor(named: "AccentColor")
        
        payNowButton.layer.cornerRadius = 5
        payNowButton.layer.borderWidth = 1
        payNowButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        payNowButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        payLaterButton.setTitle("Pay Later", for: .normal)
        payLaterButton.addTarget(self, action: #selector(didTapPayLater), for: .touchUpInside)
        payLaterButton.layer.cornerRadius = 5
        payLaterButton.layer.borderWidth = 1
        payLaterButton.layer.borderColor = UIColor(named: "borderGray")?.cgColor
        payLaterButton.backgroundColor = .clear
        payLaterButton.setTitleColor(UIColor(named: "gray"), for: .normal)
        payLaterButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        //payFullButton.titleLabel?.lineBreakMode = .byWordWrapping
        payFullButton.addTarget(self, action: #selector(payFullTapped), for: .touchUpInside)
        
        buyNowPayLaterButton.addTarget(self, action: #selector(buyNowPayLaterTapped), for: .touchUpInside)
        
        threeMonthsButton.addTarget(self, action: #selector(threeMonthsBtnTapped), for: .touchUpInside)
        sixMonthsButton.addTarget(self, action: #selector(sixMonthsBtnTapped), for: .touchUpInside)
        nineMonthsButton.addTarget(self, action: #selector(nineMonthsBtnTapped), for: .touchUpInside)

        
        installmentsLabel.text = viewModel.installmentsText
        installmentsLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        installmentsLabel.textAlignment = .left
        
        horizontalScrollView.backgroundColor = .white
        horizontalScrollView.contentInsetAdjustmentBehavior = .never
        horizontalScrollView.isScrollEnabled = true
        //horizontalScrollView.backgroundColor = .green
        
        acceptLabel.text = viewModel.acceptText
        acceptLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        termsConditionsButton.setTitle(viewModel.termsConditionsText, for: .normal)
        termsConditionsButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        termsConditionsButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        termsConditionsButton.addTarget(self, action: #selector(didTapTermsConditions), for: .touchUpInside)
        
        checkmarkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        refuseButton.setTitle("Refuse", for: .normal)
        refuseButton.addTarget(self, action: #selector(didTapRefuse), for: .touchUpInside)
        refuseButton.setTitleColor(.gray, for: .normal)
        
        checkmarkButton.isEnabled = false
        termsConditionsButton.isEnabled = false
        
        
        if senderDetailsView.accountNameLabel.text == "Savings Account"{
            IsSavingsAccount = true
        }
        
        view.addSubview(bottomView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [titleLabel, fromLabel, toLabel, senderDetailsView, merchantDetailsView, tinyView, invoiceLabel, pdfView, payFullButton, buyNowPayLaterButton].forEach { contentView.addSubview($0) }
        
        [amountLabel, payNowButton, payLaterButton, refuseButton, bottomTinyView].forEach{ bottomView.addSubview($0) }
        
        guard let path = Bundle.main.url(forResource: "pdfMock2", withExtension: "pdf") else {
            return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    
    private func setupConstraints() {
        [payFullButton, buyNowPayLaterButton, senderDetailsView, merchantDetailsView].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraint = tinyView.topAnchor.constraint(equalTo: payFullButton.bottomAnchor, constant: 20)
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true
        
        let constraints = [
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomTinyView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomTinyView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            bottomTinyView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            bottomTinyView.heightAnchor.constraint(equalToConstant: 2),
            
            amountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20),
            amountLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: payNowButton.topAnchor, constant: -20),
            
            payNowButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 2/3),
            payNowButton.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15),
            payNowButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            payNowButton.heightAnchor.constraint(equalToConstant: 50),
            
            payLaterButton.centerYAnchor.constraint(equalTo: payNowButton.centerYAnchor),
            payLaterButton.leadingAnchor.constraint(greaterThanOrEqualTo: payLaterButton.trailingAnchor, constant: 10),
            payLaterButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 1/3),
            payLaterButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            payLaterButton.heightAnchor.constraint(equalToConstant: 50),
            
            refuseButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            refuseButton.topAnchor.constraint(equalTo: payLaterButton.bottomAnchor, constant: 6),
            refuseButton.leadingAnchor.constraint(greaterThanOrEqualTo: bottomView.leadingAnchor, constant: 20),
            refuseButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 10),
            
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
            
            senderDetailsView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 20),
            senderDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            senderDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            senderDetailsView.heightAnchor.constraint(equalToConstant: 100),
            
            payFullButton.topAnchor.constraint(equalTo: senderDetailsView.bottomAnchor, constant: 10),
            payFullButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            payFullButton.heightAnchor.constraint(equalToConstant: 70),
            payFullButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            
            buyNowPayLaterButton.centerYAnchor.constraint(equalTo: payFullButton.centerYAnchor),
            buyNowPayLaterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buyNowPayLaterButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            buyNowPayLaterButton.heightAnchor.constraint(equalTo: payFullButton.heightAnchor),
            
            tinyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tinyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tinyView.heightAnchor.constraint(equalToConstant: 2),
            
            toLabel.topAnchor.constraint(equalTo: tinyView.bottomAnchor, constant: 20),
            toLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            merchantDetailsView.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 20),
            merchantDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            merchantDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            merchantDetailsView.heightAnchor.constraint(equalToConstant: 100),
            
            invoiceLabel.topAnchor.constraint(equalTo: merchantDetailsView.bottomAnchor, constant: 20),
            invoiceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            pdfView.topAnchor.constraint(equalTo: invoiceLabel.bottomAnchor, constant: 20),
            pdfView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pdfView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pdfView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            pdfView.heightAnchor.constraint(equalToConstant: 400),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buyNowPayLaterToggle() {
        horizontalScrollView.addSubview(horizontalContentView)
        [threeMonthsButton, sixMonthsButton, nineMonthsButton].forEach { horizontalContentView.addSubview($0) }
        
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        [installmentsLabel, horizontalScrollView, termsConditionsButton, acceptLabel, checkmarkButton].forEach { contentView.addSubview($0) }
        
        [threeMonthsButton, sixMonthsButton, nineMonthsButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            installmentsLabel.topAnchor.constraint(equalTo: payFullButton.bottomAnchor, constant: 15),
            installmentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            horizontalScrollView.topAnchor.constraint(equalTo: installmentsLabel.bottomAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 85),
            
            horizontalContentView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            horizontalContentView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            horizontalContentView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            horizontalContentView.bottomAnchor.constraint(lessThanOrEqualTo: horizontalScrollView.bottomAnchor),
            horizontalContentView.heightAnchor.constraint(equalToConstant: 70),
            
            threeMonthsButton.topAnchor.constraint(equalTo: horizontalContentView.topAnchor),
            threeMonthsButton.leadingAnchor.constraint(equalTo: horizontalContentView.leadingAnchor, constant: 20),
            threeMonthsButton.bottomAnchor.constraint(equalTo: horizontalContentView.bottomAnchor),
            threeMonthsButton.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 2 - 35),
            
            sixMonthsButton.centerYAnchor.constraint(equalTo: threeMonthsButton.centerYAnchor),
            sixMonthsButton.leadingAnchor.constraint(equalTo: threeMonthsButton.trailingAnchor, constant: 20),
            sixMonthsButton.widthAnchor.constraint(equalTo: threeMonthsButton.widthAnchor),
            sixMonthsButton.heightAnchor.constraint(equalTo: threeMonthsButton.heightAnchor),
            
            nineMonthsButton.centerYAnchor.constraint(equalTo: threeMonthsButton.centerYAnchor),
            nineMonthsButton.widthAnchor.constraint(equalTo: threeMonthsButton.widthAnchor),
            nineMonthsButton.heightAnchor.constraint(equalTo: threeMonthsButton.heightAnchor),
            nineMonthsButton.leadingAnchor.constraint(equalTo: sixMonthsButton.trailingAnchor, constant: 20),
            nineMonthsButton.trailingAnchor.constraint(equalTo: horizontalContentView.trailingAnchor, constant: -20),
            
            checkmarkButton.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 20),

            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 30),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 30),

            acceptLabel.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 25),
            acceptLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 20),
            
            termsConditionsButton.centerYAnchor.constraint(equalTo: acceptLabel.centerYAnchor),
            termsConditionsButton.leadingAnchor.constraint(equalTo: acceptLabel.trailingAnchor, constant: 5),
            
            tinyView.topAnchor.constraint(equalTo: acceptLabel.bottomAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func buttonSelect(button: UIButton) {
        button.backgroundColor = UIColor(named: "extraLightBlue")
        button.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        button.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }
    
    private func buttonDeselect(button: UIButton) {
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        button.layer.borderColor = UIColor(named: "borderGray")?.cgColor
    }
    
    // MARK: - Tap handles
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let accountVC = AccountSwitchViewController(isSavingsAccount: IsSavingsAccount)
        accountVC.delegateProtocol = self
        present(accountVC, animated: true)
    }
    
    @objc private func buyNowPayLaterTapped() {
        if buyNowPayLaterButton.backgroundColor == .clear  {
            buttonSelect(button: buyNowPayLaterButton)
            buttonDeselect(button: payFullButton)
        }
        buyNowPayLaterToggle()
    }
    
    @objc private func payFullTapped() {
        if payFullButton.backgroundColor == .clear {
            buttonSelect(button: payFullButton)
            buttonDeselect(button: buyNowPayLaterButton)
        }
        [installmentsLabel, horizontalScrollView, termsConditionsButton, acceptLabel, checkmarkButton].forEach { $0.removeFromSuperview() }
    }
    
    @objc private func threeMonthsBtnTapped() {
        buttonSelect(button: threeMonthsButton)
        threeMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        buttonDeselect(button: sixMonthsButton)
        sixMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        buttonDeselect(button: nineMonthsButton)
        nineMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        checkmarkButton.isEnabled = true
        termsConditionsButton.isEnabled = true

    }
    
    @objc private func sixMonthsBtnTapped() {
        buttonSelect(button: sixMonthsButton)
        sixMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        buttonDeselect(button: threeMonthsButton)
        threeMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        buttonDeselect(button: nineMonthsButton)
        nineMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        checkmarkButton.isEnabled = true
        termsConditionsButton.isEnabled = true
        

    }
    
    @objc private func nineMonthsBtnTapped() {
        buttonSelect(button: nineMonthsButton)
        nineMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        buttonDeselect(button: threeMonthsButton)
        threeMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        buttonDeselect(button: sixMonthsButton)
        sixMonthsButton.priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        checkmarkButton.isEnabled = true
        termsConditionsButton.isEnabled = true
    }
    
    @objc private func didTapTermsConditions() {
        let termsVC = TermsServicesViewController()
        termsVC.delegateProtocol = self
        present(termsVC, animated: true, completion: nil)
    }
    
    @objc private func checkButtonTapped() {
        checkmarkButton.isChecked.toggle()
    }
    
    @objc private func didTapPayNow() {
        presentSuccessAlert(with: .paymentConfirmed)
    }
    
    @objc private func didTapPayLater() {
        presentSuccessAlert(with: .paymentAdded)
    }
    
    @objc private func didTapRefuse() {
        let alertView = RefusePaymentView()
        alertView.delegate = self
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.populate(with: alertView)
        present(alertViewController, animated: true)
    }
    
    private func presentSuccessAlert(with type: SuccessAlertView.SuccessEnumType) {
        let alertView = SuccessAlertView(type: type)
        alertView.delegate = self
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.populate(with: alertView)
        present(alertViewController, animated: true)
    }
}


extension PaymentViewController: AccountSwitchProtocol {
    func sendDataforUpdate(account: Account) {
        senderDetailsView.accountNameLabel.text = account.name
        senderDetailsView.ibanLabel.text = account.iban
        senderDetailsView.amountInvoiceLabel.text = account.amount
        
        
        if senderDetailsView.accountNameLabel.text == "Savings Account"{
            IsSavingsAccount = true
        }
        
        if senderDetailsView.accountNameLabel.text == "Main Account"{
            IsSavingsAccount = false
        }
        
        
        print(":adasdsaasa")

    }
}

extension PaymentViewController: TermsServicesProtocol {
    func termsAccepted() {
        if checkmarkButton.backgroundColor != .accent {
            checkmarkButton.isChecked.toggle()
        }
    }
    
    
}

extension PaymentViewController: SuccessAlertViewDelegate {
    func didClose() {
        dismiss(animated: true)
    }
}

extension PaymentViewController: RefusePaymentViewDelegate {
    func didCancel() {
        dismiss(animated: true)
    }
    
    func didRefuse() {
        dismiss(animated: true)
    }
}
