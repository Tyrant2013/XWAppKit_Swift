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
        backgroundColor = selected ? .systemGreen : UIColor.black.withAlphaComponent(0.2)
        layer.borderColor = (selected ? UIColor.systemGreen : UIColor.white).cgColor
        self.text = text
        if selected { scaleAnimation() }
    }
}

class XWAKPhoto {
    static let shared = XWAKPhoto()
    static let SelectionAddNotification = Notification.Name("com.add.notification")
    static let SelectionRemoveIndexNotification = Notification.Name("com.remove.index.notification")
    static let NoMorePhotoSelectionNotification = Notification.Name("com.no.more.selection.notification")
    static let ContinuePhotoSelectionNotification = Notification.Name("com.continue.selection.notification")
    private(set) var items = [XWAKPhotoAsset]()
//    private var selectedItemIds = [String : Int]()
    public var max: Int = 1
    public var selectionHandler: (() -> Void)?
    
    func add(_ item: XWAKPhotoAsset) {
//        if item.isSelected { return }
        print("添加图片")
        items.append(item)
        item.isSelected = true
        item.index = count
//        selectedItemIds[item.asset.localIdentifier] = count
        
        NotificationCenter.default.post(name: XWAKPhoto.SelectionAddNotification, object: item)
        if items.count >= max {
            NotificationCenter.default.post(name: XWAKPhoto.NoMorePhotoSelectionNotification, object: nil)
        }
    }
    
    func remove(_ item: XWAKPhotoAsset, index: Int) {
        items.removeAll { $0.asset.localIdentifier == item.asset.localIdentifier }
        item.isSelected = false
        item.index = 0
//        if let index = selectedItemIds.index(forKey: item.asset.localIdentifier) {
//            selectedItemIds.remove(at: index)
//        }
        
        NotificationCenter.default.post(name: XWAKPhoto.SelectionRemoveIndexNotification, object: index)
//        selectedItemIds.forEach { (key, value) in
//            if value > index {
//                selectedItemIds[key] = (value - 1)
//            }
//        }
        
        if items.count == (max - 1) {
            NotificationCenter.default.post(name: XWAKPhoto.ContinuePhotoSelectionNotification, object: nil)
        }
    }
    
    func clear() {
        items.removeAll()
//        selectedItemIds.removeAll()
    }
    
//    func isSelectedItem(_ item: XWAKPhotoAsset) -> Bool {
//        if let value = selectedItemIds[item.asset.localIdentifier] {
//            item.isSelected = true
//            item.index = value
//            return true
//        }
//        return false
//    }
    
    public var count: Int { return items.count }
    public var selectedItems: [UIImage] {
        return items.map { $0.originImage! }
    }
}
