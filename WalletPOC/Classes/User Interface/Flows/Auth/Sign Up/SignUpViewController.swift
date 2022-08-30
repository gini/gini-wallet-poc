//
//  SignUpViewController.swift
//  AuthKit
//
//  Created by Botond Magyarosi on 18/12/2019.
//

import UIKit

class SignUpViewController: UIViewController {

    private(set) public var viewModel: SignUpViewModel!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    public static func make(viewModel: SignUpViewModel) -> SignUpViewController {
        let controller = StoryboardScene.SignUp.initialScene.instantiate()
         controller.viewModel = viewModel
         return controller
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - User interactions
    
    @IBAction func signUp(_ sender: UIButton) {
    }
}
