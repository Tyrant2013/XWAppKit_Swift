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
    
    public init() { }
    
    public func show(in viewController: UIViewController, with delegate: XWAKPhotoPickerControllerDelegate) {
        self.delegate = delegate
        let photoView = XWAKPhotoViewController()
        photoView.delegate = self
        let picker = UINavigationController(rootViewController: photoView)
        picker.modalPresentationStyle = .fullScreen
        viewController.present(picker, animated: true, completion: nil)
    }
}

extension XWAKPhotoPickerController: XWAKPhotoViewControllerDelegate {
    func viewController(_ viewController: XWAKPhotoViewController, didSelected items: [UIImage]) {
        delegate?.viewController(self, didSelected: items)
    }
}
