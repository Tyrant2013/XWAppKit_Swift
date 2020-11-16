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

    public var maxNumber: Int = 9 {
        didSet {
            XWAKPhoto.shared.max = maxNumber
        }
    }
    public var delegate: XWAKPhotoPickerControllerDelegate?
    private var limited: Bool = false
    
    public init() {
        XWAKPhotoKit.shared.authorized { [weak self](canUse, limited) in
            if canUse && limited {
                self?.limited = true
            }
        }
    }
    
    public func show(in viewController: UIViewController, with delegate: XWAKPhotoPickerControllerDelegate) {
        XWAKPhoto.shared.selectionHandler = {
            delegate.viewController(self, didSelected: XWAKPhoto.shared.selectedItems)
        }
        let photoView = XWAKPhotoViewController()
        photoView.isLimited = limited
        let picker = UINavigationController(rootViewController: photoView)
        picker.modalPresentationStyle = .fullScreen
        viewController.present(picker, animated: true, completion: nil)
    }
}
