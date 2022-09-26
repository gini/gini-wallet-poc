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
    case installment(total: Int, paid: Int)
    case paid
    
    var title: String {
        switch(self) {
        case .installment:
            return L10n.nextInstallment
        default:
            return L10n.onlinePayment
        }
    }
    
    var subtitle: String {
        switch(self) {
        case .installment(let total, let paid):
            return "\(paid + 1) \(L10n.of) \(total)"
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
    var userAccountText: String? { get }
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
    var selectedAccount: Account? { get set }
    var type: PaymentViewModelType { get }
    var transactionViewModel: TransactionViewModel { get }
    var transaction: Transaction { get set }
    var transactionId: String { get }
    var dateText: String { get }
    
    var nrOfInstallments: Int? { get set }
    
    var amountPerThreeMonths: Double { get }
    var amountPerSixMonths: Double { get }
    var amountPerNineMonths: Double { get }
}

class PaymentViewModelImpl: PaymentViewModel {
        
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
        self.transaction.id = transactionViewModel.transactionId
    }
    
    var titleText: String {
        type.title
    }
    
    var subtitleText: String {
        type.subtitle
    }
        
    var fromText = L10n.fromPaymentvc
    
    var userAccountText = AccountConstants.accountsArray.first?.name
    
    var userAccountNumber = "DE23 3701 0044 1344 8291 01"
    
    var userAccountAmount = "€6.231,40"
    
    var toText = L10n.to
    
    var merchantNameText = "Rainbow Store"
    var merchantIban = "DE86 2107 0020 0123 0101 01"
    var merchantInvoice = "Ref: \(L10n.invoice) #378981798"
    var invoiceText = L10n.invoice
    
    var priceText: String {
        if case .installment(let total, _) = type {
            return "€\(String(format: "%.2f", transaction.value / Double(total)))".replacingOccurrences(of: ".", with: ",")
        }
        
        if let nrOfInstallments = nrOfInstallments {
            return "€\(String(format: "%.2f", transaction.value / Double(nrOfInstallments))) / mo".replacingOccurrences(of: ".", with: ",")
        }
        return "€\(String(format: "%.2f", transaction.value))".replacingOccurrences(of: ".", with: ",")
    }
    var payNowText = L10n.payNowPaymentvc
    var payLaterText =  L10n.payLaterPaymentvc
    var refuseText = L10n.refuse
    var installmentsText = L10n.installmentsPaymentvc
    var acceptText = L10n.acceptPaymentvc
    var termsConditionsText = L10n.termsConditions
    
    var viewUpdater: PaymentViewUpdater?
    var selectedAccount = AccountConstants.accountsArray.last
    var dateText: String {
        if case .installment(_, let paid) = type {
            if let date = Calendar.current.date(byAdding: .month, value: paid, to: Date()) {
                return format(date: date)
            }
            return ""
        }
        return ""
    }
    
    var nrOfInstallments: Int?
    
    var amountPerThreeMonths: Double {
        return transaction.value / 3
    }
    var amountPerSixMonths: Double {
        return transaction.value / 6
    }
    var amountPerNineMonths: Double {
        return transaction.value / 9
    }
    
    private func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}
