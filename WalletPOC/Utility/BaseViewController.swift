//
//  BaseViewController.swift
//  skeleton
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
    }
}

extension UIViewController {

    /// Removes back bar button item title, leaving only the back icon.
    func removeBackButtonTitle() {
        /*
         Since iOS 14, removing the textual value of the back button item,
         will show empty back navigation menu items (long tap).
         */
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
