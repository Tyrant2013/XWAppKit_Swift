//
//  XWAKLoginView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/28.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKLoginView: UIView {
    private let accountInput: XWAKInputView = {
        let input = XWAKInputView()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    private let passwordInput: XWAKInputView = {
        let input = XWAKInputView()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        addSubview(accountInput)
        addSubview(passwordInput)
        
        NSLayoutConstraint.activate([
            accountInput.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 20),
            accountInput.rightAnchor.constraint(equalToSystemSpacingAfter: rightAnchor, multiplier: -20),
            accountInput.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 20),
            accountInput.heightAnchor.constraint(equalToConstant: 30),
            
            passwordInput.leftAnchor.constraint(equalToSystemSpacingAfter: leftAnchor, multiplier: 20),
            passwordInput.rightAnchor.constraint(equalToSystemSpacingAfter: rightAnchor, multiplier: -20),
            passwordInput.topAnchor.constraint(equalToSystemSpacingBelow: accountInput.bottomAnchor, multiplier: 20),
            passwordInput.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.cornerRadius = 20
    }
}
