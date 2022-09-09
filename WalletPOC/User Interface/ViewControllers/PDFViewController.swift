//
//  PDFViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 09.09.2022.
//

import Foundation
import UIKit
import PDFKit

final class PDFViewController: BaseViewController {
    
    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.autoScales = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.Images.close.image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        view.backgroundColor = .lightgrayBackground
        
        view.addSubview(closeButton)
        closeButton.tintColor = .secondaryText
        guard let path = Bundle.main.url(forResource: "pdfMock2", withExtension: "pdf") else {
            return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
        }
        view.addSubview(pdfView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .padding3x),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding3x),
            closeButton.widthAnchor.constraint(equalToConstant: 45),
            closeButton.heightAnchor.constraint(equalToConstant: 45),
            
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pdfView.heightAnchor.constraint(equalToConstant: view.frame.height * 3/4)
        ])
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
}
