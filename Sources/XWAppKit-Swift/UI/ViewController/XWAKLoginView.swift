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
        input.placeholder = "帐号"
        return input
    }()
    private let passwordInput: XWAKInputView = {
        let input = XWAKInputView()
        input.placeholder = "密码"
        return input
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("登录", for: .normal)
        button.setTitleColor(.lightText, for: .highlighted)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        return button
    }()
    private let registButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("注册", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.contentMode = .right
        return button
    }()
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("忘记密码", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.contentMode = .left
        return button
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
        addSubview(loginButton)
        addSubview(registButton)
        addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            accountInput.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            accountInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            accountInput.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            accountInput.heightAnchor.constraint(equalToConstant: 40),
            
            passwordInput.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            passwordInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            passwordInput.topAnchor.constraint(equalTo: accountInput.bottomAnchor, constant: 20),
            passwordInput.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 20),
            
            registButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            registButton.heightAnchor.constraint(equalToConstant: 30),
            registButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            registButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            forgotButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            forgotButton.heightAnchor.constraint(equalToConstant: 30),
            forgotButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            forgotButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.cornerRadius = 20
    }
}
