//
//  LaunchScreenViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 21.09.2022.
//

import Foundation
import UIKit
import PDFKit

final class LaunchScreenViewController: BaseViewController {
    
    private lazy var imageview: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Asset.Images.launch.image
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.addSubview(imageview)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: view.topAnchor),
            imageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
