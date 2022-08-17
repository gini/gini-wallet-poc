//
//  LogInView.swift
//  skeleton
//
//  Created by Botond Magyarosi on 29.10.2020.
//

import SwiftUI

struct LogInPage: View {
    @ObservedObject var viewModel = LoginPageViewModel()
    @Environment(\.horizontalSizeClass) var size

    var body: some View {
        VStack {
            Spacer()

            VStack {
                TextField(L10n.email, text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField(L10n.password, text: $viewModel.password)
            }
            .textFieldStyle(ChipTextfieldStyle())
            .padding()

            Button(action: login) {
                HStack {
                    Spacer()
                    Text(L10n.logIn)
                    Spacer()
                }
            }
            .disabled(!viewModel.canContinue)
            .buttonStyle(FilledButtonStyle())
            .loadingOverlay(isLoading: viewModel.isLoading)
            .padding()

            HStack {
                Text(L10n.dontHaveAccount)
                NavigationLink(L10n.signUp, destination: SignUpPage())
            }
            .font(.footnote)

            Spacer()

            NavigationLink(L10n.forgotPassword, destination: ForgotPasswordPage(viewModel: .init(email: viewModel.email)))
                .font(.footnote)
                .padding(.bottom)
        }
        .alert(item: $viewModel.error, content: { model in
            Alert(title: Text(model.error.localizedDescription))
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarTitle(Text(L10n.logIn), displayMode: .inline)
    }
    
    private func login() {
        viewModel.login()
    }
}

#if DEBUG
struct LogInPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogInPage()
        }
    }
}
#endif
