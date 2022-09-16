//
//  SceneDelegate.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import UIKit
import Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var tabbarController: TabbarViewController?
    var transactionViewModel: TransactionViewModel?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        AppStyle.setupAppearance()

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        if let urlContext = connectionOptions.urlContexts.first {
            let url = urlContext.url

            decodeURLParams(url: url)
        }
        self.tabbarController = TabbarViewController(transactionViewModel: transactionViewModel)
        window.rootViewController = tabbarController ?? UIViewController()

        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            let url = urlContext.url

            decodeURLParams(url: url)
        }
    }
    
    private func decodeURLParams(url: URL) {
        enum Params: String {
            case buyNowPayLater
            case transactionId
            case merchantAppScheme
        }
        
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true), let params = components.queryItems else {
                    return
            }

        if let buyNowPayLater = params.first(where: { $0.name == Params.buyNowPayLater.rawValue })?.value,
            let transactionId = params.first(where: { $0.name == Params.transactionId.rawValue })?.value,
           let merchantAppScheme = params.first(where: { $0.name == Params.merchantAppScheme.rawValue })?.value {
            
            print("=== \(merchantAppScheme)")
            
            self.transactionViewModel = TransactionViewModel(merchantAppScheme: merchantAppScheme, transactionId: transactionId, buyNowPayLater: buyNowPayLater)
            tabbarController?.transactionViewModel = transactionViewModel
        } else {
            print("Params are missing")
        }
    }
}

