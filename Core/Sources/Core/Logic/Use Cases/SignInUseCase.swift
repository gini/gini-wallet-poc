//
//  SignInUseCase.swift
//  
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import Foundation
import Combine
import DIKit

public final class SignInUseCase {
    @LazyInject private var authenticationAPI: AuthenticationAPI
    @LazyInject private var appState: AppState

    public func execute(email: String, password: String) -> AnyPublisher<Void, Error> {
        authenticationAPI.login(email: email, password: password)
            .handleEvents(receiveOutput: { authorization in
                LocalStorage.accessToken = authorization.accessToken
                LocalStorage.refreshToken = authorization.refreshToken
                self.appState.isLoggedIn = true
            })
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}
