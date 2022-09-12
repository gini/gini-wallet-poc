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
        case paid, open, recurring, scheduledUpcoming, scheduledPaid
        
        var sideIcon: UIImage? {
            switch self {
            case .paid: return Asset.Images.paid.image
            case .open: return Asset.Images.open.image
            case .recurring: return Asset.Images.recurring.image
            default: return nil
            }
        }
        
        var logoBorderColor: UIColor {
            switch self {
            case .paid, .scheduledUpcoming, .scheduledPaid: return .borderColor
            case .open, .recurring: return .brightYellow
            }
        }
        
        var amountTextColor: UIColor {
            switch self {
            case .paid, .scheduledPaid: return .secondaryText
            case .open, .recurring, .scheduledUpcoming: return .yellowText
            }
        }
        
        var infoTextColor: UIColor {
            switch self {
            case .paid, .scheduledPaid: return .secondaryText
            case .scheduledUpcoming: return .purple
            case .open, .recurring: return .yellowText
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
        amount = "- €\(String(format: "%.2f", transaction.value))"
        logo = transaction.merchantLogo
        
        switch type {
        case .paid:
            message = "Online shopping"
        case .open:
            if let dueDate = transaction.dueDate {
                message = "Due \(format(date: dueDate))"
            }
        case .recurring:
            if let dueDate = transaction.dueDate {
                message = "Monthly: Next \(format(date: dueDate))"
            }
        case .scheduledUpcoming:
            if let dueDate = transaction.dueDate {
                message = format(date: dueDate)
            }
        case .scheduledPaid:
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
