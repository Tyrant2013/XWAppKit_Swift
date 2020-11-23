//
//  WindowExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

extension UIWindow {
    public class func makeWindow() -> UIWindow {
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            for winScene in scenes {
                if winScene.activationState == .foregroundActive {
                    return UIWindow(windowScene: winScene as! UIWindowScene)
                }
            }
        }
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    public class func findKeyWindow() -> UIWindow {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first(where: \.isKeyWindow)!
        }
        else {
            if let window = UIApplication.shared.keyWindow {
                return window
            }
            if let window = UIApplication.shared.windows.first {
                return window
            }
            return makeWindow()
        }
    }
}
