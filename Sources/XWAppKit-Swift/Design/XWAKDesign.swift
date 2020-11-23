//
//  XWAKDesign.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/27.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

public enum Font: String {
    case regular = "regular"
    case medium = "medium"
    
    var name: String {
        return self.rawValue
    }
}

public struct FontDescription {
    let font: Font
    let size: CGFloat
    let style: UIFont.TextStyle
}

public enum TextStyle {
    case display1
    
    private var fontDescription: FontDescription {
        switch self {
        case .display1:
            return FontDescription(font: .regular, size: 20, style: .largeTitle)
        }
    }
    
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont.preferredFont(forTextStyle: fontDescription.style)
        }
        let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
        return fontMetrics.scaledFont(for: font)
    }
}

/// Usage
//let label = UILabel()
//label.font = TextStyle.display1.font

// 里面的名字是Color Assets 里面定义的颜色名字
public enum Color: String, CaseIterable {
    // Base Colors
    case primary = "Primary"
    // Text Colors
    case textPrimary = "Text Primary"
    case textSecondary = "Text Secondary"
    
    // Background Colors
    case backgroundPrimary = "Background Primary"
    case backgroundSecondary = "Background Secondary"
    
    // Action Text Colors
    case actionTextPrimary = "Action Text Primary"
    case actionTextOnColor = "Action Text On Color"
}

// 必须保存 Color Assets 里面有设定好的颜色，不然就会出错
public extension UIColor {
    convenience init(color: Color) {
        self.init(named: color.rawValue)!
    }
}

// Usage
// let color = UIColor(color: .primary)

public enum AnimationDuration: TimeInterval {
    case microFast = 0.1
    case microRegular = 0.2
    case microSlow = 0.3
    
    case macroFast = 0.4
    case macroRegular = 0.5
    case macroSlow = 0.6
    
    var timeInterval: TimeInterval {
        return rawValue
    }
}

public enum AnimationTiming {
    case easeIn
    case easeOut
    case easeInOut
    case spring (velocity: CGVector)
    
    var curve: UITimingCurveProvider {
        switch self {
        case .easeIn:
            return UICubicTimingParameters(controlPoint1: CGPoint(x: 0.5, y: 0), controlPoint2: CGPoint(x: 1, y: 1))
        case .easeOut:
            return UICubicTimingParameters(controlPoint1: CGPoint(x: 0, y: 0), controlPoint2: CGPoint(x: 0.4, y: 1))
        case .easeInOut:
            return UICubicTimingParameters(controlPoint1: CGPoint(x: 0.45, y: 1), controlPoint2: CGPoint(x: 0.4, y: 1))
        case .spring(let velocity):
            return UISpringTimingParameters(mass: 1.8, stiffness: 330, damping: 33, initialVelocity: velocity)
            
        }
    }
}
// Usage
//let customAnimator = UIViewPropertyAnimator(duration: AnimationDuration.microSlow.timeInterval, timingParameters: AnimationTiming.easeInOut.curve)
