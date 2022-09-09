//
//  ShadowDecorator.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import UIKit

struct ShadowDecorator: ViewDecorator {
    private let radius: CGFloat
    private let color: UIColor?
    private let opacity: Float
    private let offset: CGSize?
    
    init(radius: CGFloat, color: UIColor? = .lightGray, opacity: Float = 1, offset: CGSize = CGSize(width: 0, height: 4)) {
        self.radius = radius
        self.color = color
        self.opacity = opacity
        self.offset = offset
    }
    
    func decorate(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color?.cgColor
        if let offset = offset {
            view.layer.shadowOffset = offset
        }
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: radius).cgPath
    }
}
