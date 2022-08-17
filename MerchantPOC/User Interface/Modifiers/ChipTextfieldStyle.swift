//
//  ChipTextfieldStyle.swift
//  skeleton
//
//  Created by Botond Magyarosi on 24/11/2020.
//

import SwiftUI

// swiftlint:disable identifier_name
struct ChipTextfieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(5.0)
    }
}
