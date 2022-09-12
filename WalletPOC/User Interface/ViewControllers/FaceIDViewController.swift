//
//  FaceIDViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 09.09.2022.
//

import Foundation
import UIKit

final class FaceIDViewController: UIViewController {
    
    // MARK: - Properties
    
    var didAuthorize: (() -> ())? = nil
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.Images.faceID.image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondaryText
        label.text = "Face ID"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = .gray.withAlphaComponent(0.4)
            self.contentView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.didAuthorize?()
            self.dismiss(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.05) {
            self.view.backgroundColor = .clear
            self.contentView.alpha = 0
        }
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.addSubview(contentView)
        
        contentView.decorate(with: CornerRadiusDecorator(radius: .viewRadius))
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding3x),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -42),
            imageView.widthAnchor.constraint(equalToConstant: 65),
            imageView.heightAnchor.constraint(equalToConstant: 65),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .padding2x),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding2x)
        ])
    }
}
