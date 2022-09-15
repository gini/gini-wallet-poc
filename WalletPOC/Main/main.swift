
//import SwiftUI
//import Core
//
//struct AppMain: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    let appState: AppState = AppState()
//
//    var body: some Scene {
//        WindowGroup {
//            Text("Hello")
////            RootPage()
////                .environmentObject(appState)
//        }
//    }
//}
import UIKit

let appDelegateClass = NSStringFromClass(AppDelegate.self)
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
