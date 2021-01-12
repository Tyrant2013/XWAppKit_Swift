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
    private let colorShowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.addCorner()
        view.addBorder()
        return view
    }()
    private let hex: XWAKColorTextField = {
        let view = XWAKColorTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.xwak_color(with: "0xAAB0AF").cgColor
        view.layer.cornerRadius = 5
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    public var value: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        get {
            let red = redComponent.value
            let green = greenComponent.value
            let blue = blueComponent.value
            let alpha = 255
            return (CGFloat(red) / 255, CGFloat(green) / 255, CGFloat(blue) / 255, CGFloat(alpha) / 255)
        }
        set {
            let red = min(Int(newValue.red * 255), 255)
            let green = min(Int(newValue.green * 255), 255)
            let blue = min(Int(newValue.blue * 255), 255)
            redComponent.value = red
            greenComponent.value = green
            blueComponent.value = blue
            hex.text = String(format: "%02X%02X%02X", red, green, blue)
        }
    }
    
    public var hexValue: String {
        get {
            let red = redComponent.value
            let green = greenComponent.value
            let blue = blueComponent.value
            let alpha = 255
            return String(format: "0x%02X%02X%02X%02X", red, green, blue, alpha)
        }
        set {
            let val = newValue.hexToValue()
            redComponent.value = Int(val.red)
            greenComponent.value = Int(val.green)
            blueComponent.value = Int(val.blue)
            hex.text = String(format: "%02X%02X%02X", Int(val.red), Int(val.green), Int(val.blue))
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.colorShowView.backgroundColor = .xwak_color(with: self.hex.text!)
            } completion: { (finished) in
                
            }
        }
    }
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
        addSubview(colorShowView)
        
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
            .size((105, 30))
        colorShowView.xwak.edge(equalTo: xwak, inset: 10, edges: [.left, .right, .bottom])
            .top(equalTo: hex.xwak.bottom, 10)

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
        hex.text = String(format: "%02X%02X%02X", red, green, blue)
        colorShowView.backgroundColor = .xwak_color(with: hex.text!)
        sendActions(for: .valueChanged)
    }
}


extension String {
    func hexToValue() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let hex = self
        var hexValue = hex
        if hex.starts(with: "0x") || hex.starts(with: "0X") {
            hexValue = String(hex.dropFirst(2))
        }
        if hex.starts(with: "#") {
            hexValue = String(hex.dropFirst())
        }
        if !(hexValue.count == 8 || hexValue.count == 6) {
            fatalError("error hex string: \(self)")
        }
        let array = Array(hexValue)
        let numbers = stride(from: 0, to: array.count, by: 2).map {
            strtoul(String(array[$0..<min($0 + 2, array.count)]), nil, 16)
        }
        if numbers.count == 4 {
            return (CGFloat(numbers[0]), CGFloat(numbers[1]), CGFloat(numbers[2]), CGFloat(numbers[3]))
        }
        if numbers.count == 3 {
            return (CGFloat(numbers[0]), CGFloat(numbers[1]), CGFloat(numbers[2]), 255)
        }
        fatalError("error hex string: \(self)")
    }
}
