//
//  LoadingOverlayModifier.swift
//  skeleton
//
//  Created by Botond Magyarosi on 24/11/2020.
//

import SwiftUI

struct LoadingOverlayModifier: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .allowsTightening(false)
            }
        }
    }
}

extension View {

    func loadingOverlay(isLoading: Bool) -> some View {
        modifier(LoadingOverlayModifier(isLoading: isLoading))
    }
}

// MARK: - Preview -

#if DEBUG
struct LoadingOverlayModifier_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Button(action: { }) {
                HStack {
                    Spacer()
                    Text("text button")
                    Spacer()
                }
            }
            .buttonStyle(FilledButtonStyle())
            .loadingOverlay(isLoading: false)
            Button(action: { }) {
                HStack {
                    Spacer()
                    Text("text button")
                    Spacer()
                }
            }
            .buttonStyle(FilledButtonStyle())
            .loadingOverlay(isLoading: true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
