//
//  ActionButton.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

final class ActionButton: UIButton {
    
    // MARK: - Action button styles
    
    enum ActionButtonStyle {
        case bordered
        case constructive
        case destructive
    }
    
    // MARK: - Button image position
    
    enum IconPosition {
        case left, right, none
    }

    // MARK: - Public properties
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: .actionButtonHeight)
    }
    
    override var isEnabled: Bool {
        didSet {
            setupEnabledState(isEnabled: isEnabled)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard oldValue != self.isHighlighted else { return }
            UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.7 : 1
            }, completion: nil)
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            guard isLoading != oldValue else { return }
            isUserInteractionEnabled = !isLoading
            
            if isLoading {
                initActivityIndicator()
                activityIndicator?.startAnimating()
            } else {
                activityIndicator?.stopAnimating()
                activityIndicator?.removeFromSuperview()
                activityIndicator = nil
            }
        }
    }
    
    var borderColor: UIColor? = .lightGray {
        didSet {
            decorate(with: BorderDecorator(borderWidth: .borderThickness, borderColor: borderColor))
        }
    }
    
    var icon: UIImage? = nil {
        didSet {
            setImage(icon, for: .normal)
            setImage(icon, for: .highlighted)
        }
    }
    
    var titleColor: UIColor = .white {
        didSet {
            tintColor = titleColor
            setTitleColor(titleColor, for: .normal)
        }
    }
    
    var iconPosition: IconPosition = .left
    
    // MARK: - Private properties
    
    private var style: ActionButtonStyle
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Lifecycle
    
    convenience init() {
        self.init(style: .constructive)
    }
    
    init(style: ActionButtonStyle) {
        self.style = style
        super.init(frame: CGRect.zero)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        switch style {
        case .bordered:
            backgroundColor = .clear
            setTitleColor(.secondaryText, for: .normal)
            titleLabel?.font = UIFont.action
        case .destructive:
            backgroundColor = .error
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont.action
        case .constructive:
            backgroundColor = .accent
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont.action
        }
    }
    
    private func initActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: style == .bordered ? .medium : .white)
        guard let activityIndicator = activityIndicator else { return }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.padding),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupIconPosition(position: IconPosition) {
        switch position {
        case .left:
            imageEdgeInsets.right = .padding / 2
            titleEdgeInsets.left = .padding / 2
        case .right:
            semanticContentAttribute = .forceRightToLeft
            contentEdgeInsets = UIEdgeInsets(top: 0, left: .padding, bottom: 0, right: .padding)
        case .none:
            break
        }
    }
    
    private func setupEnabledState(isEnabled: Bool) {
        switch style {
        case .bordered:
            layer.borderColor = isEnabled ? borderColor?.cgColor : UIColor.gray.cgColor
            setTitleColor(isEnabled ? titleColor : .secondaryText, for: .disabled)
        case .constructive:
            backgroundColor = isEnabled ? .accent : .inactiveAccent
        case .destructive:
            backgroundColor = isEnabled ? .error : .inactiveError
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch style {
        case .bordered:
            decorate(with: [BorderDecorator(borderWidth: 1, borderColor: borderColor), CornerRadiusDecorator(radius: .actionButtonRadius)])
        case .constructive:
            decorate(with: CornerRadiusDecorator(radius: .actionButtonRadius))
        case .destructive:
            decorate(with: CornerRadiusDecorator(radius: .actionButtonRadius))
        }
        setupIconPosition(position: iconPosition)
    }
}
