// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// I accept the
  internal static let acceptPaymentvc = L10n.tr("Localizable", "accept_paymentvc", fallback: "I accept the")
  /// Accept terms
  internal static let acceptTerms = L10n.tr("Localizable", "accept_terms", fallback: "Accept terms")
  /// Account from
  internal static let accountFrom = L10n.tr("Localizable", "account_from", fallback: "Account from")
  /// Already have an account?
  internal static let alreadyHaveAccount = L10n.tr("Localizable", "already_have_account", fallback: "Already have an account?")
  /// Buy now, 
  ///  Pay later
  internal static let buyNowPayLater = L10n.tr("Localizable", "buy_now_pay_later", fallback: "Buy now, \n Pay later")
  /// Buy now, Pay later
  internal static let buynowPaylaterPaymentvc = L10n.tr("Localizable", "buynow_paylater_paymentvc", fallback: "Buy now, Pay later")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "Cancel")
  /// Close
  internal static let close = L10n.tr("Localizable", "close", fallback: "Close")
  /// Confirm
  internal static let confirm = L10n.tr("Localizable", "confirm", fallback: "Confirm")
  /// Don't have an account?
  internal static let dontHaveAccount = L10n.tr("Localizable", "dont_have_account", fallback: "Don't have an account?")
  /// Due date
  internal static let dueDatePaymentvc = L10n.tr("Localizable", "due_date_paymentvc", fallback: "Due date")
  /// Due %@
  internal static func dueDateTransactioncell(_ p1: Any) -> String {
    return L10n.tr("Localizable", "due_date_transactioncell", String(describing: p1), fallback: "Due %@")
  }
  /// Email
  internal static let email = L10n.tr("Localizable", "email", fallback: "Email")
  /// Ooups
  internal static let errorTitleGeneral = L10n.tr("Localizable", "error_title_general", fallback: "Ooups")
  /// Face ID
  internal static let faceid = L10n.tr("Localizable", "faceid", fallback: "Face ID")
  /// First payment confirmed
  internal static let firstPaymentConfirmed = L10n.tr("Localizable", "first_payment_confirmed", fallback: "First payment confirmed")
  /// for 9 months
  internal static let forNineMonths = L10n.tr("Localizable", "for_nine_months", fallback: "for 9 months")
  /// for 6 months
  internal static let forSixMonths = L10n.tr("Localizable", "for_six_months", fallback: "for 6 months")
  /// for 3 months
  internal static let forThreeMonths = L10n.tr("Localizable", "for_three_months", fallback: "for 3 months")
  /// Forgot password
  internal static let forgotPassword = L10n.tr("Localizable", "forgot_password", fallback: "Forgot password")
  /// Did you forget your password? No worries, we have you covered
  internal static let forgotPasswordTitle = L10n.tr("Localizable", "forgot_password_title", fallback: "Did you forget your password? No worries, we have you covered")
  /// From
  internal static let fromPaymentvc = L10n.tr("Localizable", "from_paymentvc", fallback: "From")
  /// Full amount
  internal static let fullAmount = L10n.tr("Localizable", "full_amount", fallback: "Full amount")
  /// Home
  internal static let homeTabbar = L10n.tr("Localizable", "home_tabbar", fallback: "Home")
  /// Installment was paid
  internal static let installmentWasPaid = L10n.tr("Localizable", "installment_was_paid", fallback: "Installment was paid")
  /// Installments
  internal static let installmentsPaymentvc = L10n.tr("Localizable", "installments_paymentvc", fallback: "Installments")
  /// Invoice
  internal static let invoice = L10n.tr("Localizable", "invoice", fallback: "Invoice")
  /// Log In
  internal static let logIn = L10n.tr("Localizable", "log_in", fallback: "Log In")
  /// Main Account
  internal static let mainAccount = L10n.tr("Localizable", "main_account", fallback: "Main Account")
  /// Monthly: Next %@
  internal static func monthlyNext(_ p1: Any) -> String {
    return L10n.tr("Localizable", "monthly_next", String(describing: p1), fallback: "Monthly: Next %@")
  }
  /// Monthly payment
  internal static let monthlyPayment = L10n.tr("Localizable", "monthly_payment", fallback: "Monthly payment")
  /// My wallet
  internal static let myWallet = L10n.tr("Localizable", "my_wallet", fallback: "My wallet")
  /// Name
  internal static let name = L10n.tr("Localizable", "name", fallback: "Name")
  /// Next installment
  internal static let nextInstallment = L10n.tr("Localizable", "next_installment", fallback: "Next installment")
  /// of
  internal static let of = L10n.tr("Localizable", "of", fallback: "of")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok", fallback: "Ok")
  /// Online payment
  internal static let onlinePayment = L10n.tr("Localizable", "online_payment", fallback: "Online payment")
  /// Online shopping
  internal static let onlineShopping = L10n.tr("Localizable", "online_shopping", fallback: "Online shopping")
  /// Open payment added
  internal static let openPaymentAdded = L10n.tr("Localizable", "open_payment_added", fallback: "Open payment added")
  /// Open payments
  internal static let openPayments = L10n.tr("Localizable", "open_payments", fallback: "Open payments")
  /// Password
  internal static let password = L10n.tr("Localizable", "password", fallback: "Password")
  /// Pay later
  internal static let payLaterPaymentvc = L10n.tr("Localizable", "pay_later_paymentvc", fallback: "Pay later")
  /// Pay next installment
  internal static let payNextInstallment = L10n.tr("Localizable", "pay_next_installment", fallback: "Pay next installment")
  /// Pay now 
  ///  in full
  internal static let payNowInFull = L10n.tr("Localizable", "pay_now_in_full", fallback: "Pay now \n in full")
  /// Pay now
  internal static let payNowPaymentvc = L10n.tr("Localizable", "pay_now_paymentvc", fallback: "Pay now")
  /// Payment confirmed
  internal static let paymentConfirmed = L10n.tr("Localizable", "payment_confirmed", fallback: "Payment confirmed")
  /// Refuse
  internal static let refuse = L10n.tr("Localizable", "refuse", fallback: "Refuse")
  /// This is permanent, if you change your mind, you will have to trigger the payment again.
  internal static let refuseInformation = L10n.tr("Localizable", "refuse_information", fallback: "This is permanent, if you change your mind, you will have to trigger the payment again.")
  /// Refuse payment?
  internal static let refusePayment = L10n.tr("Localizable", "refuse_payment", fallback: "Refuse payment?")
  /// Savings account
  internal static let savingsAccountPaymentVC = L10n.tr("Localizable", "savings_account_paymentVC", fallback: "Savings account")
  /// Schedule payments
  internal static let schedulePayments = L10n.tr("Localizable", "schedule_payments", fallback: "Schedule payments")
  /// Settings
  internal static let settingsTabbar = L10n.tr("Localizable", "settings_tabbar", fallback: "Settings")
  /// Sign Up
  internal static let signUp = L10n.tr("Localizable", "sign_up", fallback: "Sign Up")
  /// A. INTRODUCTION TO OUR SERVICES 
  ///  
  ///  This Agreement governs your use of Apple’s Services (“Services” – e.g., and where available, App Store, Apple Arcade, Apple Books, Apple Fitness+, Apple Music, Apple News, Apple News+, Apple One, Apple Podcasts, Apple Podcast Subscriptions, Apple TV, Apple TV+, Apple TV Channels, Game Center, iTunes), through which you can buy, get, license, rent or subscribe to content, Apps (as defined below), and other in-app services (collectively, “Content”). Content may be offered through the Services by Apple or a third party. Our Services are available for your use in your country or territory of residence (“Home Country”). By creating an account for use of the Services in a particular country or territory you are specifying it as your Home Country. To use our Services, you need compatible hardware, software (latest version recommended and sometimes required) and Internet access (fees may apply). Our Services’ performance may be affected by these factors. 
  ///  
  ///  B. USING OUR SERVICES 
  ///  PAYMENTS, TAXES, AND REFUNDS 
  ///  
  ///  You can acquire Content on our Services for free or for a charge, either of which is referred to as a “Transaction.” Each Transaction is an electronic contract between you and Apple, and/or you and the entity providing the Content on our Services. However, if you are a customer of Apple Distribution International Ltd., Apple Distribution International Ltd. is the merchant of record for some Content you acquire from Apple Books, Apple Podcasts, or App Store as displayed on the product page and/or during the acquisition process for the relevant Service. In such case, you acquire the Content from Apple Distribution International Ltd., which is licensed by the Content provider (e.g., App Provider (as defined below), book publisher, etc.). When you make your first Transaction, we will ask you to choose how 
  internal static let terms = L10n.tr("Localizable", "terms", fallback: "A. INTRODUCTION TO OUR SERVICES \n \n This Agreement governs your use of Apple’s Services (“Services” – e.g., and where available, App Store, Apple Arcade, Apple Books, Apple Fitness+, Apple Music, Apple News, Apple News+, Apple One, Apple Podcasts, Apple Podcast Subscriptions, Apple TV, Apple TV+, Apple TV Channels, Game Center, iTunes), through which you can buy, get, license, rent or subscribe to content, Apps (as defined below), and other in-app services (collectively, “Content”). Content may be offered through the Services by Apple or a third party. Our Services are available for your use in your country or territory of residence (“Home Country”). By creating an account for use of the Services in a particular country or territory you are specifying it as your Home Country. To use our Services, you need compatible hardware, software (latest version recommended and sometimes required) and Internet access (fees may apply). Our Services’ performance may be affected by these factors. \n \n B. USING OUR SERVICES \n PAYMENTS, TAXES, AND REFUNDS \n \n You can acquire Content on our Services for free or for a charge, either of which is referred to as a “Transaction.” Each Transaction is an electronic contract between you and Apple, and/or you and the entity providing the Content on our Services. However, if you are a customer of Apple Distribution International Ltd., Apple Distribution International Ltd. is the merchant of record for some Content you acquire from Apple Books, Apple Podcasts, or App Store as displayed on the product page and/or during the acquisition process for the relevant Service. In such case, you acquire the Content from Apple Distribution International Ltd., which is licensed by the Content provider (e.g., App Provider (as defined below), book publisher, etc.). When you make your first Transaction, we will ask you to choose how ")
  /// Terms and Conditions
  internal static let termsConditions = L10n.tr("Localizable", "terms_conditions", fallback: "Terms and Conditions")
  /// To
  internal static let to = L10n.tr("Localizable", "to", fallback: "To")
  /// Today
  internal static let today = L10n.tr("Localizable", "today", fallback: "Today")
  /// You will pay a total of €%d in 3 installments.
  internal static func totalPayOf(_ p1: Int) -> String {
    return L10n.tr("Localizable", "total_pay_of", p1, fallback: "You will pay a total of €%d in 3 installments.")
  }
  /// Trading
  internal static let tradingTabbar = L10n.tr("Localizable", "trading_tabbar", fallback: "Trading")
  /// Upcoming
  internal static let upcoming = L10n.tr("Localizable", "upcoming", fallback: "Upcoming")
  /// Walet
  internal static let walletTabbar = L10n.tr("Localizable", "wallet_tabbar", fallback: "Walet")
  /// You will pay a total of €%d in %d installments.
  internal static func youWillPayTotalOf(_ p1: Int, _ p2: Int) -> String {
    return L10n.tr("Localizable", "you_will_pay_total_of", p1, p2, fallback: "You will pay a total of €%d in %d installments.")
  }
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
