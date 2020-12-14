//
//  XWAKRGBView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKRGBView: UIControl {

    private let redComponent: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        let redStart = UIColor(displayP3Red: 0, green: 1, blue: 1, alpha: 1.0)
        let redEnd = UIColor(displayP3Red: 1, green: 1 , blue: 1, alpha: 1.0)
        view.colors = (redStart, redEnd)
        view.value = 255
        return view
    }()
    private let greenComponent: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        let greenStart = UIColor(displayP3Red: 1, green: 0, blue: 1, alpha: 1.0)
        let greenEnd = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1.0)
        view.colors = (greenStart, greenEnd)
        view.value = 255
        return view
    }()
    private let blueComponent: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        let blueStart = UIColor(displayP3Red: 1, green: 1, blue: 0, alpha: 1.0)
        let blueEnd = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1.0)
        view.colors = (blueStart, blueEnd)
        view.value = 255
        return view
    }()
    private let alphaComponent: XWAKColorComponent = {
        let view = XWAKColorComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.colors = (.black, .white)
        view.value = 255
        return view
    }()
    private let hex: XWAKColorTextField = {
        let view = XWAKColorTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 3
        view.textAlignment = .left
        return view
    }()
    public var value: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = (0, 0, 0, 1.0)
    override init(frame: CGRect) {
        super.init(frame: frame)
        initRGBViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initRGBViews()
    }
    
    private func initRGBViews() {
        addSubview(redComponent)
        addSubview(greenComponent)
        addSubview(blueComponent)
//        addSubview(alphaComponent)
        
        addSubview(hex)
        
        redComponent.xwak.edge(equalTo: xwak, inset: 10, edges: [.left, .top, .right])
            .height(20)
        greenComponent.xwak.edge(equalTo: xwak, inset: 10, edges: [.left, .right])
            .top(equalTo: redComponent.xwak.bottom, 20)
            .height(20)
        blueComponent.xwak.edge(equalTo: xwak, inset: 10, edges: [.left, .right])
            .top(equalTo: greenComponent.xwak.bottom, 20)
            .height(20)
        
        hex.xwak.right(equalTo: xwak.right, -10)
            .top(equalTo: blueComponent.xwak.bottom, 20)
            .size((85, 30))

        redComponent.addTarget(self, action: #selector(colorComponentValueChange(_:)), for: .valueChanged)
        greenComponent.addTarget(self, action: #selector(colorComponentValueChange(_:)), for: .valueChanged)
        blueComponent.addTarget(self, action: #selector(colorComponentValueChange(_:)), for: .valueChanged)
        
        updateHexValue()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }

    @objc
    private func colorComponentValueChange(_ sender: XWAKColorComponent) {
        let (r, g, b) = (CGFloat(redComponent.value) / 255, CGFloat(greenComponent.value) / 255, CGFloat(blueComponent.value) / 255)
        
        let redStart = UIColor(displayP3Red: 0, green: g, blue: b, alpha: 1.0)
        let redEnd = UIColor(displayP3Red: 1, green: g , blue: b, alpha: 1.0)
        let greenStart = UIColor(displayP3Red: r, green: 0, blue: b, alpha: 1.0)
        let greenEnd = UIColor(displayP3Red: r, green: 1, blue: b, alpha: 1.0)
        let blueStart = UIColor(displayP3Red: r, green: g, blue: 0, alpha: 1.0)
        let blueEnd = UIColor(displayP3Red: r, green: g, blue: 1, alpha: 1.0)
        
        redComponent.colors = (redStart, redEnd)
        greenComponent.colors = (greenStart, greenEnd)
        blueComponent.colors = (blueStart, blueEnd)
        
        updateHexValue()
    }
    
    private func updateHexValue() {
        let red = redComponent.value
        let green = greenComponent.value
        let blue = blueComponent.value
        let alpha = 255
        hex.text = String(format: "%02X%02X%02X", red, green, blue)
        value = (CGFloat(red) / 255, CGFloat(green) / 255, CGFloat(blue) / 255, CGFloat(alpha) / 255)
        sendActions(for: .valueChanged)
    }
}
