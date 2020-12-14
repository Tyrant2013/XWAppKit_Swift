//
//  XWAKColorTextField.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/14.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKColorTextField: UITextField, UITextFieldDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        inits()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        inits()
    }
    private func inits() {
        delegate = self
        keyboardType = .asciiCapable
        leftViewMode = .always
        let lbl = UILabel()
        lbl.text = "0x"
        lbl.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        lbl.textAlignment = .center
        let left = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftView = left
        left.addSubview(lbl)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 6 {
            return false
        }
        let len = string.lengthOfBytes(using: .utf8)
        // a ~ z: 97 ~ 122
        // A ~ Z: 65 ~ 90
        // 0 ~ 9: 48 ~ 57
        for index in 0..<len {
            let ch = (string as NSString).character(at: index)
            if !((ch >= 65 && ch <= 70) || (ch >= 97 && ch <= 102) || (ch >= 48 && ch <= 57)) {
                return false
            }
        }
        return true
    }
    

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        if action == #selector(paste(_:)) {
            return true
        }
        return false
    }

}
