//
//  PaymentViewModel.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import UIKit

protocol PaymentViewUpdater {
    func reloadData()
}

protocol PaymentViewModel {
    var titleText: String { get }
    var fromText: String { get }
    var userAccountText: String { get }
    var userAccountNumber: String { get }
    var userAccountAmount: String { get }
    
    var toText: String { get }
    var merchantNameText: String { get }
    var merchantIban: String { get }
    var merchantInvoice: String { get }
    
    var invoiceText: String { get }
    var priceText: String { get }
    var payNowText: String { get }
    var payLaterText: String { get }
    var refuseText: String { get }
    var installmentsText: String { get }
    
    var acceptText: String { get }
    var termsConditionsText: String { get }
    var viewUpdater: PaymentViewUpdater? { get set }
    var selectedAccount: Account { get set }
}

class PaymentViewModelImpl: PaymentViewModel {
    
    var titleText = "Online payment"
    var fromText = "From"
    
    var userAccountText = "Savings Account"
    
    var userAccountNumber = "DE23 3701 0044 1344 8291 01"
    
    var userAccountAmount = "€6.231,40"
    
    var toText = "To"
    
    var merchantNameText = "Rainbow Store"
    var merchantIban = "DE 88762181787817687"
    var merchantInvoice = "Ref: Invoice #378981798"
    var invoiceText = "Invoice"
    var priceText = "€255.00"
    var payNowText = "Pay now"
    var payLaterText = "Pay later"
    var refuseText = "Refuse"
    var installmentsText = "Installments"
    var acceptText = "I accept the"
    var termsConditionsText = "Terms and Conditions"
    
    var viewUpdater: PaymentViewUpdater?
    var selectedAccount = Account(id: "2", name: "Savings Account", iban: "DE23 3701 0044 1344 8291 01", amount: "€6.231,40")
    //    var xmlDict = [String: Any]()
    //    var xmlDictArr = [[String: Any]]()
    //    var currentElement = ""
        //var facts = [Account]()
    
    //    //MARK: - XML Parsing
    //
    //    func loadMerchantData() {
    //        let xmlResponseData = Bundle.main.getFileData("DS-01.xml")
    //        let parser = XMLParser(data: xmlResponseData)
    //        parser.delegate = self
    //        parser.parse()
    //    }
    //
    //    /* In this method we will be notified of the start of the process and the start of each element tag.*/
    //    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    //        if elementName == "IBAN" {
    //            xmlDict = [:]
    //        } else {
    //            currentElement = elementName
    //        }
    //    }
    //
    //    /* In this method, we are notified of the values of the element tag through the parameter of string*/
    //    func parser(_ parser: XMLParser, foundCharacters string: String) {
    //        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
    //            if xmlDict[currentElement] == nil {
    //                   xmlDict.updateValue(string, forKey: currentElement)
    //            }
    //        }
    //    }
    //
    //    /* This method is called on encountering the closing tag of an element. Whether it is the current element or not, is for us to judge.*/
    //    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    //        if elementName == "IBAN" {
    //                xmlDictArr.append(xmlDict)
    //        }
    //    }
    //
    //    /* This method is called when the complete document has ended and the parser has encountered a closing root tag.*/
    //    func parserDidEndDocument(_ parser: XMLParser) {
    //         parsingCompleted()
    //    }
    //
    //    /* In the parserDidEndDocument method we can call our user defined method where we map the dictionary we have created into the data model we require. So the parsingCompleted() method will be written like so:*/
    //    func parsingCompleted() {
    //        self.facts = self.xmlDictArr.map { Account(details: $0) }
    //        print(xmlDictArr)
    //        print(facts)
    //        //self.updateUI()
    //    }

}

//extension PaymentViewModelImpl: AccountSwitchProtocol {
//    func sendDataforUpdate(account: Account) {
//        userAccountText = account.name
//        userAccountNumber = account.iban
//        userAccountAmount = account.amount
//        viewUpdater?.reloadData()
//    }
//}

//extension Bundle {
//    func getFileData(_ file: String) -> Data {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle")
//        }
//
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) in bundle")
//        }
//
//        return data
//    }
//}
