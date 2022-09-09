//
//  AccountCell.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 05.09.2022.
//


import UIKit

class AccountCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    private let accountNameLabel = UILabel.autoLayout()
    private let ibanLabel = UILabel.autoLayout()
    private let amountLabel = UILabel.autoLayout()
    
    let radioButton = RadioButton(isChecked: false)
    var chechmarkChanged: ((Bool) -> ())? = nil

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        
        accountNameLabel.textColor = .gray
        accountNameLabel.textAlignment = .left
        accountNameLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
        
        ibanLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 14)
        ibanLabel.textColor = .gray
        
        amountLabel.font = UIFont(name: "PlusJakartaSans-Medium", size: 16)
        
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)

        contentView.addSubview(accountNameLabel)
        contentView.addSubview(ibanLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(radioButton)
    }
    
    private func setupConstraints() {
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            accountNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            accountNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            accountNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            ibanLabel.topAnchor.constraint(equalTo: accountNameLabel.bottomAnchor, constant: 5),
            ibanLabel.leadingAnchor.constraint(equalTo: accountNameLabel.leadingAnchor),
            ibanLabel.trailingAnchor.constraint(equalTo: accountNameLabel.trailingAnchor),
            
            amountLabel.topAnchor.constraint(equalTo: ibanLabel.bottomAnchor, constant: 5),
            amountLabel.leadingAnchor.constraint(equalTo: accountNameLabel.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: accountNameLabel.trailingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            radioButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            radioButton.heightAnchor.constraint(equalToConstant: 25),
            radioButton.widthAnchor.constraint(equalToConstant: 25),
            radioButton.centerYAnchor.constraint(equalTo: ibanLabel.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configureCell(name: String, iban: String, amount: String) {
        accountNameLabel.text = name
        ibanLabel.text = iban
        amountLabel.text = amount
    }
    
    @objc private func radioButtonTapped() {
        radioButton.isChecked.toggle()
        chechmarkChanged?(true)
    }
}
