//
//  AccountSwitchViewController.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 05.09.2022.
//

import Foundation
import UIKit

protocol AccountSwitchProtocol {
    func sendDataforUpdate(account: Account)
}

class AccountSwitchViewController: UIViewController {
    
    private let accountsArray = [Account(id: "1", name: "Main Account", iban: "DE23 3701 0044 2344 8191 02", amount: "€3.111,03"), Account(id: "2", name: "Savings Account", iban: "DE23 3701 0044 1344 8291 01", amount: "€6.231,40")]
    
    
    // 1
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // 2
    let maxDimmedAlpha: CGFloat = 0.4
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    let defaultHeight: CGFloat = 300
    
    // 3. Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    private let tableView = UITableView.autoLayout()
    private let titleLabel = UILabel.autoLayout()
    private let cancelButton = UIButton.autoLayout()
    
    private let isSavingsAccount: Bool
    
    var delegateProtocol: AccountSwitchProtocol?
    
    
    init(isSavingsAccount: Bool) {
        self.isSavingsAccount = isSavingsAccount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        
        tableView.separatorColor = .gray
        tableView.register(AccountCell.self, forCellReuseIdentifier: AccountCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        titleLabel.text = "Account from"
        titleLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)

        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        containerView.addSubview(tableView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(cancelButton)
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 5. Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // 6. Set container to default height
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        // 7. Set bottom constant to 0
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        

        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 20),
            
            cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            //tableView.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension AccountSwitchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  accountsArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.reuseIdentifier, for: indexPath) as! AccountCell
        
        cell.configureCell(name: accountsArray[indexPath.row].name, iban: accountsArray[indexPath.row].iban, amount: accountsArray[indexPath.row].amount)
        if isSavingsAccount && indexPath.row == 1 {
            cell.radioButton.isChecked.toggle()
        }
        
        if !isSavingsAccount && indexPath.row == 0 {
            cell.radioButton.isChecked.toggle()
        }

        return cell
    }
    
}

extension AccountSwitchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegateProtocol?.sendDataforUpdate(account: accountsArray[0])
        } else {
            delegateProtocol?.sendDataforUpdate(account: accountsArray[1])
        }
        dismiss(animated: true)
    }
}


