//
//  AppDelegate.swift
//  skeleton
//
//  Created by Botond Magyarosi on 14/10/2020.
//

import UIKit
import Core
import DIKit
import CoreData
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appEngine = AppEngine()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appEngine.prepareAppStart()
        AppCenter.start(withAppSecret: "bf07bc0f-7a97-47ed-a5e1-86cd27f13884", services: [Analytics.self, Crashes.self])
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    // MARK: - APNS
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        
    }
    
//    func application(_ application: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
//
//        print("Opened")
//
//        // Determine who sent the URL.
////        let sendingAppID = options[.sourceApplication]
////        print("source application = \(sendingAppID ?? "Unknown")")
////
////        // Process the URL.
////        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
////            let albumPath = components.path,
////            let params = components.queryItems else {
////                print("Invalid URL or album path missing")
////                return false
////        }
////
////        if let photoIndex = params.first(where: { $0.name == "index" })?.value {
////            print("albumPath = \(albumPath)")
////            print("photoIndex = \(photoIndex)")
////            return true
////        } else {
////            print("Photo index missing")
////            return false
////        }
//        return true
//    }
}
