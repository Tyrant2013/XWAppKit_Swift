//
//  XWAKInputView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/28.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKInputView: UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = .always
    }
}
