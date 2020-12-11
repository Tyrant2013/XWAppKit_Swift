//
//  XWAKColorComponent.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKColorComponent: UIControl {
    
    public var min: Int {
        get {
            return slider.min
        }
        set {
            slider.min = newValue
        }
    }
    public var max: Int {
        get {
            return slider.max
        }
        set {
            slider.max = newValue
        }
    }
    public var value: Int {
        get {
            return slider.value
        }
        set {
            slider.value = newValue
            number.text = "\(value)"
        }
    }
    public var isShowNumberValue: Bool = true {
        didSet {
            number.isHidden = !isShowNumberValue
            
            sliderRightToNumber?.isActive = false
            sliderRightToSuper?.isActive = false
            
            sliderRightToNumber?.isActive = isShowNumberValue
            sliderRightToSuper?.isActive = !isShowNumberValue
            
        }
    }
    public var colors: (start: UIColor, end: UIColor) = (UIColor.black, UIColor.white) {
        didSet {
            slider.backgroundLayer.colors = [colors.start.cgColor, colors.end.cgColor]
        }
    }
    
    private var sliderRightToNumber: NSLayoutConstraint?
    private var sliderRightToSuper: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private let slider: XWAKSlider = {
        let view = XWAKSlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.min = 0
        view.max = 255
        return view
    }()
    private let number: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.textAlignment = .center
        view.text = "0"
        return view
    }()

    private func setup() {
        addSubview(slider)
        addSubview(number)

        slider.xwak.left(equalTo: xwak.left)
            .height(20)
            .centerY(equalTo: xwak.centerY)
        number.xwak.size((40, 20))
            .right(equalTo: xwak.right, -10)
            .centerY(equalTo: slider.xwak.centerY)
        sliderRightToNumber = slider.rightAnchor.constraint(equalTo: number.leftAnchor, constant: -20)
        sliderRightToSuper = slider.rightAnchor.constraint(equalTo: rightAnchor)
        sliderRightToNumber?.isActive = true
        
        slider.addTarget(self, action: #selector(brightnessValueChange(_:)), for: .valueChanged)
    }
    
    @objc
    private func brightnessValueChange(_ sender: XWAKSlider) {
        number.text = "\(sender.value)"
        sendActions(for: .valueChanged)
    }
}
