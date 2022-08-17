//
//  AuthenticationAPI.swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation
import RestBird
import Combine
import DIKit

final class AuthenticationAPI {
    @LazyInject private var networkClient: NetworkClient
    
    func login(email: String, password: String) -> Future<OAuthCredential, Error> {
        struct Request: DataRequest {
            typealias ResponseType = OAuthCredential
            typealias RequestType = EmptyRequest
            let suffix: String? = "/auth/login"
            let method: HTTPMethod = .post
        }
        return networkClient.combine.execute(request: Request())
    }
    
    func signUp(name: String, email: String, password: String) -> Future<Void, Error> {
        struct Request: DataRequest {
            typealias ResponseType = EmptyResponse
            typealias RequestType = EmptyRequest
            let suffix: String? = "/auth/login"
            let method: HTTPMethod = .post
        }
        return networkClient.combine.execute(request: Request())
    }
}
