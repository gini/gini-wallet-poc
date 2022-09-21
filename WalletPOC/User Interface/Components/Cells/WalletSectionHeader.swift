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
    
    var scheduleTapped: (() -> ())? = nil
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var color: UIColor = .clear {
        didSet {
            contentView.backgroundColor = color
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
    }
    
    // MARK: - UI
    
    private func setupUI() {
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .padding2x),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .padding3x),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func didTapSchedule() {
        scheduleTapped?()
    }
}
