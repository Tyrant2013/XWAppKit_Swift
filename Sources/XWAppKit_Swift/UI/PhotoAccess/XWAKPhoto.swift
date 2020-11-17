//
//  XWAKPhoto.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setupState(_ selected: Bool, text: String) {
        backgroundColor = selected ? .systemGreen : .clear
        layer.borderColor = (selected ? UIColor.systemGreen : UIColor.white).cgColor
        self.text = text
        if selected { scaleAnimation() }
    }
}

class XWAKPhoto {
    static let shared = XWAKPhoto()
    static let SelectionAddNotification = Notification.Name("com.add.notification")
    static let SelectionRemoveIndexNotification = Notification.Name("com.remove.index.notification")
    private var items = [XWAKPhotoAsset]()
    public var max: Int = 0
    public var selectionHandler: (() -> Void)?
    
    func add(_ item: XWAKPhotoAsset) {
        items.append(item)
        item.isSelected = true
        item.index = count
        NotificationCenter.default.post(name: XWAKPhoto.SelectionAddNotification, object: item)
    }
    
    func remove(_ item: XWAKPhotoAsset, index: Int) {
        items.removeAll { $0.asset.localIdentifier == item.asset.localIdentifier }
        item.isSelected = false
        item.index = 0
        NotificationCenter.default.post(name: XWAKPhoto.SelectionRemoveIndexNotification, object: index)
    }
    
    func clear() {
        items.removeAll()
    }
    
    public var count: Int { return items.count }
    public var selectedItems: [UIImage] {
        return items.map { $0.thumbImage! }
    }
}
