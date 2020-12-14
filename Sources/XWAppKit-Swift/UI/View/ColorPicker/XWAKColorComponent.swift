//
//  XWAKColorComponent.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKColorComponent: UIControl, UITextFieldDelegate {
    
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
        view.layer.borderColor = UIColor.xwak_color(with: "0xAAB0AF").cgColor
        view.layer.cornerRadius = 5
        view.textAlignment = .center
        view.text = "0"
        view.keyboardType = .numberPad
        return view
    }()

    private func setup() {
        addSubview(slider)
        addSubview(number)
        number.delegate = self

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
        number.addTarget(self, action: #selector(textFieldValueChange(_:)), for: .editingChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldStr = textField.text {
            let newStr = oldStr + string
            if let num = Int(newStr), num <= 255 {
                return true
            }
            return false
        }
        return true
    }
    
    @objc
    func textFieldValueChange(_ sender: UITextField) {
        if var text = sender.text {
            if text == "" {
                text = "0"
            }
            else {
                let ch = (text as NSString).character(at: 0)
                // 第一位是 0
                if ch == 48 {
                    text.remove(at: text.startIndex)
                }
            }
            sender.text = text
            slider.value = Int(text)!
            sendActions(for: .valueChanged)
        }
    }
    
    @objc
    private func brightnessValueChange(_ sender: XWAKSlider) {
        number.text = "\(sender.value)"
        sendActions(for: .valueChanged)
    }
}
