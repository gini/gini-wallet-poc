//
//  InvoiceViewController.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import Foundation
import UIKit
import PDFKit

class PaymentViewController: UIViewController, XMLParserDelegate {
    
    private let titleLabel = UILabel.autoLayout()
    private let fromLabel = UILabel.autoLayout()
    private let toLabel = UILabel.autoLayout()
    private let invoiceLabel = UILabel.autoLayout()
    
    private let grayView = UIView.autoLayout()
    private let userAccountLabel = UILabel.autoLayout()
    private let fromAccountLabel = UILabel.autoLayout()
    private let fromAmountLabel = UILabel.autoLayout()
    private let switchAccountButton = UIButton.autoLayout()
    
    private let tinyView = UIView.autoLayout()
    
    
    private let grayViewSecond = UIView.autoLayout()
    private let merchantAccountLabel = UILabel.autoLayout()
    private let toAccountLabel = UILabel.autoLayout()
    private let merchantInvoice = UILabel.autoLayout()
    private let merchantLogo = UIButton.autoLayout()
    
    private let pdfView = PDFView.autoLayout()
    private let scrollView = UIScrollView.autoLayout()
    private let contentView = UIView.autoLayout()
    
    private let bottomView = UIView.autoLayout()
    private let amountLabel = UILabel.autoLayout()
    private let payNowButton = UIButton.autoLayout()
    private let payLaterButton = UIButton.autoLayout()
    private let refuseButton = UIButton.autoLayout()
    
    private let payFullButton = UIButton.autoLayout()
    private let buyNowPayLaterButton = UIButton.autoLayout()
    private let installmentsLabel = UILabel.autoLayout()
    
    private let threeMonthButton = UIButton.autoLayout()
    private let threeMonthLineOnelabel = UILabel.autoLayout()
    private let threeMonthLineTwoLabel = UILabel.autoLayout()
    
    private let sixMonthsButton = UIButton.autoLayout()
    private let sixMonthsLineOnelabel = UILabel.autoLayout()
    private let sixMonthsLineTwoLabel = UILabel.autoLayout()
    
    private let acceptLabel = UILabel.autoLayout()
    private let termsConditionsButton = UIButton.autoLayout()

    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    
    var facts = [Account]()

    private let viewModel: PaymentViewModel
        
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
        loadMerchantData()
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
        
        grayView.backgroundColor = .lightGray
        //mocked
        userAccountLabel.text = viewModel.userAccountText
        userAccountLabel.textColor = .gray
        
        fromAccountLabel.text = viewModel.userAccountNumber
        fromAccountLabel.textColor = .gray
        
        fromAmountLabel.text = viewModel.userAccountAmount
        fromAmountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        fromAmountLabel.textColor = .black
        
        switchAccountButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        switchAccountButton.tintColor = .black
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        grayView.addGestureRecognizer(tap)
        
