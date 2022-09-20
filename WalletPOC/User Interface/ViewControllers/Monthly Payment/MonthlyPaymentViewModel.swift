//
//  MonthlyPaymentViewModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 13.09.2022.
//

import Foundation

final class MonthlyPaymentViewModel {
    
    var sectionModels: [SectionModel] = []
    
    private var paidTransactions: [Transaction] = []
    private var upcomingTransactions: [Transaction] = []
    
    private var totalMonths: Int
    private var paidMonths: Int
    var totalAmount: Double
    private var amountPerMonth: Double
    
    var totalAmountText: String? {
        return "- €\(String(format: "%.2f", totalAmount))"
    }
    
    init(totalMonths: Int, paidMonths: Int, totalAmount: Double) {
        self.totalAmount = totalAmount
        self.totalMonths = totalMonths
        self.paidMonths = paidMonths
        
        amountPerMonth = totalAmount / Double(totalMonths)
        
        setupPaidTransactions()
        setupUpcomingTransaction()
        
        sectionModels = [
            SectionModel(title: "Upcoming", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .scheduledUpcoming(totalInstallments: 3, paidInstallments: 2))}, canSchedulePayment: true, backGroundColor: .yellow),
            SectionModel(title: "Paid so far", isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .scheduledPaid)})
        ]
    }
    
    private func setupPaidTransactions() {
        for i in 1...paidMonths {
            let date = Calendar.current.date(byAdding: .month, value: -i, to: Date())
            paidTransactions.append(Transaction(merchantName: "Zalando", value: amountPerMonth, merchantLogo: Asset.Images.zalando.image, dueDate: date, mention: ""))
        }
    }
    
    private func setupUpcomingTransaction() {
        let date = Calendar.current.date(byAdding: .day, value: 10, to: Date())
        upcomingTransactions = [
            Transaction(merchantName: "Zalando", value: amountPerMonth, merchantLogo: Asset.Images.zalando.image, dueDate: date, mention: "")
        ]
    }
}
