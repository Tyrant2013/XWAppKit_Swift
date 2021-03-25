//
//  XWAKSVGElement.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/25.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKSVGElement {
    var title = ""
    var identifier = ""
    var className = ""
    var transform = ""
    var group = ""
    var path: UIBezierPath?
    var strokeColor: UIColor = .black
    var fillColor: UIColor = .black
    
//    init(dict: [String : String]) {
//        title = dict[""]!
//        identifier = dict[""]!
//        className = dict[""]!
//        transform = dict[""]!
//        group = dict[""]!
//    }
    required init(dict: [String: String]) {
        
    }
}
