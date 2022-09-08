//
//  SchedulePaymentCellModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 08.09.2022.
//

import Foundation

class SchedulePaymentCellModel {
    
    var consignee: String
    var isChecked: Bool
    var dateString: String {
        return formatDate()
    }
    var amountString: String {
        return "- €\(String(format: "%.2f", amount))"
    }
    
    private let amount: Double
    private let date: Date
    
    init(amount: Double, date: Date, consignee: String, isChecked: Bool) {
        self.amount = amount
        self.date = date
        self.consignee = consignee
        self.isChecked = isChecked
    }
    
    private func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}
