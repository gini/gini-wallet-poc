//
//  CustomInstallmentButton.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 07.09.2022.
//

import UIKit

enum CustomButtonType {
    case payButton(type: PayButtonType)
    case installmentButton(type: InstallmentButtonType)
}

enum PayButtonType {
    case payNowFull
    case buyNowPayLater
    
    var title: String {
        switch self {
        case .payNowFull: return L10n.payNowInFull
        case .buyNowPayLater: return L10n.buyNowPayLater
        }
    }
}

enum InstallmentButtonType {
    case threeMonths
    case sixMonths
    case nineMonths
    
    var periodLabel: String {
        switch self {
        case .threeMonths: return L10n.forThreeMonths
        case .sixMonths: return L10n.forSixMonths
        case .nineMonths: return L10n.forNineMonths
        }
    }
}

class CustomInstallmentButton: UIButton {
    
    var price: Double? {
        didSet {
            guard let price = price else { return }
            let priceString = String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
            priceLabel.text = "€\(priceString) / \(L10n.mo)"
        }
    }
        
    let priceLabel = UILabel.autoLayout()
    private let periodLabel = UILabel.autoLayout()
    
    private let type: CustomButtonType
    
    init(type: CustomButtonType) {
        self.type = type
        super.init(frame: .zero)
        switch type {
        case .payButton(let type):
            self.setTitle(type.title, for: .normal)
        case .installmentButton(let type):
            periodLabel.text = type.periodLabel
        }
        setupButton()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "borderGray")?.cgColor
        self.backgroundColor = .clear
        
        self.addSubview(priceLabel)
        self.insertSubview(periodLabel, belowSubview: priceLabel)
        
        priceLabel.textColor = .black
        priceLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        priceLabel.textAlignment = .center
        
        //periodLabel.text =
        periodLabel.textColor = .gray
        periodLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        periodLabel.textAlignment = .center
        
        //self.setTitle(, for: .normal)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)

    }
    
    private func setupConstraints() {
        let constraints = [
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            periodLabel.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor),
            periodLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
