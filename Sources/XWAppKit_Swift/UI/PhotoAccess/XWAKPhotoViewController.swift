//
//  XWAKPhotoViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

let XWAKReloadPhotoDatasNotification = Notification.Name("XWAKReloadPhotoDatasNotification")
//protocol XWAKPhotoViewControllerDelegate {
//    func viewController(_ viewController: XWAKPhotoViewController, didSelected items: [UIImage])
//}

class XWAKPhotoViewController: UIViewController {

//    public var delegate: XWAKPhotoViewControllerDelegate?
    
    private var items = [XWAKPhotoAsset]()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.sectionInset = inset
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let screenWidth = UIScreen.main.bounds.width
        let itemPerLine = 4
        let width = (screenWidth - inset.left - inset.right - layout.minimumInteritemSpacing * CGFloat(itemPerLine - 1)) / CGFloat(itemPerLine)
        layout.itemSize = CGSize(width: width, height: width)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topActionBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("关闭", for: .normal)
        button.tintColor = .white
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("完成", for: .normal)
        button.tintColor = .systemGreen
        return button
    }()
    
    private let bottomActionBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    public var isLimited: Bool = false
    private lazy var limitedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    private lazy var limitedCloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("关闭", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(limitedCloseTouched(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var limitedTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "无法访问相册中的所有照片"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var moreDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "只能访问相册中的部分照片，建议前往系统设置，允许访问 照片 中的 所有照片 。"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var systemConfigButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.setTitle("前往系统设置", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addCorner(radius: 5)
        button.addTarget(self, action: #selector(systemConfigTouched(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var takeMorePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("选择更多图片", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(takeMorePhotoTouched(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var keepCurrentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("继续访问部分照片", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(keepCurrentPhotoTouched(_:)), for: .touchUpInside)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        loadData()
        NotificationCenter.default.addObserver(forName: XWAKReloadPhotoDatasNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self](notification) in
            self?.loadData()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGray
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(topActionBar)
        topActionBar.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelTouched(_:)), for: .touchUpInside)
        
        view.addSubview(bottomActionBar)
        bottomActionBar.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(XWAKPhotoCell.self, forCellWithReuseIdentifier: "Cell")
        
        if isLimited {
            view.addSubview(limitedView)
            limitedView.addSubview(limitedCloseButton)
            limitedView.addSubview(limitedTitleLabel)
            limitedView.addSubview(moreDescriptionLabel)
            limitedView.addSubview(systemConfigButton)
            limitedView.addSubview(takeMorePhotoButton)
            limitedView.addSubview(keepCurrentButton)
        }
    }
    
    private func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionBar.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        cancelButton.xwak.edge(equalTo: topActionBar.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        
        collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right])
            .top(equalTo: topActionBar.xwak.bottom)
            .bottom(equalTo: bottomActionBar.xwak.top)
        
        bottomActionBar.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
            .height(50)
        doneButton.xwak.edge(equalTo: bottomActionBar.xwak, inset: 0, edges: [.top, .bottom, .right])
            .width(80)
        
        if isLimited {
            limitedView.xwak.edge(equalTo: safe, inset: 0, edges: [.all])
            limitedCloseButton.xwak.edge(equalTo: limitedView.xwak, inset: 20, edges: [.top, .left])
                .size((60, 30))
            limitedTitleLabel.xwak.centerX(equalTo: limitedView.xwak.centerX)
                .top(equalTo: limitedView.xwak.top, 80)
                .height(50)
            moreDescriptionLabel.xwak.edge(equalTo: limitedView.xwak, inset: 10, edges: [.left, .right])
                .top(equalTo: limitedTitleLabel.xwak.bottom, 20)
            keepCurrentButton.xwak.bottom(equalTo: limitedView.xwak.bottom, -10)
                .edge(equalTo: limitedView.xwak, inset: 30, edges: [.left, .right])
                .height(40)
            takeMorePhotoButton.xwak.bottom(equalTo: keepCurrentButton.xwak.top, -20)
                .edge(equalTo: limitedView.xwak, inset: 30, edges: [.left, .right])
                .height(40)
            systemConfigButton.xwak.bottom(equalTo: takeMorePhotoButton.xwak.top, -40)
                .centerX(equalTo: limitedView.xwak.centerX)
                .size((200, 40))
        }
        
    }
    
    private func loadData() {
        XWAKPhotoKit.shared.loadPhotos { [weak self]result in
            switch result {
            case .success(let items):
                self?.items.removeAll()
                self?.items.append(contentsOf: items)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func show(in viewController: UIViewController) {
        modalPresentationStyle = .fullScreen
        viewController.present(self, animated: true, completion: nil)
    }
    
    @objc
    func cancelTouched(_ sender: UIButton) {
        XWAKPhoto.shared.clear()
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func doneTouched(_ sender: UIButton) {
        dismiss(animated: true) {
            XWAKPhoto.shared.selectionHandler?()
            XWAKPhoto.shared.clear()
        }
    }
    
    @objc
    func limitedCloseTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func systemConfigTouched(_ sender: UIButton) {
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url,
                                  options: [UIApplication.OpenExternalURLOptionsKey : Any](),
                                  completionHandler: nil)
    }
    
    private func hideLimitedAlertView() {
        UIView.animate(withDuration: 0.25) {[weak self] in
            self?.limitedView.alpha = 0.0
        } completion: { [weak self](finished) in
            self?.limitedView.removeFromSuperview()
        }
    }
    @objc
    func takeMorePhotoTouched(_ sender: UIButton) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.shared().register(self)
            PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: self)
        }
    }
    
    @objc
    func keepCurrentPhotoTouched(_ sender: UIButton) {
        hideLimitedAlertView()
    }

}

extension XWAKPhotoViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKPhotoCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
}

extension XWAKPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brower = XWAKPhotoBrowerViewController()
        brower.index = indexPath.row
        brower.items = items
        navigationController?.pushViewController(brower, animated: true)
    }
}

extension XWAKPhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        loadData()
        DispatchQueue.main.async {
            self.hideLimitedAlertView()
        }
    }
}
