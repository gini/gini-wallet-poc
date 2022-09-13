//
//  WalletSectionHeader.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class WalletSectionHeader: UITableViewHeaderFooterView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subtitleSmall
        label.textColor = .primaryText
        return label
    }()
    
    private lazy var scheduleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Schedule payments", for: .normal)
        button.titleLabel?.font = .actionSmall
        button.setTitleColor(.secondaryText, for: .normal)
        button.isHidden = true

        return button
    }()
    
    var scheduleTapped: (() -> ())? = nil
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
     
    var canSchedule: Bool = false {
        didSet {
            scheduleButton.isHidden = !canSchedule
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scheduleButton.decorate(with: [CornerRadiusDecorator(radius: 6), BorderDecorator(borderWidth: .borderThickness, borderColor: .borderColor)])
    }
    
    // MARK: - UI
    
    private func setupUI() {
        scheduleButton.addTarget(self, action: #selector(didTapSchedule), for: .touchUpInside)
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(scheduleButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding2x),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding3x),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x),
            
            scheduleButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            scheduleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding2x),
            scheduleButton.heightAnchor.constraint(equalToConstant: 30),
            scheduleButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    @objc private func didTapSchedule() {
        scheduleTapped?()
    }
}
