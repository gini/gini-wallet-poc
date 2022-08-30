//
//  ErrorModel.swift
//  skeleton
//
//  Created by Botond Magyarosi on 25/02/2021.
//

import Foundation

struct ErrorModel: Identifiable {
    var id: UUID = UUID()
    let error: Error
}
