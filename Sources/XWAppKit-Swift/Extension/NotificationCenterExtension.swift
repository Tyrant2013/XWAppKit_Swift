//
//  NotificationCenterExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/17.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation

extension NotificationCenter {
    class func add(name: Notification.Name, _ handler: @escaping (_ notification: Notification) -> Void) {
        self.default.addObserver(forName: name, object: nil, queue: OperationQueue.main) { (notification) in
            handler(notification)
        }
    }
}
