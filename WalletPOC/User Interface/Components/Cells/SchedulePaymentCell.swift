//
//  SchedulePaymentCell.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 08.09.2022.
//

import Foundation
import UIKit

final class SchedulePaymentCell: UITableViewCell {
    
    var viewModel: SchedulePaymentCellModel? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var checkmarkButton: CheckmarkButton = {
        let button = CheckmarkButton(isChecked: false)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = .stackSpacing
        return stackView
    }()
    
    private lazy var consigneeLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textColor = .yellowText
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subtitle
        label.textColor = .yellowText
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightBorderColor
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
    
    // MARK: - UI
    
    private func setupUI() {
        checkmarkButton.addTarget(self, action: #selector(didTapCheckmark), for: .touchUpInside)
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(consigneeLabel)
        stackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(amountLabel)
        contentView.addSubview(separatorView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: .borderThickness),
            
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding2x),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding2x),
            stackView.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: .horizontalSpacing),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -.horizontalSpacing),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding2x),
            
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding3x)
        ])
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }

        checkmarkButton.isChecked = viewModel.isChecked
        consigneeLabel.text = viewModel.consignee
        dateLabel.text = viewModel.dateString
        amountLabel.text = viewModel.amountString
        
        consigneeLabel.textColor = viewModel.isEnabled ? .primaryText : .lightGray
        dateLabel.textColor = viewModel.isEnabled ? .yellowText : .lightGray
        amountLabel.textColor = viewModel.isEnabled ? .yellowText : .lightGray
    }
    
    @objc
    private func didTapCheckmark() {
        toggleCheckmark()
    }
    
    func toggleCheckmark() {
        checkmarkButton.isChecked.toggle()
        viewModel?.isChecked = checkmarkButton.isChecked
    }
}

private extension CGFloat {
    static let stackSpacing: CGFloat = 2
    static let horizontalSpacing: CGFloat = 30
}
