//
//  TermsServicesViewController.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 07.09.2022.
//


import UIKit

protocol TermsServicesProtocol {
    func termsAccepted()
}

class TermsServicesViewController: UIViewController { 
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
    
    let defaultHeight: CGFloat = 600
    
    // 3. Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    //private let tableView = UITableView.autoLayout()
    private let titleLabel = UILabel.autoLayout()
    private let cancelButton = UIButton.autoLayout()
    
    private let termsLabel = UITextView.autoLayout()
    
    private let bottomView = UIView.autoLayout()
    private let acceptButton = UIButton.autoLayout()
    private let tinyView = UIView.autoLayout()
    
    var delegateProtocol: TermsServicesProtocol?

    
    init() {
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
        
        //termsLabel.numberOfLines = 0
        termsLabel.font = UIFont(name: "PlusJakartaSans-Light", size: 14)
        termsLabel.isEditable = false
        
        termsLabel.text = L10n.terms
        
        acceptButton.setTitle(L10n.acceptTerms, for: .normal)
        acceptButton.backgroundColor = UIColor(named: "AccentColor")
        acceptButton.layer.cornerRadius = 5
        acceptButton.layer.borderWidth = 1
        acceptButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor

        acceptButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        
        tinyView.backgroundColor = .lightGray

        
        titleLabel.text = L10n.termsConditions
        titleLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)

        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.setTitle(L10n.cancel, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        dimmedView.addGestureRecognizer(tap)

        containerView.addSubview(bottomView)
        bottomView.addSubview(acceptButton)
        bottomView.addSubview(tinyView)
        
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(cancelButton)
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(termsLabel)
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
            
            termsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            termsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            termsLabel.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            
            tinyView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            tinyView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            tinyView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            tinyView.heightAnchor.constraint(equalToConstant: 1),
            
            acceptButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            acceptButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            acceptButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),

            acceptButton.heightAnchor.constraint(equalToConstant: 50),

        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func acceptButtonTapped() {
        delegateProtocol?.termsAccepted()
        dismiss(animated: true, completion: nil)
    }
}
