//
//  AppStyle.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 09.09.2022.
//

import Foundation
import UIKit

struct AppStyle {
    
    static func setupAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        let backButtonImage = Asset.Images.arrowLeft.image
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.scrollEdgeAppearance = appearance
    }
}
