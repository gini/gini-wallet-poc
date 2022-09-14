//
//  AccountView.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 07.09.2022.
//

import UIKit

enum AccountType {
    case sender
    case merchant
    
    var accountNameFont: UIFont {
        switch self {
        case .sender: return .body
        case .merchant: return .subtitle
        }
    }
    
    var amountInvoiceFont: UIFont {
        switch self {
        case .sender: return .subtitle
        case .merchant: return .body
        }
    }
    
    var switchAccountImage: UIImage {
        switch self {
        case .sender: return UIImage(systemName: "chevron.down") ?? UIImage()
        case .merchant: return UIImage(named: "rainbowStore") ?? UIImage()
        }
    }
    
    var accountNameColor: UIColor {
        switch self {
        case .sender: return .secondaryText
        case .merchant: return .primaryText
        }
    }
    
    var amountInvoiceColor: UIColor {
        switch self {
        case .sender: return .primaryText
        case .merchant: return .secondaryText
        }
    }
}

class AccountView: UIView {
    
     var accountNameLabel = UILabel.autoLayout()
     var ibanLabel = UILabel.autoLayout()
     var amountInvoiceLabel = UILabel.autoLayout()
     var switchAccountButton = UIButton.autoLayout()

    private let type: AccountType
    init(type: AccountType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor(named: "giniLightGray")

        
        accountNameLabel.textColor = type.accountNameColor
        accountNameLabel.font = type.accountNameFont
        
        
        ibanLabel.textColor = UIColor(named: "gray")
        ibanLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        amountInvoiceLabel.textColor = type.amountInvoiceColor
        amountInvoiceLabel.font = type.amountInvoiceFont
        
        switchAccountButton.setImage(type.switchAccountImage, for: .normal)
        
        [accountNameLabel, ibanLabel, amountInvoiceLabel, switchAccountButton].forEach { self.addSubview($0) }

        
    }
    
    private func setupConstraints() {
        let constraints = [
            
            accountNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            accountNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            accountNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            ibanLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 5),
            ibanLabel.leadingAnchor.constraint(equalTo: accountNameLabel.leadingAnchor),
            
            amountInvoiceLabel.topAnchor.constraint(equalTo: ibanLabel.bottomAnchor, constant: 5),
            amountInvoiceLabel.leadingAnchor.constraint(equalTo: accountNameLabel.leadingAnchor),
            
            switchAccountButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchAccountButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            switchAccountButton.widthAnchor.constraint(equalToConstant: 40),
            switchAccountButton.heightAnchor.constraint(equalToConstant: 40),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
