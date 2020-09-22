//
//  XWAKTextTools.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/22.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKTextTools: NSObject {
    
    class func convertViewPointToTextLayout(_ layoutSize: CGSize, frome bounds: CGRect, _ point: CGPoint) -> CGPoint {
        var pointInLayout = point
        if layoutSize.height <= bounds.height {
            pointInLayout.y = layoutSize.height - point.y
        }
        return pointInLayout
    }
    
    class func convertTextLayoutFrame(_ frame: CGRect, to view: UIView, layoutSize: CGSize) -> CGRect {
        var frameInView = frame
        frameInView.origin.y = layoutSize.height - frame.origin.y - frame.height
        return frameInView
    }
}
