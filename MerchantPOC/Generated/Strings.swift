// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Create new account
  internal static let createNewAccount = L10n.tr("Localizable", "create_new_account")
  /// Email
  internal static let email = L10n.tr("Localizable", "email")
  /// Forgot password?
  internal static let forgotPassword = L10n.tr("Localizable", "forgot_password")
  /// Login
  internal static let login = L10n.tr("Localizable", "login")
  /// or log in with
  internal static let orLogInWith = L10n.tr("Localizable", "or_log_in_with")
  /// Password
  internal static let password = L10n.tr("Localizable", "password")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
