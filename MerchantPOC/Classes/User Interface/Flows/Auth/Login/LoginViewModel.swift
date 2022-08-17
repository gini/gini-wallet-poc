//
//  LoginViewModel.swift
//  AuthKit
//
//  Created by Botond Magyarosi on 18/12/2019.
//

import Foundation
import Core
import DIKit

protocol LoginFlowDelegate: AnyObject {
    func forgotPassword(on viewModel: LoginViewModel)
    func signUp(on viewModel: LoginViewModel)
}

protocol LoginViewModel {
    var flowDelegate: LoginFlowDelegate? { get set }
    
    func didTapLogin(email: String, password: String)
    func didTapCreateAccount()
    func didTapForgotPassword()
}

class LoginViewModelImpl: LoginViewModel {
    @LazyInject private var authService: AuthService

    // MARK: - Public properties
    
    weak var flowDelegate: LoginFlowDelegate?
    
    // MARK: - Private properties
    
    init() {
        
    }
    
    // MARK: - Public methods
    
    func didTapLogin(email: String, password: String) {
        
    }
    
    func didTapCreateAccount() {
        flowDelegate?.signUp(on: self)
    }
    
    func didTapForgotPassword() {
        flowDelegate?.forgotPassword(on: self)
    }
    
    // MARK: - Private methods
}
