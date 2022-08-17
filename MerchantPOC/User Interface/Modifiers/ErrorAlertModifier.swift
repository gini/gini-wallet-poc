//
//  ErrorAlertModifier.swift
//  skeleton
//
//  Created by Botond Magyarosi on 24/11/2020.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var error: Error?
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented, content: {
                Alert(title: Text("Ooups"), message: Text(error!.localizedDescription))
            })
    }
}

extension View {

    func showAlertOnError(isPresented: Binding<Bool>, error: Error?) -> some View {
        modifier(ErrorAlertModifier(isPresented: isPresented, error: error))
    }
}
