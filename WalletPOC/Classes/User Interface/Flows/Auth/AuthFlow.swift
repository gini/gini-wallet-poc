//
//  AuthFlow.swift
//  AuthKit
//
//  Created by Botond Magyarosi on 18/12/2019.
//

import UIKit
import Core

public class AuthFlow: NavigationFlow {
    
    weak var navigationController: UINavigationController?
    
    override public func firstScene() -> UIViewController {
        let viewModel = LoginViewModelImpl()
        viewModel.flowDelegate = self
        return LoginViewController.make(viewModel: viewModel)
    }
}

// MARK: - LoginFlowDelegate

extension AuthFlow: LoginFlowDelegate {

    func forgotPassword(on viewModel: LoginViewModel) {
        
    }
    
    func signUp(on viewModel: LoginViewModel) {
        let viewModel = SignUpViewModelImpl()
        viewModel.flowDelgate = self
        navigationController?.pushViewController(SignUpViewController.make(viewModel: viewModel), animated: true)
    }
}

// MARK: - LoginFlowDelegate

extension AuthFlow: SignUpFlowDelegate {
    
}
