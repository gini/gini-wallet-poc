//
//  Color.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import UIKit.UIColor

// MARK: - Colors

extension UIColor {
    static let accent = Asset.Colors.accentColor.color
    static let secondaryAccent = Asset.Colors.secondaryAccent.color
    static let inactiveAccent = Asset.Colors.transparentAccent.color
    
    static let primaryText = Asset.Colors.darkGray.color
    static let secondaryText = Asset.Colors.gray.color
    
    static let error = Asset.Colors.red.color
    static let inactiveError = Asset.Colors.transparentRed.color
    static let errorText = Asset.Colors.darkRed.color
    
    static let yellowText = Asset.Colors.darkYellow.color
    
    static let lightgrayBackground = Asset.Colors.extraLightGrey.color
    static let borderColor = Asset.Colors.borderColor.color
    static let lightBorderColor = Asset.Colors.lightBorder.color
    static let radioButtonColor = Asset.Colors.hued1.color
}
