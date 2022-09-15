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

class AppDelegate: UIResponder, UIApplicationDelegate {
    @LazyInject private var pushNotificationService: PushNotificationService

    private let appEngine = AppEngine()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appEngine.prepareAppStart()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    // MARK: - APNS
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushNotificationService.didRegisterForRemoteNotifications(data: deviceToken)
    }
    
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
