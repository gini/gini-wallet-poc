//
//  Font.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation

import UIKit

enum FontSize: CGFloat {
    /// 10
    case superSmall     = 10
    /// 12
    case extraSmall     = 12
    /// 14
    case mediumSmall    = 14
    /// 16
    case small          = 16
    /// 18
    case medium         = 18
    /// 20
    case large          = 20
    /// 24
    case mediumLarge    = 24
    /// 32
    case extraLarge     = 32
    /// 40
    case superLarge     = 40
}

private struct FontFamily {
    enum PlusJakartaSans: String, FontConvertible {
        case regular = "PlusJakartaSans-Regular"
        case medium = "PlusJakartaSans-Medium"
        case semiBold = "PlusJakartaSans-SemiBold"
        case bold = "PlusJakartaSans-Bold"
    }
}

struct Font {
    
    static func regular(size: FontSize) -> UIFont {
        return FontFamily.PlusJakartaSans.regular.font(size: size)
    }
    
    static func medium(size: FontSize) -> UIFont {
        return FontFamily.PlusJakartaSans.medium.font(size: size)
    }
    
    static func semibold(size: FontSize) -> UIFont {
        return FontFamily.PlusJakartaSans.semiBold.font(size: size)
    }
    
    static func bold(size: FontSize) -> UIFont {
        return FontFamily.PlusJakartaSans.bold.font(size: size)
    }
}

protocol FontConvertible {
    func font(size: FontSize) -> UIFont!
}

extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    
    func font(size: FontSize) -> UIFont! {
        return UIFont(name: self.rawValue, size: size.rawValue)
    }
}

// MARK: - Fonts

extension UIFont {
    static let heading1 = Font.bold(size: .superLarge)
    static let headig2 = Font.bold(size: .extraLarge)
    static let titleLarge = Font.bold(size: .mediumLarge)
    static let actionLarge = Font.bold(size: .large)
    static let titleSmall = Font.bold(size: .medium)
    static let subtitle = Font.semibold(size: .small)
    static let action = Font.bold(size: .small)
    static let bodyLarge = Font.medium(size: .small)
    static let subtitleSmall = Font.bold(size: .mediumSmall)
    static let body = Font.medium(size: .mediumSmall)
    static let textSmall = Font.regular(size: .extraSmall)
    static let actionSmall = Font.semibold(size: .extraSmall)
    static let caption = Font.semibold(size: .superSmall)
}