        grayViewSecond.backgroundColor = .lightGray
        merchantAccountLabel.text = viewModel.merchantNameText
        merchantAccountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)

        toAccountLabel.text  = viewModel.merchantIban
        toAccountLabel.textColor = .gray
        merchantInvoice.text = viewModel.merchantInvoice
        merchantInvoice.textColor = .gray
        
        merchantLogo.setImage(UIImage(named: "zalandoLogo"), for: .normal)
        
        tinyView.backgroundColor = .lightGray
        
        pdfView.autoScales = true

        contentView.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true
        
        bottomView.backgroundColor = .white
        amountLabel.text = "€255.00"
        amountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 32)

        payNowButton.setTitle("Pay Now", for: .normal)
        payNowButton.backgroundColor = .blue
        payNowButton.layer.cornerRadius = 5
        payNowButton.layer.borderWidth = 1
        payNowButton.layer.borderColor = UIColor.lightGray.cgColor
        payNowButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        payLaterButton.setTitle("Pay Later", for: .normal)
        payLaterButton.layer.cornerRadius = 5
        payLaterButton.layer.borderWidth = 1
        payLaterButton.layer.borderColor = UIColor.lightGray.cgColor
        payLaterButton.backgroundColor = .clear
        payLaterButton.setTitleColor(.gray, for: .normal)
        payLaterButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        payFullButton.titleLabel?.lineBreakMode = .byWordWrapping
        payFullButton.titleLabel?.textAlignment = .center
        payFullButton.setTitle("Pay now \n in full", for: .normal)
        payFullButton.layer.cornerRadius = 5
        payFullButton.layer.borderWidth = 1
        payFullButton.layer.borderColor = UIColor.lightGray.cgColor
        payFullButton.backgroundColor = .clear
        payFullButton.setTitleColor(.black, for: .normal)
        payFullButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        payFullButton.addTarget(self, action: #selector(didTaptest), for: .touchUpInside)
        
        buyNowPayLaterButton.titleLabel?.lineBreakMode = .byWordWrapping
        buyNowPayLaterButton.titleLabel?.textAlignment = .center
        buyNowPayLaterButton.setTitle("Buy now, \n Pay later", for: .normal)
        buyNowPayLaterButton.layer.cornerRadius = 5
        buyNowPayLaterButton.layer.borderWidth = 1
        buyNowPayLaterButton.layer.borderColor = UIColor.lightGray.cgColor
        buyNowPayLaterButton.backgroundColor = .clear
        buyNowPayLaterButton.setTitleColor(.black, for: .normal)
        buyNowPayLaterButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        installmentsLabel.text = viewModel.installmentsText
        installmentsLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        installmentsLabel.textAlignment = .left
        
        threeMonthLineOnelabel.text = "€85 / mo."
        threeMonthLineOnelabel.textColor = .black
        threeMonthLineOnelabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        threeMonthLineOnelabel.textAlignment = .center
                        
        threeMonthLineTwoLabel.text = "for 3 months"
        threeMonthLineTwoLabel.textColor = .gray
        threeMonthLineTwoLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        threeMonthLineTwoLabel.textAlignment = .center

        threeMonthButton.layer.cornerRadius = 5
        threeMonthButton.layer.borderWidth = 1
        threeMonthButton.layer.borderColor = UIColor.lightGray.cgColor
        threeMonthButton.backgroundColor = .clear

        threeMonthButton.addSubview(threeMonthLineOnelabel)
        threeMonthButton.insertSubview(threeMonthLineTwoLabel, belowSubview: threeMonthLineOnelabel)
        
        sixMonthsLineOnelabel.text = "€42.5 / mo."
        sixMonthsLineOnelabel.textColor = .black
        sixMonthsLineOnelabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        sixMonthsLineOnelabel.textAlignment = .center
        sixMonthsLineTwoLabel.text = "for 6 months"
        sixMonthsLineTwoLabel.textColor = .gray
        sixMonthsLineTwoLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        sixMonthsLineTwoLabel.textAlignment = .center
        
        sixMonthsButton.layer.cornerRadius = 5
        sixMonthsButton.layer.borderWidth = 1
        sixMonthsButton.layer.borderColor = UIColor.lightGray.cgColor
        sixMonthsButton.backgroundColor = .clear

        sixMonthsButton.addSubview(sixMonthsLineOnelabel)
        sixMonthsButton.insertSubview(sixMonthsLineTwoLabel, belowSubview: sixMonthsLineOnelabel)
        
      
        acceptLabel.text = "I accept the"
        acceptLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        termsConditionsButton.setTitle("Terms and Conditions", for: .normal)
        termsConditionsButton.setTitleColor(.blue, for: .normal)
        termsConditionsButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        
        refuseButton.setTitle("Refuse", for: .normal)
        refuseButton.setTitleColor(.gray, for: .normal)
        
        view.addSubview(bottomView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [titleLabel, fromLabel, toLabel, grayView, grayViewSecond, tinyView, invoiceLabel, pdfView, payFullButton, buyNowPayLaterButton, installmentsLabel, threeMonthButton, sixMonthsButton, acceptLabel, termsConditionsButton].forEach { contentView.addSubview($0) }
        
        [userAccountLabel, fromAccountLabel, fromAmountLabel, switchAccountButton].forEach{ grayView.addSubview($0) }
        
        [merchantAccountLabel, toAccountLabel, merchantInvoice, merchantLogo].forEach{ grayViewSecond.addSubview($0) }
        
        [amountLabel, payNowButton, payLaterButton, refuseButton].forEach{ bottomView.addSubview($0) }
        
        guard let path = Bundle.main.url(forResource: "pdfMock2", withExtension: "pdf") else {
            return }

        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
    }
    
    private func setupConstraints() {
        
        let constraints = [
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            amountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            amountLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: payNowButton.topAnchor, constant: -10),
            
            payNowButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 2/3),
            payNowButton.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15),
            payNowButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            payNowButton.heightAnchor.constraint(equalToConstant: 50),

            
            payLaterButton.centerYAnchor.constraint(equalTo: payNowButton.centerYAnchor),
            payNowButton.leadingAnchor.constraint(greaterThanOrEqualTo: payLaterButton.trailingAnchor, constant: 10),
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
            
            grayView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 20),
            grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            grayView.heightAnchor.constraint(equalToConstant: 100),
            
            userAccountLabel.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 15),
            userAccountLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 15),
            userAccountLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            fromAccountLabel.topAnchor.constraint(equalTo: userAccountLabel.bottomAnchor, constant: 5),
            fromAccountLabel.leadingAnchor.constraint(equalTo: userAccountLabel.leadingAnchor),
            
            fromAmountLabel.topAnchor.constraint(equalTo: fromAccountLabel.bottomAnchor, constant: 5),
            fromAmountLabel.leadingAnchor.constraint(equalTo: userAccountLabel.leadingAnchor),
            
            switchAccountButton.centerYAnchor.constraint(equalTo: grayView.centerYAnchor),
            switchAccountButton.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -15),
            switchAccountButton.widthAnchor.constraint(equalToConstant: 40),
            switchAccountButton.heightAnchor.constraint(equalToConstant: 40),
            
            payFullButton.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 10),
            payFullButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            payFullButton.heightAnchor.constraint(equalToConstant: 70),
            payFullButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            
            buyNowPayLaterButton.centerYAnchor.constraint(equalTo: payFullButton.centerYAnchor),
            buyNowPayLaterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buyNowPayLaterButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            buyNowPayLaterButton.heightAnchor.constraint(equalTo: payFullButton.heightAnchor),
            
            installmentsLabel.topAnchor.constraint(equalTo: payFullButton.bottomAnchor, constant: 15),
            installmentsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            threeMonthButton.topAnchor.constraint(equalTo: installmentsLabel.bottomAnchor, constant: 20),
            threeMonthButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            threeMonthButton.heightAnchor.constraint(equalToConstant: 70),
            threeMonthButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            
            threeMonthLineOnelabel.topAnchor.constraint(equalTo: threeMonthButton.topAnchor, constant: 15),
            threeMonthLineOnelabel.centerXAnchor.constraint(equalTo: threeMonthButton.centerXAnchor),
            
            threeMonthLineTwoLabel.centerXAnchor.constraint(equalTo: threeMonthLineOnelabel.centerXAnchor),
            threeMonthLineTwoLabel.bottomAnchor.constraint(equalTo: threeMonthButton.bottomAnchor, constant: -15),
            
            sixMonthsButton.centerYAnchor.constraint(equalTo: threeMonthButton.centerYAnchor),
            sixMonthsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sixMonthsButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2 - 25),
            sixMonthsButton.heightAnchor.constraint(equalTo: threeMonthButton.heightAnchor),
            
            sixMonthsLineOnelabel.topAnchor.constraint(equalTo: sixMonthsButton.topAnchor, constant: 15),
            sixMonthsLineOnelabel.centerXAnchor.constraint(equalTo: sixMonthsButton.centerXAnchor),
            
            sixMonthsLineTwoLabel.centerXAnchor.constraint(equalTo: sixMonthsLineOnelabel.centerXAnchor),
            sixMonthsLineTwoLabel.bottomAnchor.constraint(equalTo: sixMonthsButton.bottomAnchor, constant: -15),
            
            acceptLabel.topAnchor.constraint(equalTo: threeMonthButton.bottomAnchor, constant: 20),
            acceptLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            
            termsConditionsButton.centerYAnchor.constraint(equalTo: acceptLabel.centerYAnchor),
            termsConditionsButton.leadingAnchor.constraint(equalTo: acceptLabel.trailingAnchor, constant: 5),
            
            tinyView.topAnchor.constraint(equalTo: acceptLabel.bottomAnchor, constant: 20),
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
            
            merchantInvoice.topAnchor.constraint(equalTo: toAccountLabel.bottomAnchor, constant: 5),
            merchantInvoice.leadingAnchor.constraint(equalTo: merchantAccountLabel.leadingAnchor),
            
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
            pdfView.heightAnchor.constraint(equalToConstant: 400),

            ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func loadMerchantData() {
        let xmlResponseData = Bundle.main.getFileData("DS-01.xml")
        let parser = XMLParser(data: xmlResponseData)
        parser.delegate = self
        parser.parse()
    }
    
    /* In this method we will be notified of the start of the process and the start of each element tag.*/
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "IBAN" {
            xmlDict = [:]
        } else {
            currentElement = elementName
        }
    }
    
    /* In this method, we are notified of the values of the element tag through the parameter of string*/
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if xmlDict[currentElement] == nil {
                   xmlDict.updateValue(string, forKey: currentElement)
            }
        }
    }
    /* This method is called on encountering the closing tag of an element. Whether it is the current element or not, is for us to judge.*/
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "IBAN" {
                xmlDictArr.append(xmlDict)
        }
    }
    
    /* This method is called when the complete document has ended and the parser has encountered a closing root tag.*/
    func parserDidEndDocument(_ parser: XMLParser) {
         parsingCompleted()
    }
    
    /* In the parserDidEndDocument method we can call our user defined method where we map the dictionary we have created into the data model we require. So the parsingCompleted() method will be written like so:*/
    func parsingCompleted() {
        self.facts = self.xmlDictArr.map { Account(details: $0) }
        
        print(xmlDictArr)
        
        print(facts)
        //self.updateUI()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        present(AccountSwitchViewController(), animated: true)
        
    }
    
    @objc private func didTaptest() {
        let vc = AlertViewController()
        let subview = SchedulePaymentsAlertView(viewModel: SchedulePaymentsAlertViewModel(numberOfSchedules: 9, totalAmount: 300, consignee: "Vileda"))
        subview.delegate = self
        
        vc.modalPresentationStyle = .overFullScreen
        vc.populate(with: subview)
        self.present(vc, animated: true)
    }
}

extension PaymentViewController: SchedulePaymentsAlertViewDelegate {
    func didConfirm(isScheduled: Bool, checkedCellModels: [SchedulePaymentCellModel]) {
        print(isScheduled)
        print(checkedCellModels.map { $0.dateString })
        dismiss(animated: true)
    }
}

extension Bundle {
    func getFileData(_ file: String) -> Data {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle")
        }
        
        return data
    }
}
