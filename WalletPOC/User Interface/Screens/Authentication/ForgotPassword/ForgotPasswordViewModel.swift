//
//  ForgotPasswordViewModel.swift
//  skeleton
//
//  Created by Botond Magyarosi on 08/02/2021.
//

import Foundation
import Combine

final class ForgotPasswordPageViewModel: ObservableObject {
    @Published var email: String = ""
    var canContinue: Bool { isValidEmail(email) }
    
    @Published private(set) var isLoading = false

    init(email: String) {
        self.email = email
    }
}
