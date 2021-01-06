//
//  XWAKHSBView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKHSBView: UIControl {
    
    public var value: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        get {
            return (wheelView.hue, wheelView.saturation, wheelView.brightness, 1.0)
        }
        set {
            wheelView.hue = newValue.hue
            wheelView.saturation = newValue.saturation
            wheelView.brightness = newValue.brightness
            brightnessView.value = min(Int(newValue.brightness * CGFloat(brightnessView.max)), 255)
        }
    }

    private let wheelView: XWAKColorWheelView = {
        let view = XWAKColorWheelView()
        view.accessibilityLabel = "wheel_view"
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let brightnessView: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.accessibilityLabel = "brightness_view"
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initHSBViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initHSBViews()
    }
    
    private func initHSBViews() {
        clipsToBounds = true
        addSubview(wheelView)
        addSubview(brightnessView)
        brightnessView.value = 255
        brightnessView.isShowNumberValue = false
        
//        if bounds.width < bounds.height {
//            wheelView.xwak.top(equalTo: xwak.top)
//                .edge(equalTo: xwak, inset: 10, edges: [.left, .right])
//                .height(equalTo: wheelView.xwak.width)
//                .width(lessThan: xwak.width)
//        }
//        else {
//            wheelView.xwak.top(equalTo: xwak.top)
//                .centerX(equalTo: xwak.centerX)
//                .width(equalTo: wheelView.xwak.height)
//                .width(lessThan: xwak.width)
//        }
        
//        wheelView.xwak.top(equalTo: xwak.top)
//            .centerX(equalTo: xwak.centerX)
//            .width(equalTo: wheelView.xwak.height)
//            .width(lessThan: xwak.width)
        
//        brightnessView.xwak.top(equalTo: wheelView.xwak.bottom, 10)
//            .bottom(equalTo: xwak.bottom, -10)
//            .left(equalTo: xwak.left, 10)
//            .right(equalTo: xwak.right, -10)
//            .height(20)
        
        wheelView.addTarget(self, action: #selector(hsbValueChange(_:)), for: .valueChanged)
        brightnessView.addTarget(self, action: #selector(brightnessValueChange(_:)), for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame: CGRect = .zero
        var brightFrame = CGRect(origin: .zero, size: .init(width: 0, height: 20))
        if bounds.width > bounds.height {
            frame = CGRect(origin: .zero, size: .init(width: bounds.height, height: bounds.height))
        }
        else {
            frame = CGRect(origin: .init(x: 5, y: 5), size: .init(width: bounds.width - 10, height: bounds.width - 10))
        }
        brightFrame.origin.x = 10
        brightFrame.origin.y = frame.maxY + 10
        brightFrame.size.width = bounds.width - 20
        wheelView.frame = frame
        brightnessView.frame = brightFrame
    }
    
    @objc
    private func brightnessValueChange(_ sender: XWAKColorComponent) {
        wheelView.brightness = CGFloat(sender.value) / 255.0
        sendActions(for: .valueChanged)
    }
    
    @objc
    private func hsbValueChange(_ sender: XWAKColorWheelView) {
        sendActions(for: .valueChanged)
    }

}
