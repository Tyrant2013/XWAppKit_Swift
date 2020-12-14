//
//  XWAKHSBView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKHSBView: UIControl {
    
    public var value: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        get {
            return (wheelView.hue, wheelView.saturation, wheelView.brightness)
        }
        set {
            wheelView.hue = newValue.hue
            wheelView.saturation = newValue.saturation
            wheelView.brightness = newValue.brightness
        }
    }

    private let wheelView: XWAKColorWheelView = {
        let view = XWAKColorWheelView()
        view.accessibilityLabel = "wheel_view"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let brightnessView: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.accessibilityLabel = "brightness_view"
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        wheelView.xwak.top(equalTo: xwak.top)
            .centerX(equalTo: xwak.centerX)
            .width(equalTo: wheelView.xwak.height)
        brightnessView.xwak.top(equalTo: wheelView.xwak.bottom, 10)
            .bottom(equalTo: xwak.bottom, -10)
            .left(equalTo: xwak.left, 10)
            .right(equalTo: xwak.right, -10)
            .height(20)
        
        wheelView.addTarget(self, action: #selector(hsbValueChange(_:)), for: .valueChanged)
        brightnessView.addTarget(self, action: #selector(brightnessValueChange(_:)), for: .valueChanged)
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
