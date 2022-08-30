//
//  InvoiceViewController.swift
//  MerchantPOC
//
//  Created by Andrei Gherman on 30.08.2022.
//

import Foundation
import UIKit

class InvoiceViewController: UIViewController {
    
    private let titleLabel = UILabel.autoLayout()
    private let fromLabel = UILabel.autoLayout()
    private let toLabel = UILabel.autoLayout()
    private let invoiceLabel = UILabel.autoLayout()
    
    private let grayView = UIView.autoLayout()
    private let tinyView = UIView.autoLayout()
    
    
    private let grayViewSecond = UIView.autoLayout()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        titleLabel.text = "Online Payment"
        
        toLabel.text = "To"
        toLabel.textAlignment = .left

        fromLabel.text = "From"
        fromLabel.textAlignment = .left
        
        invoiceLabel.text = "Invoice"
        
        grayView.backgroundColor = .lightGray
        
        grayViewSecond.backgroundColor = .lightGray

        
        tinyView.backgroundColor = .lightGray
        
        [titleLabel, fromLabel, toLabel, grayView, grayViewSecond, tinyView, invoiceLabel].forEach { view.addSubview($0) }
        
    }
    
    private func setupConstraints() {
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fromLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            grayView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 20),
            grayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            grayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            grayView.heightAnchor.constraint(equalToConstant: 70),
            
            tinyView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 20),
            tinyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tinyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tinyView.heightAnchor.constraint(equalToConstant: 1),
            
            toLabel.topAnchor.constraint(equalTo: tinyView.bottomAnchor, constant: 20),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            grayViewSecond.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 20),
            grayViewSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            grayViewSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            grayViewSecond.heightAnchor.constraint(equalToConstant: 70),
            
            invoiceLabel.topAnchor.constraint(equalTo: grayViewSecond.bottomAnchor, constant: 20),
            invoiceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ]
        NSLayoutConstraint.activate(constraints)
    }
}
