//
//  SchedulePaymentsAlertViewModel.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation

final class SchedulePaymentsAlertViewModel {
    
    // MARK: - Public properties
    
    var title: String {
        return "Schedule \(numberOfSchedules) payments"
    }
    var cellModels: [SchedulePaymentCellModel] = []
    var isScheduled: Bool = true {
        didSet {
            if !isScheduled {
                cellModels.forEach { $0.isChecked = false }
            }
            
            cellModels.forEach{ $0.isEnabled = isScheduled }
        }
    }
    
    var instructions: String {
        return isScheduled ? "Your remaining installments will be paid automatically on deadlines." : "You will need to pay all installments \nmanually."
    }
    
    // MARK: - Private properties
    
    private let numberOfSchedules: Int
    private let totalAmount: Double
    private let consignee: String
    
    // MARK: - Lifecycle
    
    init(numberOfSchedules: Int, totalAmount: Double, consignee: String) {
        self.numberOfSchedules = numberOfSchedules
        self.totalAmount = totalAmount
        self.consignee = consignee
        
        createCellModels()
    }
    
    private func createCellModels() {
        let amountPerMonth = totalAmount / Double(numberOfSchedules)
        for monthCount in 1...numberOfSchedules {
            let date = addMonths(count: monthCount)
            let cellModel = SchedulePaymentCellModel(amount: amountPerMonth, date: date, consignee: consignee, isChecked: true)
            cellModels.append(cellModel)
        }
    }
    
    private func addMonths(count: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: count, to: Date()) ?? Date()
    }
    
    func selectAll() {
        cellModels.forEach{ $0.isChecked = true }
    }
    
    func deselectAll() {
        cellModels.forEach{ $0.isChecked = false }
    }
    
    func cellSelectionChanged(cellModel: SchedulePaymentCellModel) {
        for index in cellModels.indices {
            let model = cellModels[index]
            if cellModel.dateString == model.dateString {
                model.isChecked = cellModel.isChecked
                cellModels[index] = model
            }
            break
        }
    }
    
    var checkedCellModels: [SchedulePaymentCellModel] {
        return cellModels.filter{ $0.isChecked }
    }
}


