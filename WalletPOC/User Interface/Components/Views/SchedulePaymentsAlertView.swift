//
//  SchedulePaymentsAlertView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

protocol SchedulePaymentsAlertViewDelegate: AnyObject {
    func didConfirm(with schedule: Bool)
}

final class SchedulePaymentsAlertView: UIView {

    // MARK: - Properies
    
    private lazy var actionButton: ActionButton = {
        let button = ActionButton(style: .constructive)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm", for: .normal)
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
        label.text = "Schedule payments"
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
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = .padding3x
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var selectAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select all", for: .normal)
        button.titleLabel?.font = .action
        button.setTitleColor(.accent, for: .normal)
        return button
    }()
    
    private lazy var unselectAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Unselect all", for: .normal)
        button.titleLabel?.font = .action
        button.setTitleColor(.secondaryText, for: .normal)
        return button
    }()
    
    weak var delegate: SchedulePaymentsAlertViewDelegate?
    
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
        addSubview(greyView)

        actionButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        selectAllButton.addTarget(self, action: #selector(didTapSelectAll), for: .touchUpInside)
        unselectAllButton.addTarget(self, action: #selector(didTapUnselectAll), for: .touchUpInside)
        
        greyView.addSubview(horizontalStackView)
        greyView.addSubview(buttonStackView)
        greyView.addSubview(separatorView)
        greyView.addSubview(instructionLabel)
        greyView.addSubview(actionButton)
        
        horizontalStackView.addArrangedSubview(scheduleLabel)
        horizontalStackView.addArrangedSubview(switchView)
        
        buttonStackView.addArrangedSubview(selectAllButton)
        buttonStackView.addArrangedSubview(unselectAllButton)
        
        switchView.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        instructionLabel.text = isScheduled ? "Your remaining installments will be paid automatically on deadlines." : "You will need to pay all installments \nmanually."
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            greyView.topAnchor.constraint(equalTo: topAnchor),
            greyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            greyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separatorView.bottomAnchor.constraint(equalTo: greyView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: greyView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness),
            
            horizontalStackView.topAnchor.constraint(equalTo: greyView.topAnchor, constant: .padding3x),
            horizontalStackView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            horizontalStackView.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),
            
            instructionLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: .padding2x),
            instructionLabel.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            instructionLabel.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),
            
            buttonStackView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: .padding3x),
            buttonStackView.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            buttonStackView.bottomAnchor.constraint(equalTo: greyView.bottomAnchor, constant: -.padding3x),

            actionButton.topAnchor.constraint(equalTo: greyView.bottomAnchor, constant: .padding3x),
            actionButton.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: .padding2x),
            actionButton.trailingAnchor.constraint(equalTo: greyView.trailingAnchor, constant: -.padding2x),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapConfirm() {
        delegate?.didConfirm(with: isScheduled)
    }
    
    @objc
    private func didTapSelectAll() {
        
    }
    
    @objc
    private func didTapUnselectAll() {
        
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
