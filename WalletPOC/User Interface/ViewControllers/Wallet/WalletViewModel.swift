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

class WalletViewModel {
    
    var sectionModels: [SectionModel]
    
    private var paidTransactions: [Transaction]
    private var upcomingTransactions: [Transaction]
    
    init() {
        paidTransactions = [
            Transaction(merchantName: "Zalando", value: 123, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Telekom", value: 50, merchantLogo: Asset.Images.telekom.image, dueDate: Date(), mention: ""),
            Transaction(merchantName: "Zalando", value: 1234.9999, merchantLogo: Asset.Images.zalando.image, dueDate: Date(), mention: ""),
        ]
        
        let futureDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        upcomingTransactions = [
            Transaction(merchantName: "Rainbow store", value: 190, merchantLogo: Asset.Images.rainbowStore.image, dueDate: futureDate, mention: ""),
            Transaction(merchantName: "Rainbow store", value: 49.999, merchantLogo: Asset.Images.rainbowStore.image, dueDate: futureDate, mention: "")
        ]
        
        sectionModels = [
            SectionModel(title: "Open payments", isUpcoming: true, cellModels: upcomingTransactions.map { TransactionCellModel(transaction: $0, type: .open)}),
            SectionModel(title: "Today", isUpcoming: false, cellModels: paidTransactions.map { TransactionCellModel(transaction: $0, type: .paid)})
        ]
    }
}
