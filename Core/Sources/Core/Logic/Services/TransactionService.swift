//
//  File.swift
//  
//
//  Created by Noemi Kalman on 19.09.2022.
//

import Foundation
import Alamofire

public class TransactionService {
    
    enum TransactionState: String {
        case providerAccepted = "PAYER_PROVIDER_ACCEPTED"
    }
    
    private let networkService = NetworkServiceImpl()
    
    public init() { }
    
    public func loadTransactionState(transactionId: String, completion: @escaping (Result<Bool, AFError>) -> Void) {
        let request = TransactionStateRequest(transactionId: transactionId)
        networkService.execute(with: request) { response in
            switch response.result {
            case .success(let response):
                if let response = response {
                    let responseString = String(decoding: response, as: UTF8.self)
                    let transactionState = responseString.slice(from: "<transactionStatus>", to: "</transactionStatus>")
                    completion(.success(transactionState == TransactionState.providerAccepted.rawValue))
                } else {
                    completion(.success(false))
                }
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    public func updateTransactionState(transactionId: String, iban: String, amount: Double, accepted: Bool, timestamp: String, completion: @escaping (Result<Void, AFError>) -> Void) {
        let request = UpdateTransactionStateRequest(transactionId: transactionId, iban: iban, amount: amount, accepted: accepted, timestamp: timestamp)
        networkService.execute(with: request) { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
