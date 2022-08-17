//
//  ForgotPasswordPage.swift
//  skeleton
//
//  Created by Botond Magyarosi on 24/11/2020.
//

import SwiftUI

struct ForgotPasswordPage: View {
    @ObservedObject var viewModel: ForgotPasswordPageViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(L10n.forgotPasswordTitle)
                .font(.headline)

            TextField(L10n.email, text: $viewModel.email)
                .textFieldStyle(ChipTextfieldStyle())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)

            Button(action: forgotPassword) {
                HStack {
                    Spacer()
                    Text(L10n.forgotPassword)
                    Spacer()
                }
            }
            .disabled(viewModel.canContinue)
            .buttonStyle(FilledButtonStyle())
            .loadingOverlay(isLoading: viewModel.isLoading)

            Spacer()
        }
        .padding()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarTitle(L10n.forgotPassword)
    }
    
    func forgotPassword() {

    }
}

// MARK: - Preview -

#if DEBUG
struct ForgotPasswordView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ForgotPasswordPage(viewModel: .init(email: "hello@test.com"))
        }
    }
}
#endif
