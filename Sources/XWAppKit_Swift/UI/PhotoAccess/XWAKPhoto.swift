//
//  XWAKPhoto.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

class XWAKPhoto {
    static let shared = XWAKPhoto()
    static let SelectionCountChangeNotification = Notification.Name("SelectionCountChangeNotification")
    private var items = [XWAKPhotoAsset]()
    public var max: Int = 0
    
    func add(_ item: XWAKPhotoAsset) {
        items.append(item)
        item.isSelected = true
    }
    
    func remove(_ item: XWAKPhotoAsset, index: Int) {
        items.removeAll { $0.requestId == item.requestId }
        item.isSelected = false
        NotificationCenter.default.post(name: XWAKPhoto.SelectionCountChangeNotification, object: index)
    }
    
    func clear() {
        items.removeAll()
    }
    
    public var count: Int { return items.count }
    public var selectedItems: [UIImage] {
        return items.map { $0.thumbImage! }
    }
}
