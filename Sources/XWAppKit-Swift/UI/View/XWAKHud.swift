//
//  XWAKHud.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKHudView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        NSLayoutConstraint.activate([label.heightAnchor.constraint(equalToConstant: 30)])
        return label
    }()
    private let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    private let indicator: UIActivityIndicatorView = {
        var style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) { style = .large } else { style = .whiteLarge }
        let activity = UIActivityIndicatorView(style: style)
        activity.color = .white
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSelf()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSelf()
    }
    
    private func initSelf() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        let minWidth = widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        let minHeight = heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        let maxWidth = widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        maxWidth.priority = .defaultHigh
        let maxHeight = heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        maxHeight.priority = .defaultHigh
        NSLayoutConstraint.activate([minWidth, minHeight, maxWidth, maxHeight])
    }
    
    public func set(title: String?, msg: String?, indicator: Bool = false) {
        // 移除所有View
        resetViews()
        // 设置标题
        let hasTitle = title != nil && title!.count > 0
        let hasMsg = msg != nil && msg!.count > 0
        setup(title: title)
        // 设置转圈
        setup(hasTitle: hasTitle, hasMsg: hasMsg, isNeedIndicator: indicator)
        // 设置内容
        setup(msg: msg, hasTitle: hasTitle, hasIndicator: indicator)
//        // 设置转圈
//        if !indicator {
//            setup(isNeedIndicator: (!hasTitle && !hasMsg) || indicator)
//        }
    }
    
    private func resetViews() {
        titleLabel.removeFromSuperview()
        msgLabel.removeFromSuperview()
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        removeFromSuperview()
    }
    
    private func setup(title: String?) {
        titleLabel.text = title

        if let title = title, title.count > 0 {
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
            ])
        }
    }
    
    private func setup(msg: String?, hasTitle: Bool, hasIndicator: Bool = false) {
        msgLabel.text = msg
        if let msg = msg, msg.count > 0 {
            addSubview(msgLabel)
            
            let posY = !hasIndicator ? msgLabel.topAnchor.constraint(equalTo: topAnchor, constant: hasTitle ? 40 : 20) : msgLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 10)
            NSLayoutConstraint.activate([
                msgLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
                msgLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                msgLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                posY
            ])
        }
    }
    
    private func setup(hasTitle: Bool = false, hasMsg: Bool = false, isNeedIndicator: Bool) {
        guard (!hasTitle && !hasMsg) || isNeedIndicator else {
            return
        }
        addSubview(indicator)
        var posY: NSLayoutConstraint
        if !hasTitle && !hasMsg {
            posY = indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
        else if hasTitle {
            posY = indicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        }
        else {
            posY = indicator.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        }
        NSLayoutConstraint.activate([
            posY,
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        indicator.startAnimating()
    }
    
}

let hud = XWAKHudView()
let ignoreView = UIView()
public class XWAKHud: NSObject {
    private static let shared = XWAKHud()
    private var delayTimer: Timer?
    private let shakeDuration: TimeInterval = 0.05
    private let scaleDuration: TimeInterval = 0.1
    private let scaleMin: CGFloat = 0.1
    private let scaleMax: CGFloat = 1.1
    
    private func dismiss(after delay: TimeInterval) {
        delayTimer?.invalidate()
        delayTimer = nil
        
        if (delay > 0.0) {
            delayTimer = Timer(timeInterval: delay,
                               target: self,
                               selector: #selector(timeAttach(_:)),
                               userInfo: nil,
                               repeats: false)
            RunLoop.main.add(delayTimer!, forMode: .common)
        }
    }
    
    @objc
    private func timeAttach(_ sender: Timer) {
        XWAKHud.dismiss()
        
        self.delayTimer?.invalidate()
        self.delayTimer = nil
    }
    
    private func show(_ show: Bool) {
        let min = CGAffineTransform(scaleX: scaleMin, y: scaleMin)
        let max = CGAffineTransform(scaleX: self.scaleMax, y: self.scaleMax)
        let start = show ? min : .identity
        let mid = max
        let end = show ? .identity : min
        let startDuration = show ? scaleDuration : shakeDuration
        let endDuration = show ? shakeDuration : scaleDuration
        hud.transform = start
        UIView.animate(withDuration: startDuration, animations: {
            hud.transform = mid
        }) { _ in
            UIView.animate(withDuration: endDuration, animations: {
                hud.transform = end
            }) { _ in
                if !show {
                    ignoreView.removeFromSuperview()
                    hud.removeFromSuperview()
                }
            }
        }
    }
    
    private func showHudAnimated(_ animated: Bool) {
        if animated { show(true) } else { hud.transform = .identity}
    }
    
    private func dismissAnimated(_ animated: Bool) {
        if animated { show(false) } else { hud.removeFromSuperview() }
    }
    
    // MARK: - Public Methods
    
    public class func dismiss() {
        XWAKHud.shared.dismissAnimated(true)
    }
    
    public class func wait() {
        show(showIndicator: true)
    }
    
    public class func show(in view: UIView? = nil, title: String? = nil, msg: String? = nil, showIndicator: Bool = false, delay: TimeInterval = 0.0, ignoreInteraction: Bool = true) {
        DispatchQueue.main.async {
            var inView = view
            if inView == nil {
                inView = UIWindow.findKeyWindow()
            }
            hud.set(title: title, msg: msg, indicator: showIndicator)
            if ignoreInteraction {
                inView!.addSubview(ignoreView)
                ignoreView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    ignoreView.leftAnchor.constraint(equalTo: inView!.leftAnchor),
                    ignoreView.rightAnchor.constraint(equalTo: inView!.rightAnchor),
                    ignoreView.topAnchor.constraint(equalTo: inView!.topAnchor),
                    ignoreView.bottomAnchor.constraint(equalTo: inView!.bottomAnchor)
                ])
            }
            
            inView!.addSubview(hud)
            NSLayoutConstraint.activate([
                hud.centerXAnchor.constraint(equalTo: inView!.centerXAnchor),
                hud.centerYAnchor.constraint(equalTo: inView!.centerYAnchor),
            ])
            XWAKHud.shared.showHudAnimated(true)
            XWAKHud.shared.dismiss(after: delay)
        }
    }
}
