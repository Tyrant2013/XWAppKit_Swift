//
//  XWAKHud.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKHud: NSObject {
    private let animationDuration: TimeInterval = 0.15
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        view.isHidden = true
        let minWidth = view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        minWidth.priority = .required
        let minHeight = view.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        minHeight.priority = .required
        let maxWidth = view.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        maxWidth.priority = .defaultHigh
        let maxHeight = view.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        maxHeight.priority = .defaultHigh
        NSLayoutConstraint.activate([minWidth, minHeight, maxWidth, maxHeight])
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    private let indicator: UIActivityIndicatorView = {
        var style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) { style = .large } else { style = .whiteLarge }
        let activity = UIActivityIndicatorView(style: style)
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    public func show(title: String?, msg: String?) {
        // 移除所有View
        resetViews()
        // 设置标题
        let hasTitle = setup(title: title)
        // 设置内容
        let hasMsg = setup(msg: msg, hasTitle: hasTitle)
        // 设置转圈
        setup(isNeedIndicator: !hasTitle && !hasMsg)
        // 显示
        showHudAnimated(true)
    }
    
    public func dismiss() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { finished in
            self.resetViews()
        }
    }
    
    private func resetViews() {
        titleLabel.removeFromSuperview()
        msgLabel.removeFromSuperview()
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
    
    private func setup(title: String?) -> Bool {
        titleLabel.text = title

        if let title = title, title.count > 0 {
            backgroundView.addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20),
                titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
                titleLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -20),
                titleLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
            return true
        }
        return false
    }
    
    private func setup(msg: String?, hasTitle: Bool) -> Bool {
        msgLabel.text = msg
        if let msg = msg, msg.count > 0 {
            backgroundView.addSubview(msgLabel)
            NSLayoutConstraint.activate([
                msgLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20),
                msgLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -20),
                msgLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20),
                msgLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: hasTitle ? 40 : 20)
            ])
            return true
        }
        return false
    }
    
    private func setup(isNeedIndicator: Bool) {
        guard isNeedIndicator else {
            return
        }
        backgroundView.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        indicator.startAnimating()
    }
    
    private func showHudAnimated(_ animated: Bool) {
        backgroundView.isHidden = false
        if let view = UIWindow.findKeyWindow().rootViewController?.view {
            view.addSubview(backgroundView)
            NSLayoutConstraint.activate([
                backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
        backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: animated ? animationDuration : 0.0) {
            self.backgroundView.transform = .identity
        }
    }
}
