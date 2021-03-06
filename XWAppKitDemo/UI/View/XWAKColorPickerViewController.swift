//
//  XWAKColorPickerViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKColorPickerViewController: UIViewController {

    private lazy var popupView: XWAKPopupView = {
        let view = XWAKPopupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fillColor = .lightGray
        view.triangleTopPoint = .init(x: 30, y: 0)
        view.addSubview(picker)
        return view
    }()
    private lazy var picker: XWAKColorPicker = {
        let view = XWAKColorPicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pickerDelegate = self
        view.hexRGBValue = "F8D800FF"
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        view.addSubview(popupView)
        popupView.xwak.center(equalTo: view.safeAreaLayoutGuide.xwak)
            .size((300, 350))
        picker.xwak.center(equalTo: popupView.xwak)
            .size((280, 300))
        // Do any additional setup after loading the view.
        
        let btn = UIButton(type: .system)
        btn.setTitle("随机颜色", for: .normal)
        btn.addTarget(self, action: #selector(randomColorTouched(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addCorner()
        btn.addBorder()
        view.addSubview(btn)
        
        btn.xwak.top(equalTo: popupView.xwak.bottom, 20)
            .left(equalTo: popupView.xwak.left)
            .size((80, 30))
        
        
        let rbtn = UIButton(type: .system)
        rbtn.translatesAutoresizingMaskIntoConstraints = false
        rbtn.setTitle("随机位置", for: .normal)
        rbtn.addTarget(self, action: #selector(randomPositionTouched(_:)), for: .touchUpInside)
        rbtn.addCorner()
        rbtn.addBorder()
        view.addSubview(rbtn)
        
        rbtn.xwak.top(equalTo: popupView.xwak.bottom, 10)
            .right(equalTo: popupView.xwak.right)
            .size((80, 30))
    }
    
    @objc
    func randomColorTouched(_ sender: UIButton) {
        let red = arc4random() % 256
        let green = arc4random() % 256
        let blue = arc4random() % 256
        let hexValue = String(format: "0x%02X%02X%02XFF", red, green, blue)
        picker.hexRGBValue = hexValue
    }
    
    @objc
    func randomPositionTouched(_ sneder: UIButton) {
        let x = CGFloat(arc4random() % 280 + 10)
        popupView.triangleTopPoint = .init(x: x, y: 0)
    }

}

extension XWAKColorPickerViewController: XWAKColorPickerDelegate {
    func colorPicker(_ picker: XWAKColorPicker, didSelectedColor red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        view.backgroundColor = .init(red: red, green: green, blue: blue, alpha: alpha)
        print("from rgb: ", picker.hexRGBValue)
    }
    
    func colorPicker(_ picker: XWAKColorPicker, didSelectedColor hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        view.backgroundColor = .init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        print("from hsb: ", picker.hexRGBValue)
    }
}
