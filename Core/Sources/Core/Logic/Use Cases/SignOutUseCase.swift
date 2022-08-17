//
//  SignOutUseCase .swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation
import Combine
import DIKit

public final class SignOutUseCase {
    @LazyInject private var authenticationAPI: AuthenticationAPI
    @LazyInject private var signInUseCase: SignInUseCase

    public func execute(name: String, email: String, password: String) -> AnyPublisher<Void, Error> {
        authenticationAPI.signUp(name: name, email: email, password: password)
            .eraseToAnyPublisher()
    }
}
