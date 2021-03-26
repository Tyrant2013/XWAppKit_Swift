//
//  XWAKSVGRootElement.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSVGRootElement: XWAKSVGElement {
    var attributes: [String : String] = [:]
    private(set) var xmlns: String = ""
    private(set) var viewBox: CGRect = .zero
    private(set) var xmlns_svgjs: String = ""
    private(set) var xmlns_xlink: String = ""
    private(set) var version: String = "1.1"
    
    required init(dict: [String : String]) {
        xmlns = dict["xmls"] ?? ""
        xmlns_svgjs = dict["xmls:svgjs"] ?? ""
        xmlns_xlink = dict["xmls:xlink"] ?? ""
        version = dict["version"] ?? ""
        
        if let viewBoxStr = dict["viewBox"] {
            let values = viewBoxStr.split(separator: " ").map { Double(String($0))! }
            viewBox = CGRect(x: values[0],
                             y: values[1],
                             width: values[2],
                             height: values[3])
        }
        
        if let width = dict["width"], let height = dict["height"] {
            let w = Double(width)!
            let h = Double(height)!
            viewBox = CGRect(origin: .zero, size: .init(width: w, height: h))
        }
        
        super.init(dict: dict)
        
        tagName = "svg"
    }
    
}
