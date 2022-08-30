//
//  Validation.swift
//  skeleton
//
//  Created by Botond Magyarosi on 27/11/2020.
//

import Foundation

private let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
private let passwordLength = 6

func isValidEmail(_ email: String) -> Bool {
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPred.evaluate(with: email)
}

func isValidPassword(_ password: String) -> Bool {
    password.count >= passwordLength
}
