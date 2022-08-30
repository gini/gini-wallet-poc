//
//  RootPage.swift
//  skeleton
//
//  Created by Botond Magyarosi on 29.10.2020.
//

import SwiftUI
import Core
import DIKit

struct RootPage: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        if !appState.isLoggedIn {
            NavigationView {
                LogInPage()
            }
        } else if appState.needsProfileSetup {
            ProfileSetupView()
        } else {
            Text("User is logged in")
        }
    }
}
