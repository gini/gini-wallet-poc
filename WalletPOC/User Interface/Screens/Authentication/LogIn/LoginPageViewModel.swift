//
//  LoginPageViewModel.swift
//  skeleton
//
//  Created by Botond Magyarosi on 27/11/2020.
//

import SwiftUI
import Combine
import Core

final class LoginPageViewModel: ObservableObject {
    @LazyInject private var signInUseCase: SignInUseCase

    @Published var email: String = ""
    @Published var password: String = ""
    var canContinue: Bool { isValidEmail(email) && isValidPassword(password) }

    @Published private(set) var isLoading = false
    @Published var error: ErrorModel?

    private var loginCancellable: AnyCancellable?

    func login() {
        isLoading = true
        loginCancellable = signInUseCase.execute(email: email, password: password)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = ErrorModel(error: error)
                }
            } receiveValue: {

            }
    }
}
