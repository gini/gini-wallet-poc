//
//  PushNotificationService.swift
//  
//
//  Created by Botond Magyarosi on 30.10.2020.
//

import UIKit

public final class PushNotificationService: NSObject {
    @LazyInject private var notificationApi: NotificationAPI
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    /*
     Should be called after login.
     
     The app asks for notifications permissions
     and register for remote push notifications if granted.
     */
    public func register() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (authorized, error) in
                    if authorized {
                        self.registerForRemotePushNotifications()
                    }
                }
            case .denied:
                #warning("Show an alert? maybe?")
            case .authorized:
                self.registerForRemotePushNotifications()
            case .provisional:
                self.registerForRemotePushNotifications()
            case .ephemeral:
                // Epheral is only available for App Clips
                break
            @unknown default:
                break
            }
        }
    }
    
    /*
     Should be called on log out.
     
     The app unregisters from further push notifications,
     and invalidates the device token on the server.
     */
    public func unregister() {
        unregisterForRemotePushNotifications()
        if let deviceToken = LocalStorage.deviceToken {
            let _ = notificationApi.unregister(token: deviceToken)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { })
        }
    }
    
    // Call from AppDelegate
    public func didRegisterForRemoteNotifications(data: Data) {
        let deviceToken = data.deviceTokenString()
        LocalStorage.deviceToken = deviceToken
        let _ = notificationApi.register(token: deviceToken)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { })
    }
    
    // MARK: - Utility
    
    private func registerForRemotePushNotifications() {
        DispatchQueue.main.sync {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    private func unregisterForRemotePushNotifications() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension PushNotificationService: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler(.alert)
    }
}

private extension Data {
    
    func deviceTokenString() -> String {
        map({ String(format: "%02.2hhx", $0) }).joined()
    }
}
