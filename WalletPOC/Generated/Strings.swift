// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Already have an account?
  internal static let alreadyHaveAccount = L10n.tr("Localizable", "already_have_account", fallback: "Already have an account?")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "Cancel")
  /// Don't have an account?
  internal static let dontHaveAccount = L10n.tr("Localizable", "dont_have_account", fallback: "Don't have an account?")
  /// Email
  internal static let email = L10n.tr("Localizable", "email", fallback: "Email")
  /// Ooups
  internal static let errorTitleGeneral = L10n.tr("Localizable", "error_title_general", fallback: "Ooups")
  /// Forgot password
  internal static let forgotPassword = L10n.tr("Localizable", "forgot_password", fallback: "Forgot password")
  /// Did you forget your password? No worries, we have you covered
  internal static let forgotPasswordTitle = L10n.tr("Localizable", "forgot_password_title", fallback: "Did you forget your password? No worries, we have you covered")
  /// Language
  internal static let language = L10n.tr("Localizable", "language", fallback: "Language")
  /// Legal
  internal static let legal = L10n.tr("Localizable", "legal", fallback: "Legal")
  /// Log In
  internal static let logIn = L10n.tr("Localizable", "log_in", fallback: "Log In")
  /// Name
  internal static let name = L10n.tr("Localizable", "name", fallback: "Name")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok", fallback: "Ok")
  /// Password
  internal static let password = L10n.tr("Localizable", "password", fallback: "Password")
  /// Preferences
  internal static let preferences = L10n.tr("Localizable", "preferences", fallback: "Preferences")
  /// Privacy Policy
  internal static let privacyPolicy = L10n.tr("Localizable", "privacy_policy", fallback: "Privacy Policy")
  /// Sign Up
  internal static let signUp = L10n.tr("Localizable", "sign_up", fallback: "Sign Up")
  /// Terms and Conditions
  internal static let termsAndConditions = L10n.tr("Localizable", "terms_and_conditions", fallback: "Terms and Conditions")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
