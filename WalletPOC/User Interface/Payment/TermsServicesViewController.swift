//
//  TermsServicesViewController.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 07.09.2022.
//


import UIKit

class TermsServicesViewController: UIViewController {
    
//    private let accountsArray = [Account(id: "1", name: "Main Account", iban: "DE23 3701 0044 2344 8191 02", amount: "€3.111,03"), Account(id: "2", name: "Savings Account", iban: "DE23 3701 0044 1344 8291 01", amount: "€6.231,40")]
//
    
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
        
        termsLabel.text = "A. INTRODUCTION TO OUR SERVICES \n \n This Agreement governs your use of Apple’s Services (“Services” – e.g., and where available, App Store, Apple Arcade, Apple Books, Apple Fitness+, Apple Music, Apple News, Apple News+, Apple One, Apple Podcasts, Apple Podcast Subscriptions, Apple TV, Apple TV+, Apple TV Channels, Game Center, iTunes), through which you can buy, get, license, rent or subscribe to content, Apps (as defined below), and other in-app services (collectively, “Content”). Content may be offered through the Services by Apple or a third party. Our Services are available for your use in your country or territory of residence (“Home Country”). By creating an account for use of the Services in a particular country or territory you are specifying it as your Home Country. To use our Services, you need compatible hardware, software (latest version recommended and sometimes required) and Internet access (fees may apply). Our Services’ performance may be affected by these factors. \n \n B. USING OUR SERVICES \n PAYMENTS, TAXES, AND REFUNDS \n \n You can acquire Content on our Services for free or for a charge, either of which is referred to as a “Transaction.” Each Transaction is an electronic contract between you and Apple, and/or you and the entity providing the Content on our Services. However, if you are a customer of Apple Distribution International Ltd., Apple Distribution International Ltd. is the merchant of record for some Content you acquire from Apple Books, Apple Podcasts, or App Store as displayed on the product page and/or during the acquisition process for the relevant Service. In such case, you acquire the Content from Apple Distribution International Ltd., which is licensed by the Content provider (e.g., App Provider (as defined below), book publisher, etc.). When you make your first Transaction, we will ask you to choose how "
        
        acceptButton.setTitle("Accept terms", for: .normal)
        acceptButton.backgroundColor = UIColor(named: "AccentColor")
        acceptButton.layer.cornerRadius = 5
        acceptButton.layer.borderWidth = 1
        acceptButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor

        acceptButton.titleLabel?.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        
        tinyView.backgroundColor = .lightGray

        
        titleLabel.text = "Terms and Conditions"
        titleLabel.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)

        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
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
        dismiss(animated: true, completion: nil)
    }
}
