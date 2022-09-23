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
    
    init(transactionViewModel: TransactionViewModel? = nil) {
        self.transactionViewModel = transactionViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        setupTabs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.walletVC.transactionViewModel = self.transactionViewModel
    }
    
    private func setupTabs() {
        let homeVC = UIViewController()
        let homeBarItem = UITabBarItem(title: L10n.homeTabbar, image: Asset.Images.home.image, selectedImage: Asset.Images.home.image)
        homeVC.tabBarItem = homeBarItem
        
        let walletNavController = UINavigationController(rootViewController: walletVC)
        let walletBarItem = UITabBarItem(title: L10n.walletTabbar, image: Asset.Images.wallet.image, selectedImage: Asset.Images.walletSselected.image)
        walletNavController.tabBarItem = walletBarItem
        
        let tradingVC = UIViewController()
        let tradingBarItem = UITabBarItem(title: L10n.tradingTabbar, image: Asset.Images.trading.image, selectedImage: Asset.Images.trading.image)
        tradingVC.tabBarItem = tradingBarItem
        
        let settingsVC = UIViewController()
        let settingsBarItem = UITabBarItem(title: L10n.settingsTabbar, image: Asset.Images.settings.image, selectedImage: Asset.Images.settings.image)
        settingsVC.tabBarItem = settingsBarItem
        
        self.viewControllers = [homeVC, walletNavController, tradingVC, settingsVC]
        self.selectedIndex = 1
        self.tabBar.unselectedItemTintColor = .secondaryText
        self.tabBar.tintColor = .primaryText
    }
}
