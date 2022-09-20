//
//  File.swift
//  
//
//  Created by Noemi Kalman on 18.09.2022.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://rtp.gini.net/payee"

    enum Endpoints {
        
        enum Transactions {
            case query
            case accept
            case refuse
            
            var path: String {
                switch self {
                case .query:
                    return "/transactions/"
                case .accept:
                    return "/transactions/assessment/positive"
                case .refuse:
                    return "/transactions/assessment/negative"
                }
            }
        }
    }
}
