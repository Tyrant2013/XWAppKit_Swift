//
//  XWAKToast.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/27.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKToast: NSObject {
    private let animationDuration: TimeInterval = 0.15
    private let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    public override init() {
        super.init()
        backgroundView.addSubview(msgLabel)
        NSLayoutConstraint.activate([
            msgLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 30),
            msgLabel.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -30),
            msgLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            msgLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10)
        ])
    }
    
    public func message(_ msg: String) -> XWAKToast {
        msgLabel.text = msg
        msgLabel.layoutIfNeeded()
        return self
    }
    
    public func show(_ inView: UIView?) {
        backgroundView.removeFromSuperview()
        
        var view: UIView
        if inView == nil { view = UIWindow.findKeyWindow() } else { view = inView! }
        view.addSubview(backgroundView)
        
        backgroundView.layoutIfNeeded()
        let height = backgroundView.bounds.height
        backgroundView.layer.cornerRadius = height / 2
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: animationDuration) {
            self.backgroundView.transform = .identity
        }
    }
    
    public func dismiss() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.backgroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { finished in
            self.backgroundView.removeFromSuperview()
        }
    }
}
