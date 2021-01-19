//
//  XWAKPhotoPickerViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public protocol XWAKPhotoPickerControllerDelegate {
    func viewController(_ viewController: XWAKPhotoPickerController, didSelected items: [UIImage])
}

public class XWAKPhotoPickerController {

    public var maxNumber: Int {
        set {
            XWAKPhoto.shared.max = newValue
        }
        get {
            return XWAKPhoto.shared.max
        }
    }
    public var delegate: XWAKPhotoPickerControllerDelegate?
    private var limited: Bool = false
    
    public init() {
        XWAKPhotoKit.shared.authorized { [weak self](canUse, limited) in
            if canUse {
                self?.limited = limited
                NotificationCenter.default.post(name: XWAKReloadPhotoDatasNotification, object: nil)
            }
        }
    }
    
    public func show(in viewController: UIViewController, with delegate: XWAKPhotoPickerControllerDelegate) {
        XWAKPhoto.shared.selectionHandler = {
            if XWAKPhoto.shared.count > 0 {
                delegate.viewController(self, didSelected: XWAKPhoto.shared.selectedItems)
            }
        }
        let photoView = XWAKPhotoViewController()
        photoView.isLimited = limited
        let picker = UINavigationController(rootViewController: photoView)
        picker.modalPresentationStyle = .fullScreen
        viewController.present(picker, animated: true, completion: nil)
    }
}
