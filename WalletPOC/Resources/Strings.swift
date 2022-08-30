// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Already have an account?
  internal static let alreadyHaveAccount = L10n.tr("Localizable", "already_have_account")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Don't have an account?
  internal static let dontHaveAccount = L10n.tr("Localizable", "dont_have_account")
  /// Email
  internal static let email = L10n.tr("Localizable", "email")
  /// Ooups
  internal static let errorTitleGeneral = L10n.tr("Localizable", "error_title_general")
  /// Forgot password
  internal static let forgotPassword = L10n.tr("Localizable", "forgot_password")
  /// Did you forget your password? No worries, we have you covered
  internal static let forgotPasswordTitle = L10n.tr("Localizable", "forgot_password_title")
  /// Language
  internal static let language = L10n.tr("Localizable", "language")
  /// Legal
  internal static let legal = L10n.tr("Localizable", "legal")
  /// Log In
  internal static let logIn = L10n.tr("Localizable", "log_in")
  /// Name
  internal static let name = L10n.tr("Localizable", "name")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Password
  internal static let password = L10n.tr("Localizable", "password")
  /// Preferences
  internal static let preferences = L10n.tr("Localizable", "preferences")
  /// Privacy Policy
  internal static let privacyPolicy = L10n.tr("Localizable", "privacy_policy")
  /// Sign Up
  internal static let signUp = L10n.tr("Localizable", "sign_up")
  /// Terms and Conditions
  internal static let termsAndConditions = L10n.tr("Localizable", "terms_and_conditions")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
