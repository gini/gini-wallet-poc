//
//  MonthlyPaymentViewModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 13.09.2022.
//

import Foundation

protocol MonthlyPaymentViewUpdater: AnyObject {
    func reloadData()
    func update(with transaction: Transaction)
}

final class MonthlyPaymentViewModel {
    
    weak var delegate: MonthlyPaymentViewUpdater?
    
    var sectionModels: [SectionModel] = []
    
    private var upcomingTransactions: [Transaction] = []
    
    var totalMonths: Int
    var paidMonths: Int
    var totalAmount: Double
    private var amountPerMonth: Double
    var transaction: Transaction
    
    var totalAmountText: String? {
        return "€\(String(format: "%.2f", totalAmount))".replacingOccurrences(of: ".", with: ",")
    }
    
    var merchantIban = "DE86 2107 0020 0123 0101 01"
    
    init(totalMonths: Int, paidMonths: Int, transaction: Transaction) {
        self.transaction = transaction
        self.totalAmount = transaction.value
        self.totalMonths = totalMonths
        self.paidMonths = paidMonths
        
        amountPerMonth = totalAmount / Double(totalMonths)
        setupUpcomingTransaction()
        
        sectionModels = [
            SectionModel(title: "Upcoming", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .simple)}, canSchedulePayment: false, backGroundColor: .yellow),
        ]
    }
    
    private func setupUpcomingTransaction() {
        for i in 1...(totalMonths - paidMonths) {
            let date = Calendar.current.date(byAdding: .month, value: i, to: Date())
            upcomingTransactions.append(Transaction(merchantName: "Rainbow Store", value: amountPerMonth, merchantLogo: Asset.Images.rainbowStore.image, dueDate: date, mention: ""))
        }
    }
}

extension MonthlyPaymentViewModel: DataViewUpdater {
    
    func updateTransactionList(transaction: Transaction) {
        paidMonths += 1
        upcomingTransactions.removeFirst()
        sectionModels = [
            SectionModel(title: "Upcoming", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .simple)}, canSchedulePayment: false, backGroundColor: .yellow),
        ]
        delegate?.reloadData()
        delegate?.update(with: transaction)
    }
}
