//
//  ErrorAlertView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

protocol RefusePaymentViewDelegate: AnyObject {
    func didCancel()
    func didRefuse()
}

final class RefusePaymentView: UIView {
    
    // MARK: - Properies
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subtitle
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Refuse payment?"
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.body
        label.textColor = .secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "This is permanent, if you change your mind, you will have to trigger the payment again."
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .interItemSpacing
        return stackView
    }()
    
    private lazy var cancelButton: ActionButton = {
        let button = ActionButton(style: .bordered)
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    private lazy var refuseButton: ActionButton = {
        let button = ActionButton(style: .destructive)
        button.setTitle("Refuse", for: .normal)
        return button
    }()
    
    weak var delegate: RefusePaymentViewDelegate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(stackView)
        
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        refuseButton.addTarget(self, action: #selector(didTapRefuse), for: .touchUpInside)
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(refuseButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding3x),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: .verticalPadding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.verticalPadding),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .padding2x),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: .verticalPadding),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.verticalPadding),
            
            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: .padding3x),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding2x),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding2x),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCancel() {
        delegate?.didCancel()
    }
    
    @objc
    private func didTapRefuse() {
        delegate?.didRefuse()
    }
}

private extension CGFloat {
    static let verticalPadding: CGFloat = 45
    static let interItemSpacing: CGFloat = 12
}
