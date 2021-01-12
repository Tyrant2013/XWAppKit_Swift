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
        return view
    }()
    private let brightnessView: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.accessibilityLabel = "brightness_view"
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
        
        wheelView.addTarget(self, action: #selector(hsbValueChange(_:)), for: .valueChanged)
        brightnessView.addTarget(self, action: #selector(brightnessValueChange(_:)), for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame: CGRect = .zero
        let brightnessHeight: CGFloat = 20
        let brightnessOffsetToBottom: CGFloat = 10
        let brightnessOffsetToWheel: CGFloat = 10
        var wheelOffsetX: CGFloat = 10
        var brightFrame = CGRect(origin: .zero, size: .init(width: 0, height: brightnessHeight))
        let width = bounds.width - wheelOffsetX * 2
        let height = bounds.height - brightnessHeight - brightnessOffsetToBottom - brightnessOffsetToWheel
        let len = min(width, height)
        if len < width {
            wheelOffsetX = (bounds.width - len) / 2
        }
        frame = CGRect(origin: .init(x: wheelOffsetX, y: 0), size: .init(width: len, height: len))
        wheelView.frame = frame
        
        brightFrame.origin.x = 10
        brightFrame.origin.y = bounds.height - brightnessOffsetToBottom - brightnessHeight
        brightFrame.size.width = bounds.width - 20
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
