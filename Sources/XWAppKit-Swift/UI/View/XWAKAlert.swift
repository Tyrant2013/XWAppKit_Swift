//
//  XWAKAlert.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKAlert: NSObject {
    
    public class func show(title: String?, msg: String?, ok: String?, cancel: String?, delay: CGFloat, okHandler: @escaping () -> Void?, cancelHandler: @escaping () -> Void?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let ok = ok {
            let okAction = UIAlertAction(title: ok, style: .default) { action in
                okHandler()
            }
            alert.addAction(okAction)
        }
        if let cancel = cancel {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel) { action in
                cancelHandler()
            }
            alert.addAction(cancelAction)
        }
        var actualDelay = delay
        if ok == nil && cancel == nil {
            actualDelay = actualDelay == 0.0 ? 1.5 : actualDelay
        }
        else {
            actualDelay = 0.0
        }
        
        DispatchQueue.main.async {
            UIWindow.findKeyWindow().rootViewController?.present(alert, animated: true, completion: nil)
            if actualDelay > 0.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(actualDelay)) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
