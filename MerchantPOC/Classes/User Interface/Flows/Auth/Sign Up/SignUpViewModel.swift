//
//  SignUpViewModel.swift
//  AuthKit
//
//  Created by Botond Magyarosi on 18/12/2019.
//

import Foundation

protocol SignUpFlowDelegate: AnyObject {
    
}

protocol SignUpViewModel {
    var flowDelgate: SignUpFlowDelegate? { get set }
}

class SignUpViewModelImpl: SignUpViewModel {
    weak var flowDelgate: SignUpFlowDelegate?
}
