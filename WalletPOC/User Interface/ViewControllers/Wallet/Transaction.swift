//
//  Transaction.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

// NOTE: this will probably have a totally different format
// + more information attached for recurring, upcoming, automatic payments
struct Transaction {
    var id = ""
    var merchantName: String
    var value: Double
    var merchantLogo: UIImage?
    var dueDate: Date?
    var mention: String?
    var type: TransactionType = .paid
    var account: Account = Account(id: "1", name: "Main Account", iban: "DE23 3701 0044 2344 8191 02", amount: "€3.111,03")
    var merchantIban: String = "DE86 2107 0020 0123 0101 01"
}

enum TransactionType {
    case paid, upcoming, installment(total: Int, paid: Int)
}
