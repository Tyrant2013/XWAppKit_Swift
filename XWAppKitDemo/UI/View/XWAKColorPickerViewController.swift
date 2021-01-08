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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        let view = XWAKColorPicker()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pickerDelegate = self
        view.hexRGBValue = "F8D800FF"
//        view.hexRGBValue = "FFFFFFFF"
        self.view.addSubview(view)
        view.xwak.center(equalTo: self.view.xwak)
            .size((280, 300))
        // Do any additional setup after loading the view.
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
