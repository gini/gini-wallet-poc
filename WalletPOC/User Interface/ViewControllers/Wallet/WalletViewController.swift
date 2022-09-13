//
//  WalletViewController.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 12.09.2022.
//

import Foundation
import UIKit

final class WalletViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.backgroundGradient.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var headerView: WalletHeaderView = {
        let header = WalletHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let viewModel: WalletViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: WalletViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()

            guard let headerView = tableView.tableHeaderView else {
                return
            }

            // The table view header is created with the frame size set in
            // the Storyboard. Calculate the new size and reset the header
            // view to trigger the layout.
            // Calculate the minimum height of the header view that allows
            // the text label to fit its preferred width.
            let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

            if headerView.frame.size.height != size.height {
                headerView.frame.size.height = size.height

                // Need to set the header view property of the table view
                // to trigger the new layout. Be careful to only do this
                // once when the height changes or we get stuck in a layout loop.
                tableView.tableHeaderView = headerView

                // Now that the table view header is sized correctly have
                // the table view redo its layout so that the cells are
                // correcly positioned for the new header size.
                // This only seems to be necessary on iOS 9.
                tableView.layoutIfNeeded()
            }
        }
    
    // MARK: - UI
    
    private func setupUI() {
        navigationItem.title = "My wallet"
        
        view.backgroundColor = .white
        view.addSubview(backgroundImageView)
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerHeader(viewType: WalletSectionHeader.self)
        tableView.register(cellType: TransactionCell.self)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    // MARK: - Actions
}

extension WalletViewController: UITableViewDelegate {
    
}

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(viewType: WalletSectionHeader.self)
        view?.title = viewModel.sectionModels[section].title
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels[section].cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TransactionCell.self)
        cell.viewModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        return cell
    }
}
