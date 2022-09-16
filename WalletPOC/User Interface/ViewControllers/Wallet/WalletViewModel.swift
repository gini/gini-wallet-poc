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
    
    private var paidTransactions: [Transaction] = []
    private var upcomingTransactions: [Transaction] = []
    
    weak var viewUpdater: WalletViewUpdater?
    
    init() {
        paidTransactions = [
            Transaction(merchantName: "Zalando", value: 123, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Telekom", value: 50, merchantLogo: Asset.Images.telekom.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Zalando", value: 1234.9999, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
        ]
        
//        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
//        upcomingTransactions = [
//            Transaction(merchantName: "Zalando", value: 190, merchantLogo: Asset.Images.zalando.image, dueDate: futureDate, mention: ""),
//            Transaction(merchantName: "Telekom", value: 49.999, merchantLogo: Asset.Images.telekom.image, dueDate: futureDate, mention: "")
//        ]
        
        sectionModels = [
//            SectionModel(title: "Open payments", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .open)}),
            SectionModel(title: "Today", isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .paid)})
        ]
        // MARK: - de aici incepe :-?
        getData()
    }
    
    func getData() {
        //teoretic ar terbui ceva instamna pt walletDelegate = self...dar mna..
//        let paymentVM = PaymentViewModelImpl(type: .buyLater)
//        let paymentVC = PaymentViewController(viewModel: paymentVM)
//        
//        paymentVC.walletDelegate = self
//        viewUpdater?.reloadData()
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
                sectionModels.append(SectionModel(title: "Open payments", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .open)}))
            }
            sectionModels.append(SectionModel(title: "Today", isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .paid)}))
            viewUpdater?.reloadData()
            
        case .upcoming:
            print("ok")
        case.installment(let total, let paid):
            print("ok")
        }
    }
}
