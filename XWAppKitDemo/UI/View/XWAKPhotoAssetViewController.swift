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
    private let limitedOneButton: UISwitch = {
        let vv = UISwitch()
        vv.translatesAutoresizingMaskIntoConstraints = false
        return vv
    }()
    private let limitedOneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "选一个图片";
        return label
    }()
    private let multipleButton: UISwitch = {
        let vv = UISwitch()
        vv.translatesAutoresizingMaskIntoConstraints = false
        return vv
    }()
    private let multipleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "选多个图片";
        return label
    }()
    private var limited: Int = 1
    
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
        
        view.addSubview(limitedOneButton)
        view.addSubview(limitedOneLabel)
        view.addSubview(multipleButton)
        view.addSubview(multipleLabel)
        
        limitedOneButton.isOn = true
        
        limitedOneButton.addTarget(self, action: #selector(limitedOneValueChange(_:)), for: .valueChanged)
        multipleButton.addTarget(self, action: #selector(multipleValueChange(_:)), for: .valueChanged)
        
        showButton.addTarget(self, action: #selector(showButtonTouched(_:)), for: .touchUpInside)
    }
    
    private var items = [PHAssetCollection]()
    @objc
    func showButtonTouched(_ sender: UIButton) {
        let photoView = XWAKPhotoPickerController()
        photoView.maxNumber = limited
        photoView.show(in: self, with: self)
    }
    
    @objc
    func limitedOneValueChange(_ sender: UISwitch) {
        multipleButton.setOn(!sender.isOn, animated: true)
        limited = sender.isOn ? 1 : (Int(arc4random()) % 9 + 1)
    }
    
    @objc
    func multipleValueChange(_ sender: UISwitch) {
        limitedOneButton.setOn(!sender.isOn, animated: true)
        limited = sender.isOn ? (Int(arc4random()) % 9 + 1) : 1
    }
    
    func setupLayouts() {
        showButton.xwak.height(50)
            .left(equalTo: view.safeAreaLayoutGuide.xwak.left, 30)
            .right(equalTo: view.safeAreaLayoutGuide.xwak.right, -30)
            .top(equalTo: view.safeAreaLayoutGuide.xwak.top, 50)
        
        limitedOneButton.xwak.left(equalTo: showButton.xwak.left)
            .top(equalTo: showButton.xwak.bottom, 10)
        limitedOneLabel.xwak.left(equalTo: limitedOneButton.xwak.right, 10)
            .centerY(equalTo: limitedOneButton.xwak.centerY)
            .right(equalTo: view.safeAreaLayoutGuide.xwak.right, -30)
            .height(30)
        
        multipleButton.xwak.left(equalTo: limitedOneButton.xwak.left)
            .top(equalTo: limitedOneButton.xwak.bottom, 10)
        multipleLabel.xwak.left(equalTo: multipleButton.xwak.right, 10)
            .centerY(equalTo: multipleButton.xwak.centerY)
            .right(equalTo: view.safeAreaLayoutGuide.xwak.right, -30)
            .height(30)
    }
}

extension XWAKPhotoAssetViewController: XWAKPhotoPickerControllerDelegate {
    func viewController(_ viewController: XWAKPhotoPickerController, didSelected items: [UIImage]) {
        print("XWAppKitDemo, XWAKPhotoAssetViewController: ", items.count)
    }
    
    
}
