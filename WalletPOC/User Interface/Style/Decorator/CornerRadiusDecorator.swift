//
//  CornerRadiusDecorator.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import UIKit

struct CornerRadiusDecorator: ViewDecorator {
    private let radius: CGFloat?
    
    init(radius: CGFloat? = nil) {
        self.radius = radius
    }
    
    func decorate(view: UIView) {
        view.layer.cornerRadius = radius ?? min(view.frame.width, view.frame.height) / 2
        view.layer.masksToBounds = true
    }
}

struct TopCornerRadiusDecorator: ViewDecorator {
    private let radius: CGFloat?
    
    init(radius: CGFloat? = nil) {
        self.radius = radius
    }
    
    func decorate(view: UIView) {
        view.layer.cornerRadius = radius ?? min(view.frame.width, view.frame.height) / 2
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
