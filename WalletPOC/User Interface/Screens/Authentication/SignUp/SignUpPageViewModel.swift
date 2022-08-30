//
//  SignUpPageViewModel.swift
//  skeleton
//
//  Created by Botond Magyarosi on 27/11/2020.
//

import SwiftUI
import Core
import Combine

class SignUpPageViewModel: ObservableObject {
    @LazyInject private var signUpUseCase: SignUpUseCase

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    var canContinue: Bool { !name.isEmpty && isValidEmail(email) && isValidPassword(password) }

    @Published var isLoading = false
    @Published var error: ErrorModel?
    private var signUpCancellable: AnyCancellable?

    func signUp() {
        isLoading = true
        signUpCancellable = signUpUseCase.execute(name: name, email: email, password: password)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = ErrorModel(error: error)
                }
            } receiveValue: {

            }
    }
}
