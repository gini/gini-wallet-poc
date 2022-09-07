//
//  ViewDecorator.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation

import UIKit

protocol ViewDecorator {
    func decorate(view: UIView)
}

extension UIView {
    
    func decorate(with decorator: ViewDecorator) {
        decorator.decorate(view: self)
    }
    
    func decorate(with decorators: [ViewDecorator]) {
        decorators.forEach {
            $0.decorate(view: self)
        }
    }
}

