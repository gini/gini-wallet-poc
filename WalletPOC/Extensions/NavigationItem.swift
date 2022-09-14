//
//  NavigationItem.swift
//  WalletPOC
//
//  Created by Andrei Gherman on 14.09.2022.
//

import UIKit


extension UINavigationItem {
    func setTitle(title:String, subtitle:String) {
        
        let one = UILabel()
        one.text = title
        one.font = UIFont(name: "PlusJakartaSans-SemiBold", size: 16)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont(name: "PlusJakartaSans-Regular", size: 12)
        two.textColor = UIColor(named: "greenText")
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        
        self.titleView = stackView
    }
}
