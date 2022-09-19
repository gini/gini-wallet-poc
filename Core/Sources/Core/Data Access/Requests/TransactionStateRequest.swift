//
//  File.swift
//  
//
//  Created by Noemi Kalman on 18.09.2022.
//

import Foundation
import Alamofire

struct TransactionStateRequest: Request {
    var body: String?
    let path: String?
    let method: HTTPMethod
    
    init(transactionId: String) {
        path = APIConstants.Endpoints.Transactions.query.path + "\(transactionId)"
        method = .get
    }
}
