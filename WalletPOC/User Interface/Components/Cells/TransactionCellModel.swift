//
//  TransactionCellModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

class TransactionCellModel {
    
    enum TransactionType {
        case paid, open, recurring, scheduledUpcoming(totalInstallments: Int, paidInstallments: Int), scheduledPaid, simple
        
        var sideIcon: UIImage? {
            switch self {
            case .paid, .scheduledPaid: return Asset.Images.paid.image
            case .open: return Asset.Images.open.image
            case .scheduledUpcoming: return Asset.Images.recurring.image
            default: return nil
            }
        }
        
        var logoBorderColor: UIColor {
            switch self {
            case .paid, .scheduledUpcoming, .scheduledPaid, .simple: return .borderColor
            case .open, .recurring: return .brightYellow
            }
        }
        
        var amountTextColor: UIColor {
            switch self {
            case .paid, .scheduledPaid, .simple: return .primaryText
            case .open, .recurring, .scheduledUpcoming: return .yellowText
            }
        }
        
        var infoTextColor: UIColor {
            switch self {
            case .paid, .scheduledPaid, .simple: return .secondaryText
            case .open, .recurring, .scheduledUpcoming: return .yellowText
            }
        }
    }
    
    private var transaction: Transaction
    
    var type: TransactionType
    var title: String
    var message: String = ""
    var amount: String
    var typeIcon: UIImage?
    var logo: UIImage?
    
    init(transaction: Transaction, type: TransactionType) {
        self.transaction = transaction
        self.type = type
        
        title = transaction.merchantName
        amount = "- €\(String(format: "%.2f", transaction.value))".replacingOccurrences(of: ".", with: ",")
        logo = transaction.merchantLogo
        
        switch type {
        case .paid, .scheduledPaid:
            message = NSLocalizedString("online_shopping", comment: "online_shopping")
        case .open:
            if let dueDate = transaction.dueDate {
                message = NSLocalizedString("due_date_transactioncell", comment: "due_date_transactioncell") + " \(format(date: dueDate))"
            }
        case .recurring, .scheduledUpcoming:
            if let dueDate = transaction.dueDate {
                message = NSLocalizedString("monthly_next", comment: "monthly_next") + " \(format(date: dueDate))"
            }
        case .simple:
            if let dueDate = transaction.dueDate {
                message = format(date: dueDate)
            }
        }
    }
    
    private func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}
