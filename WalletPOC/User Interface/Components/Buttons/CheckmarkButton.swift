//
//  CheckmarkButton.swift
//  WalletPOC
//
//  Created by Noemi Kalman on 07.09.2022.
//

import Foundation
import UIKit

final class CheckmarkButton: UIButton {

    var isChecked: Bool = false {
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
        if isChecked {
            backgroundColor = .accent
            setImage(Asset.Images.check.image, for: .normal)
        } else {
            backgroundColor = .clear
            setImage(nil, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        decorate(with: [BorderDecorator(borderWidth: 1, borderColor: .accent), CornerRadiusDecorator(radius: 4)])
    }
}
