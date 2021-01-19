//
//  XWAKPhotoAssetViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos
import XWAppKit_Swift

class XWAKPhotoAssetViewController: UIViewController {

    private let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("加载相册", for: .normal)
        button.addCorner()
        button.addBorder()
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        XWAKPhotoKit.shared.authorized { (status, limited) in
//            if status && limited {
//                print("被限制，但可以获取图片")
//            }
//            else if status && !limited {
//                print("完全的访问")
//            }
//            else {
//                print("不能访问")
//            }
//        }
        
        setupViews()
        setupLayouts()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(showButton)
        
        showButton.addTarget(self, action: #selector(showButtonTouched(_:)), for: .touchUpInside)
    }
    
    private var items = [PHAssetCollection]()
    @objc
    func showButtonTouched(_ sender: UIButton) {
        let photoView = XWAKPhotoPickerController()
        photoView.maxNumber = 1
        photoView.show(in: self, with: self)
    }
    
    func setupLayouts() {
        showButton.xwak.height(50)
            .left(equalTo: view.safeAreaLayoutGuide.xwak.left, 30)
            .right(equalTo: view.safeAreaLayoutGuide.xwak.right, -30)
            .top(equalTo: view.safeAreaLayoutGuide.xwak.top, 50)
    }
}

extension XWAKPhotoAssetViewController: XWAKPhotoPickerControllerDelegate {
    func viewController(_ viewController: XWAKPhotoPickerController, didSelected items: [UIImage]) {
        print("XWAppKitDemo, XWAKPhotoAssetViewController: ", items.count)
    }
    
    
}
