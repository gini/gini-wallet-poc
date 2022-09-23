//
//  WalletViewModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

struct SectionModel {
    var title: String
    var isUpcoming: Bool
    var cellModels: [TransactionCellModel]
    var canSchedulePayment: Bool = false
    var backGroundColor: UIColor = .white
}

// MARK: - asta e pt comunicarea inspre VC
protocol WalletViewUpdater: AnyObject {
    func reloadData()
}

class WalletViewModel {
    
    var sectionModels: [SectionModel]
    
    var paidTransactions: [Transaction] = []
    var upcomingTransactions: [Transaction] = [] 
    
    weak var viewUpdater: WalletViewUpdater?
    
    init() {
        paidTransactions = [
            Transaction(merchantName: "Zalando", value: 123, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Telekom", value: 50, merchantLogo: Asset.Images.telekom.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Zalando", value: 1234.9999, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
        ]
        
        sectionModels = [
            SectionModel(title: L10n.today, isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .paid)})
        ]
        // MARK: - de aici incepe :-?
        getData()
    }
    
    func getData() {

    }
    
    var upcomingTransactionCellModels: [TransactionCellModel] {
        var cellModels: [TransactionCellModel] = []
        upcomingTransactions.forEach { transaction in
            if case .installment(let total, let paid) = transaction.type {
                cellModels.append(TransactionCellModel(transaction: transaction, type: .scheduledUpcoming(totalInstallments: total, paidInstallments: paid)))
            } else {
                cellModels.append(TransactionCellModel(transaction: transaction, type: .open))
            }
        }
        return cellModels
    }
    
    var paidTransactionCellModels: [TransactionCellModel] {
        var cellModels: [TransactionCellModel] = []
        paidTransactions.forEach { transaction in
            if case .installment(let total, let paid) = transaction.type, total == paid {
                cellModels.append(TransactionCellModel(transaction: transaction, type: .scheduledPaid))
            } else {
                cellModels.append(TransactionCellModel(transaction: transaction, type: .paid))
            }
        }
        return cellModels
    }
    
    func updateList(with transaction: Transaction, at index: Int) {
        if case .installment(let total, let paid) = transaction.type, total == paid {
            let cellModel = TransactionCellModel(transaction: transaction, type: .scheduledPaid)
            upcomingTransactions.remove(at: index)
            paidTransactions.reverse()
            paidTransactions.append(transaction)
            paidTransactions.reverse()
        } else {
            upcomingTransactions.remove(at: index)
            upcomingTransactions.insert(transaction, at: index)
        }
        
        sectionModels = []
        if !upcomingTransactions.isEmpty {
            sectionModels.append(SectionModel(title: L10n.openPayments, isUpcoming: true, cellModels: upcomingTransactionCellModels))
        }
        if !paidTransactions.isEmpty {
            sectionModels.append(SectionModel(title: L10n.today, isUpcoming: false, cellModels: paidTransactionCellModels))
        }
    }
}

extension WalletViewModel: DataViewUpdater {
    func updateTransactionList(transaction: Transaction) {
        switch transaction.type {
        case .paid:
            paidTransactions = paidTransactions.reversed()
            paidTransactions.append(transaction)
            paidTransactions = paidTransactions.reversed()
            sectionModels = []
            if !upcomingTransactions.isEmpty {
                sectionModels.append(SectionModel(title: L10n.openPayments, isUpcoming: true, cellModels: upcomingTransactionCellModels))
            }
            sectionModels.append(SectionModel(title: L10n.today isUpcoming: false, cellModels: paidTransactionCellModels))
            viewUpdater?.reloadData()
            
        case .upcoming:
            upcomingTransactions = upcomingTransactions.reversed()
            upcomingTransactions.append(transaction)
            upcomingTransactions = upcomingTransactions.reversed()
            sectionModels = []
            
            sectionModels.append(SectionModel(title: L10n.openPayments, isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .open)}))
            if !paidTransactions.isEmpty {
                sectionModels.append(SectionModel(title: L10n.today, isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .paid)}))
            }
            viewUpdater?.reloadData()
            
        case.installment(let total, let paid):
            if total > paid {
                // It is not paid in total yet
                upcomingTransactions = upcomingTransactions.reversed()
                upcomingTransactions.append(transaction)
                upcomingTransactions = upcomingTransactions.reversed()
                sectionModels = []
                
                sectionModels.append(SectionModel(title: L10n.openPayments, isUpcoming: true, cellModels: upcomingTransactionCellModels))
                if !paidTransactions.isEmpty {
                    sectionModels.append(SectionModel(title: L10n.today, isUpcoming: false, cellModels: paidTransactionCellModels))
                }
                viewUpdater?.reloadData()
                
            } else {
                // It is actually paid
                paidTransactions = paidTransactions.reversed()
                paidTransactions.append(transaction)
                paidTransactions = paidTransactions.reversed()
                sectionModels = []
                if !upcomingTransactions.isEmpty {
                    sectionModels.append(SectionModel(title: L10n.openPayments, isUpcoming: true, cellModels: upcomingTransactionCellModels))
                }
                sectionModels.append(SectionModel(title: L10n.today, isUpcoming: false, cellModels: paidTransactionCellModels))
                viewUpdater?.reloadData()
            }
        }
    }
}
