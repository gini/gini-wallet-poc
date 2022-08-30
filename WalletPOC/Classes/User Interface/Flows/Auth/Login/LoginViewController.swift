//
//  LoginViewController.swift
//  AuthKit
//
//  Created by Botond Magyarosi on 18/12/2019.
//

import UIKit
import Core

class LoginViewController: UIViewController {
    
    // MARK: - Private properties

    private(set) public var viewModel: LoginViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailField: UnderlineTextField!
    @IBOutlet private weak var passwordField: UnderlineTextField!
    @IBOutlet private weak var loginButton: ActionButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var socialLoginLabel: UILabel!
    
    // MARK: - Lifecycle
    
    public static func make(viewModel: LoginViewModel) -> LoginViewController {
        let controller = StoryboardScene.Login.initialScene.instantiate()
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initBindings()
    }
    
    // MARK: - UI
    
    private func initUI() {
        emailField.placeholderText = L10n.email
        emailField.activeUnderlineColor = .theme
        emailField.inactiveUnderlineColor = .disabledBackground
        emailField.returnKeyType = .next
        emailField.delegate = self
        emailField.validator = RegexValidator(type: .email).anyValidator
        
        passwordField.placeholderText = L10n.password
        passwordField.activeUnderlineColor = .theme
        passwordField.inactiveUnderlineColor = .disabledBackground
        passwordField.isSecureTextEntry = true
        passwordField.shouldShowPasswordVisibilityIcon = true
        passwordField.returnKeyType = .go
        passwordField.delegate = self
        passwordField.validator = RegexValidator(type: .password).anyValidator
        
        createAccountButton.setTitle(L10n.createNewAccount, for: .normal)
        createAccountButton.titleLabel?.font = .secondaryText
        
        forgotPasswordButton.setTitle(L10n.forgotPassword, for: .normal)
        forgotPasswordButton.titleLabel?.font = .secondaryText
        
        socialLoginLabel.text = L10n.orLogInWith
        socialLoginLabel.font = .secondaryText
        
        loginButton.isEnabled = false
    }

    // MARK: - Bindings
    
    private func initBindings() {
    }
    
    // MARK: - Callbacks
    
    @IBAction private func didTapCreateNewAccount() {
        viewModel.didTapCreateAccount()
    }
    
    @IBAction private func didTapForgotPassword() {
        viewModel.didTapForgotPassword()
    }
    
    @IBAction private func didTapLogin() {
        guard let email = emailField.text, let password = passwordField.text else { return }
        viewModel.didTapLogin(email: email, password: password)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            guard loginButton.isEnabled else { return false }
            didTapLogin()
        }
        return true
    }
}
