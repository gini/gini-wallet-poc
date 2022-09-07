//
//  PaymentViewModel.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import UIKit

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

}

class PaymentViewModelImpl: PaymentViewModel {
    
    var titleText = "Online payment"
    var fromText = "From"
    
    var userAccountText = "Savings Account"
    
    var userAccountNumber = "DE23 3701 0044 1344 8291 01"
    
    var userAccountAmount = "€6.231,40"
    
    var toText = "To"
    
    var merchantNameText = "Zalando AG"
    var merchantIban = "DE 88762181787817687"
    var merchantInvoice = "Ref: Invoice #378981798"
    var invoiceText = "Invoice"
    var priceText = "€255.00"
    var payNowText = "Pay now"
    var payLaterText = "Pay later"
    var refuseText = "Refuse"
    var installmentsText = "Installments"
    
    
}
