//
//  ProgressView.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 13.09.2022.
//

import Foundation
import UIKit

final class ProgressView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .subtitleSmall
        label.textColor = .secondaryText
        return label
    }()
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.green2.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.hued4.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var totalWidth: Double
    private var totalPortions: Int
    var portionsDone: Int {
        didSet {
            updateUI()
        }
    }
    
    private var portionWidth: Double {
        return totalWidth / Double(totalPortions)
    }
    
    // MARK: - Lifecycle
    
    init(totalPortions: Int, portionsDone: Int, totalWidth: Double) {
        self.totalPortions = totalPortions
        self.portionsDone = portionsDone
        self.totalWidth = totalWidth
        
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.decorate(with: CornerRadiusDecorator(radius: 4))
        progressView.decorate(with: CornerRadiusDecorator(radius: 4))
    }
    
    // MARK: - UI
    
    private func setupUI() {
        addSubview(baseView)
        baseView.addSubview(progressView)
        addDots()
        
        addSubview(label)
        label.text = "\(portionsDone)/\(totalPortions)"
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseView.topAnchor.constraint(equalTo: topAnchor, constant: .padding4x),
            baseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x),
            baseView.heightAnchor.constraint(equalToConstant: 8),
            
            progressView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            progressView.heightAnchor.constraint(equalTo: baseView.heightAnchor),
            progressView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: Double(portionsDone) * portionWidth + (portionsDone == 0 ? 0 : 2)),
            
            label.bottomAnchor.constraint(equalTo: baseView.topAnchor, constant: -.padding/2),
            label.centerXAnchor.constraint(equalTo: baseView.leadingAnchor, constant: Double(portionsDone) * portionWidth)
        ])
    }
    
    private func updateUI() {
        
    }
    
    private func addDots() {
        for i in 1...totalPortions {
            let color: UIColor = i == totalPortions ? .black : .white
            let dot = createDotView(color: color)
            addSubview(dot)
            let padding = Double(i) * portionWidth
            dot.trailingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
            dot.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        }
    }
    
    private func createDotView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 4).isActive = true
        view.widthAnchor.constraint(equalToConstant: 4).isActive = true
        view.decorate(with: CornerRadiusDecorator(radius: 2))
        
        return view
    }
}
