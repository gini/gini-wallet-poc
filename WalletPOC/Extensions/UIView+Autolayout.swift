//
//  UIView+Autolayout.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import UIKit

protocol AutoLayout {
    
    static func autoLayout() -> Self
}

extension AutoLayout where Self: UIView {
    static func autoLayout() -> Self {
        let view = Self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension UIView: AutoLayout { }
