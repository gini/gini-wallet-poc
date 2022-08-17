//
//  main.swift
//  skeleton
//
//  Created by Botond Magyarosi on 17.03.2022.
//

import SwiftUI
import Core

struct AppMain: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootPage()
                .environmentObject(appState)
        }
    }
}
