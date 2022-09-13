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
    var merchantName: String
    var value: Double
    var merchantLogo: UIImage?
    var dueDate: Date?
    var mention: String?
}
