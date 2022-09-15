//
//  HomeViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class TabbarViewController: UITabBarController {
    
    var transactionViewModel: TransactionViewModel? {
        didSet {
            walletVC.transactionViewModel = transactionViewModel
        }
    }
    
    private var walletVC = WalletViewController(viewModel: WalletViewModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = UIViewController()
        let homeBarItem = UITabBarItem(title: "Home", image: Asset.Images.home.image, selectedImage: Asset.Images.home.image)
        homeVC.tabBarItem = homeBarItem
        
        let walletNavController = UINavigationController(rootViewController: walletVC)
        let walletBarItem = UITabBarItem(title: "Wallet", image: Asset.Images.wallet.image, selectedImage: Asset.Images.walletSselected.image)
        walletNavController.tabBarItem = walletBarItem
        
        let tradingVC = UIViewController()
        let tradingBarItem = UITabBarItem(title: "Trading", image: Asset.Images.trading.image, selectedImage: Asset.Images.trading.image)
        tradingVC.tabBarItem = tradingBarItem
        
        let settingsVC = UIViewController()
        let settingsBarItem = UITabBarItem(title: "Settings", image: Asset.Images.settings.image, selectedImage: Asset.Images.settings.image)
        settingsVC.tabBarItem = settingsBarItem
        
        self.viewControllers = [homeVC, walletNavController, tradingVC, settingsVC]
        self.selectedIndex = 1
        self.tabBar.unselectedItemTintColor = .secondaryText
        self.tabBar.tintColor = .primaryText
    }
}
