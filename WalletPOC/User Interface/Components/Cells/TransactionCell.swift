//
//  TransactionCell.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class TransactionCell: UITableViewCell {
    
    var viewModel: TransactionCellModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var consigneeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subtitleSmall
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .body
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subtitle
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .borderColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.logoImageView.clipsToBounds = true
        self.logoImageView.layer.cornerRadius = 25
    }
    
    // MARK: - UI
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.addSubview(logoImageView)
        contentView.addSubview(sideImageView)
        contentView.addSubview(amountLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(separatorView)
        
        stackView.addArrangedSubview(consigneeLabel)
        stackView.addArrangedSubview(messageLabel)
    }
    
    private func setupLayout() {
        let heightAnchor = logoImageView.heightAnchor.constraint(equalToConstant: 50)
        heightAnchor.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding2x),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding3x),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding2x),
            heightAnchor,
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            
            sideImageView.trailingAnchor.constraint(equalTo: logoImageView.trailingAnchor),
            sideImageView.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            sideImageView.heightAnchor.constraint(equalToConstant: 24),
            sideImageView.widthAnchor.constraint(equalToConstant: 24),
            
            stackView.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: .padding2x),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -.padding2x),
            
            amountLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding3x),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding3x),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness)
        ])
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }

        logoImageView.image = viewModel.logo
        logoImageView.decorate(with: [BorderDecorator(borderWidth: .borderThickness, borderColor: viewModel.type.logoBorderColor), CornerRadiusDecorator()])
        
        sideImageView.image = viewModel.type.sideIcon
        consigneeLabel.text = viewModel.title
        
        messageLabel.text = viewModel.message
        messageLabel.textColor = viewModel.type.infoTextColor
        
        amountLabel.text = viewModel.amount
        amountLabel.textColor = viewModel.type.amountTextColor
        
        layoutIfNeeded()
    }
}
