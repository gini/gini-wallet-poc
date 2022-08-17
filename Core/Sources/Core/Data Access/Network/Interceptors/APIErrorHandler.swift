//
//  APIErrorHandler.swift
//  Core
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import Alamofire
import Foundation

public enum APIError: Error {
    case forceUpdateNeeded
}

struct APIErrorHandler: RequestRetrier {

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
    }
}
