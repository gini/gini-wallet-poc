//
//  WalletHeaderView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class WalletHeaderView: UIView {
    
    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.qrCode.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(qrImageView)
        addSubview(stackView)
        
        addInstructions()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            qrImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            qrImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            qrImageView.heightAnchor.constraint(equalToConstant: 110),
            qrImageView.widthAnchor.constraint(equalToConstant: 110),
            
            stackView.topAnchor.constraint(equalTo: qrImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func addInstructions() {
        let scanImageView = UIImageView(image: Asset.Images.scan.image)
        let sendImageView = UIImageView(image: Asset.Images.send.image)
        let requestImageView = UIImageView(image: Asset.Images.request.image)
        let poolsImageView = UIImageView(image: Asset.Images.pools.image)
        
        let imageViews = [scanImageView, sendImageView, requestImageView, poolsImageView]
        imageViews.forEach { imageView in
            imageView.contentMode = .scaleAspectFill
        }
        imageViews.forEach { stackView.addArrangedSubview($0)}
    }
}
