//
//  PaymentViewModel.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import UIKit

enum PaymentViewModelType {
    case buyNow
    case buyLater
    case installment
    
    var title: String {
        switch(self) {
        case .installment:
            return "Next installment"
        default:
            return "Online payment"
        }
    }
    
    var subtitle: String {
        switch(self) {
        case .installment:
            return "3 of 3"
        default:
            return ""
        }
    }
}

protocol PaymentViewUpdater {
    func reloadData()
}

protocol PaymentViewModel {
    var titleText: String { get }
    var subtitleText: String { get }

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
    var type: PaymentViewModelType { get }
    var transactionViewModel: TransactionViewModel { get }
    var transaction: Transaction { get set }
    var transactionId: String { get }
    
    //var type: PaymentViewModelType { get }
}

class PaymentViewModelImpl: PaymentViewModel {
    //var viewModelType: PaymentViewModelType
    
    
    var transaction: Transaction
    let type: PaymentViewModelType
    let transactionViewModel: TransactionViewModel
    var transactionId: String
    
    init(type: PaymentViewModelType, transactionViewModel: TransactionViewModel, transaction: Transaction) {
        self.type = type
        self.transactionViewModel = transactionViewModel
        self.transaction = transaction
        self.transaction.value = transactionViewModel.transactionAmount
        self.transactionId = transactionViewModel.transactionId
    }
    
//    init(type: PaymentViewModelType) {
//        self.type = type
//        transactionViewModel = TransactionViewModel(merchantAppScheme: "ds", transactionId: "ds", buyNowPayLater: "ds")
//    }
    
    //var titleText = "Olnine payment"
    
    var titleText: String {
        type.title
    }
    
    var subtitleText: String {
        type.subtitle
    }
        
    var fromText = "From"
    
    var userAccountText = "Savings Account"
    
    var userAccountNumber = "DE23 3701 0044 1344 8291 01"
    
    var userAccountAmount = "€6.231,40"
    
    var toText = "To"
    
    var merchantNameText = "Rainbow Store"
    var merchantIban = "DE 88762181787817687"
    var merchantInvoice = "Ref: Invoice #378981798"
    var invoiceText = "Invoice"
    var priceText: String {
        return "€ \(String(format: "%.2f", transaction.value))"
    }
    var payNowText = "Pay now"
    var payLaterText = "Pay later"
    var refuseText = "Refuse"
    var installmentsText = "Installments"
    var acceptText = "I accept the"
    var termsConditionsText = "Terms and Conditions"
    
    var viewUpdater: PaymentViewUpdater?
    var selectedAccount = Account(id: "2", name: "Savings Account", iban: "DE23 3701 0044 1344 8291 01", amount: "€6.231,40")
    
}
