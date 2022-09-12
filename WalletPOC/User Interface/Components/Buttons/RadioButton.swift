//
//  RadioButton.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 09.09.2022.
//


import Foundation
import UIKit

final class RadioButton: UIButton {

    var isChecked: Bool = false {
        didSet {
            initView()
        }
    }
    
    private var borderColor: UIColor = .accent
    
    override var isEnabled: Bool {
        didSet {
            initView()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 28, height: 28)
    }
    
    // MARK: - Lifecycle
    
    convenience init() {
        self.init()
    }
    
    init(isChecked: Bool = false) {
        self.isChecked = isChecked
        super.init(frame: CGRect.zero)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        backgroundColor = .clear
        if isChecked {
            setImage(Asset.Images.radio.image, for: .normal)
            borderColor = .accent
        } else {
            borderColor = .radioButtonColor
            setImage(nil, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        decorate(with: [BorderDecorator(borderWidth: 1, borderColor: borderColor), CornerRadiusDecorator()])
    }
}

