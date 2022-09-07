//
//  SuccessAlertView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

protocol SuccessAlertViewDelegate: AnyObject {
    func didClose()
}

final class SuccessAlertView: UIView {
    
    enum SuccessEnumType {
        case paymentAdded
        case paymentConfirmed
        case firstPaymentConfirmed
        case installmentPaid
        
        var title: String {
            switch self {
            case .paymentAdded: return "Open payment added"
            case .paymentConfirmed: return "Payment confirmed"
            case .firstPaymentConfirmed: return "First payment confirmed"
            case .installmentPaid: return "Installment was paid"
            }
        }
        
        var message: String {
            switch self {
            case .firstPaymentConfirmed: return "You will pay a total of €255.00 in 3 installments."
            default: return ""
            }
        }
    }

    // MARK: - Properies
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.success.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyLarge
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "m Ipsum has been the industr "
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.body
        label.textColor = .secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var actionButton: ActionButton = {
        let button = ActionButton(style: .constructive)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    weak var delegate: SuccessAlertViewDelegate?
    
    // MARK: - Lifecycle
    
    init(type: SuccessEnumType) {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
        titleLabel.text = type.title
        messageLabel.text = type.message
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(messageLabel)

        actionButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        addSubview(actionButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .verticalPadding),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .imageHeight),
        
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .padding3x),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: .verticalPadding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.verticalPadding),
        
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .padding2x),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: .verticalPadding),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.verticalPadding),

            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: .verticalPadding),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding2x),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding2x),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapClose() {
        delegate?.didClose()
    }
}

private extension CGFloat {
    static let verticalPadding: CGFloat = 40
    static let imageHeight: CGFloat = 100
}
