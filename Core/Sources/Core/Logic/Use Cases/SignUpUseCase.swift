//
//  SignUpUseCase.swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation
import Combine
import DIKit

public final class SignUpUseCase {
    @LazyInject private var authAPI: AuthenticationAPI
    
    public func execute(name: String, email: String, password: String) -> AnyPublisher<Void, Error> {
        authAPI.signUp(name: name, email: email, password: password)
            .eraseToAnyPublisher()
    }
}
