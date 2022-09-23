//
//  PaymentConfirmedAlertView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

protocol PaymentConfirmedAlertViewDelegate: AnyObject {
    func didConfirm(with schedule: Bool)
}

final class PaymentConfirmedAlertView: UIView {

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
        label.text = L10n.firstPaymentConfirmed
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.body
        label.textColor = .secondaryText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = L10n.youWillPayTotalOf(Int(amountToPay), 3)
        
        return label
    }()
    
    private lazy var actionButton: ActionButton = {
        let button = ActionButton(style: .constructive)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.confirm, for: .normal)
        return button
    }()
    
    private lazy var greyView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightgrayBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .borderColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.body
        label.textColor = .secondaryText
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyLarge
        label.textColor = .primaryText
        label.numberOfLines = 0
        label.text = L10n.schedulePayments
        return label
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.onTintColor = .accent
        switchView.isOn = isScheduled
        return switchView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    weak var delegate: PaymentConfirmedAlertViewDelegate?
    
    private var isScheduled: Bool = false {
        didSet {
            instructionLabel.text = isScheduled ? "Your remaining installments will be paid automatically on deadlines." : "You will need to pay all installments \nmanually."
        }
    }
    
    private var amountToPay: Double = 0
    
    // MARK: - Lifecycle
    
    init(isScheduled: Bool, amountToPay: Double) {
        self.isScheduled = isScheduled
        self.amountToPay = amountToPay
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
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
        addSubview(greyView)

        actionButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        greyView.addSubview(horizontalStackView)
        greyView.addSubview(separatorView)
        greyView.addSubview(instructionLabel)
        greyView.addSubview(actionButton)
        
        horizontalStackView.addArrangedSubview(scheduleLabel)
        horizontalStackView.addArrangedSubview(switchView)
        
        switchView.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        instructionLabel.text = isScheduled ? "Your remaining installments will be paid automatically on deadlines." : "You will need to pay all installments \nmanually."
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
            
            greyView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: .verticalPadding),
            greyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            greyView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            separatorView.topAnchor.constraint(equalTo: greyView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: greyView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness),
            
            horizontalStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: .padding3x),
            horizontalStackView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            horizontalStackView.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),
            
            instructionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: .padding2x),
            instructionLabel.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            instructionLabel.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),

            actionButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: .padding3x),
            actionButton.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            actionButton.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),
            actionButton.bottomAnchor.constraint(equalTo: greyView.bottomAnchor, constant: -.padding2x)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapConfirm() {
        delegate?.didConfirm(with: isScheduled)
    }
    
    @objc
    private func selectionChanged() {
        isScheduled = switchView.isOn
    }
}

private extension CGFloat {
    static let switchHeight: CGFloat = 24
    static let verticalPadding: CGFloat = 40
    static let imageHeight: CGFloat = 100
}
