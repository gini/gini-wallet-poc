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

    var xmlDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    
    var facts = [Account]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        loadMerchantData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Online Payment"
        titleLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 18)
        titleLabel.textAlignment = .left
        
        toLabel.text = "To"
        toLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        toLabel.textAlignment = .left

        fromLabel.text = "From"
        fromLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        fromLabel.textAlignment = .left
        
        invoiceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        invoiceLabel.text = "Invoice"
        
        
        grayView.backgroundColor = .lightGray
        //mocked
        savingsAccountLabel.text = "Savings Account"
        savingsAccountLabel.textColor = .gray
        
        fromAccountLabel.text = "DE23 3701 0044 1344 8291 01"
        fromAccountLabel.textColor = .gray
        
        fromAmountLabel.text = "€6.231,40"
        fromAmountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)
        fromAmountLabel.textColor = .black
        
        switchAccountButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        switchAccountButton.tintColor = .black
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        grayView.addGestureRecognizer(tap)
        
        
        grayViewSecond.backgroundColor = .lightGray
        merchantAccountLabel.text = "Zalando AG"
        merchantAccountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 14)

        toAccountLabel.text  = "DE 88762181787817687"
        toAccountLabel.textColor = .gray
        toAmountLabel.text = "Ref: Invoice #378981798"
        toAmountLabel.textColor = .gray
        
        
        merchantLogo.setImage(UIImage(named: "zalandoLogo"), for: .normal)
        
        
        tinyView.backgroundColor = .lightGray
        
        pdfView.autoScales = true

        contentView.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.isScrollEnabled = true

        view.backgroundColor = .blue
        
        bottomView.backgroundColor = .white
        amountLabel.text = "€255.00"
        amountLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 32)

        
        payNowButton.setTitle("Pay Now", for: .normal)
        payNowButton.setTitleColor(.gray, for: .normal)
        //payNowButton.backgroundColor = .green
        payNowButton.backgroundColor = .clear
        payNowButton.layer.cornerRadius = 5
        payNowButton.layer.borderWidth = 1
        payNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        payLaterButton.setTitle("Pay Later", for: .normal)
        //payLaterButton.backgroundColor = .clear
        payLaterButton.layer.cornerRadius = 5
        payLaterButton.layer.borderWidth = 1
        payLaterButton.layer.borderColor = UIColor.black.cgColor
        payLaterButton.backgroundColor = .blue
        
        refuseButton.setTitle("Refuse", for: .normal)
        refuseButton.setTitleColor(.gray, for: .normal)
        
        
        
        /*
         paymentMethodLabel.font = UIFont(name: "PlusJakartaSans-Bold", size: 18)
         paymentMethodLabel.textAlignment = .left
         paymentMethodLabel.text = "Payment Method"
         
         */
        
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
            amountLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            
            payNowButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 2/3),
            payNowButton.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 15),
            payNowButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            
            payLaterButton.centerYAnchor.constraint(equalTo: payNowButton.centerYAnchor),
            payNowButton.leadingAnchor.constraint(greaterThanOrEqualTo: payLaterButton.trailingAnchor, constant: 10),
            payLaterButton.widthAnchor.constraint(equalToConstant: (view.frame.size.width - 50) * 1/3),
            payLaterButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            
            refuseButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            refuseButton.topAnchor.constraint(equalTo: payLaterButton.bottomAnchor, constant: 6),
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
    
    func loadMerchantData() {
        let xmlResponseData = Bundle.main.getFileData("DS-01.xml")
        let parser = XMLParser(data: xmlResponseData)
        parser.delegate = self
        parser.parse()
    }
    
    /* In this method we will be notified of the start of the process and the start of each element tag.*/
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "element" {
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
        if elementName == "element" {
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
        
        print(facts)
        //self.updateUI()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        present(AccountSwitchViewController(), animated: true)
        
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
