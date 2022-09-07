//
//  AlertViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

final class AlertViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.10) {
            self.view.backgroundColor = .clear
            self.contentView.alpha = 0
        }
    }
    
    // MARK: - UI
    
    private func setupUI() {
        view.addSubview(contentView)
        
        contentView.decorate(with: CornerRadiusDecorator(radius: .alertViewRadius))
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding3x),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding3x),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.padding3x)
        ])
    }
    
    func populate(with subview: UIView) {
        contentView.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: contentView.topAnchor),
            subview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
