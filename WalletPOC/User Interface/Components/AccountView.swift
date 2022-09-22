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
        case .sender: return UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
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
     var switchAccountIcon = UIImageView.autoLayout()
    
    var isIconHidden: Bool = false {
        didSet {
            if isIconHidden {
                switchAccountIcon.image = nil
            } else {
                switchAccountIcon.image = type.switchAccountImage
                switchAccountIcon.tintColor = .secondaryText
            }
        }
    }

    private let type: AccountType
    init(type: AccountType) {
        self.type = type
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if type == .merchant {
            self.switchAccountIcon.clipsToBounds = true
            self.switchAccountIcon.layer.cornerRadius = 20
        }
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
        
        switchAccountIcon.image = type.switchAccountImage
        
        [accountNameLabel, ibanLabel, amountInvoiceLabel, switchAccountIcon].forEach { self.addSubview($0) }
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
            
            switchAccountIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            switchAccountIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            switchAccountIcon.widthAnchor.constraint(equalToConstant: type == .sender ? 20 : 40),
            switchAccountIcon.heightAnchor.constraint(equalTo: switchAccountIcon.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
