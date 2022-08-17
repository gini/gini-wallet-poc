//
//  UIViewController+Error.swift
//  skeleton
//
//  Created by Botond Magyarosi on 05/02/2021.
//

import UIKit

extension UIViewController {

    func showAlert(for error: Error) {
        let alert = UIAlertController(title: L10n.errorTitleGeneral, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default))
        present(alert, animated: true)
    }
}
