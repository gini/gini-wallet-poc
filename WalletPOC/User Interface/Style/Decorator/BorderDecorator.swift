//
//  BorderDecorator.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import UIKit

struct BorderDecorator: ViewDecorator {
    private let borderWidth: CGFloat
    private let borderColor: UIColor?
    
    init(borderWidth: CGFloat = 1, borderColor: UIColor? = .lightGray) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
    func decorate(view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor?.cgColor
    }
}
