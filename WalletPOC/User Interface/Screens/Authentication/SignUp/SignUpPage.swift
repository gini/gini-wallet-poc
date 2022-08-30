//
//  SignUpPage.swift
//  skeleton
//
//  Created by Botond Magyarosi on 29.10.2020.
//

import SwiftUI

struct SignUpPage: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject private var viewModel = SignUpPageViewModel()
        
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TextField(L10n.name, text: $viewModel.name)
                    .disableAutocorrection(true)
                TextField(L10n.email, text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField(L10n.password, text: $viewModel.password)
            }
            .textFieldStyle(ChipTextfieldStyle())
            .padding()

            Button(action: signUp) {
                HStack {
                    Spacer()
                    Text(L10n.signUp)
                    Spacer()
                }
            }
            .disabled(!viewModel.canContinue)
            .buttonStyle(FilledButtonStyle())
            .loadingOverlay(isLoading: viewModel.isLoading)
            .padding()

            HStack {
                Text(L10n.alreadyHaveAccount)
                Button(L10n.logIn, action: {
                    presentation.wrappedValue.dismiss()
                })
            }
            .font(.footnote)

            Spacer()
        }
        .alert(item: $viewModel.error, content: { model in
            Alert(title: Text(model.error.localizedDescription))
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarTitle(L10n.signUp)
    }
    
    private func signUp() {
        viewModel.signUp()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
    }
}
