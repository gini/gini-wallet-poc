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
        case .payNowFull: return "Pay now \n in full"
        case .buyNowPayLater: return "Buy now, \n Pay later"
        }
    }
}

enum InstallmentButtonType {
    case threeMonths
    case sixMonths
    case nineMonths
    
    var priceLabel: String {
        switch self {
        case .threeMonths: return "€85 / mo."
        case .sixMonths: return "€42.5 / mo."
        case .nineMonths: return "€28.3 / mo."
        }
    }
    
    var periodLabel: String {
        switch self {
        case .threeMonths: return "for 3 months"
        case .sixMonths: return "for 6 months"
        case .nineMonths: return "for 9 months"
        }
    }
}

class CustomInstallmentButton: UIButton {
        
    private let priceLabel = UILabel.autoLayout()
    private let periodLabel = UILabel.autoLayout()
    
    private let type: CustomButtonType
    
    init(type: CustomButtonType) {
        self.type = type
        super.init(frame: .zero)
        switch type {
        case .payButton(let type): self.setTitle(type.title, for: .normal)
        case .installmentButton(let type): priceLabel.text = type.priceLabel
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
        self.layer.borderColor = UIColor.gray.cgColor
//        UIColor(named: "borderGray")?.cgColor
        self.backgroundColor = .clear
        
        self.addSubview(priceLabel)
        self.insertSubview(periodLabel, belowSubview: priceLabel)
        
        priceLabel.textColor = .black
        priceLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        priceLabel.textAlignment = .center
        
        //periodLabel.text =
        periodLabel.textColor = .gray
        periodLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 12)
        periodLabel.textAlignment = .center
        
        //self.setTitle(, for: .normal)
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)

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
