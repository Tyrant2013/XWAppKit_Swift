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

private extension String {
    static let current = "最近项目"
    static let limite = "可访问的照片"
}

class XWAKPhotoViewController: UIViewController {
    
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
        view.backgroundColor = .black
        return view
    }()
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("关闭", for: .normal)
        button.tintColor = .white
        return button
    }()
    private let collectionSelectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .xwak_color(with: "0x555555")
        view.addCorner(radius: 15)
        return view
    }()
    private var listTap: UITapGestureRecognizer!
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.isUserInteractionEnabled = false
        label.text = ""
        return label
    }()
    private var lableWidth: NSLayoutConstraint!
    private var labelTextWidth: CGFloat {
        if let text = titleLabel.text {
            let attris = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)]
            return NSAttributedString(string: text, attributes: attris).boundingRect(with: CGSize(width: 1000, height: 30), options: .usesLineFragmentOrigin, context: nil).width + 2
        }
        return 0
    }
    private let arrowImageVIew: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage.xwak_frameImage(name: "down-circle-fill")
        view.backgroundColor = .white
        view.tintColor = .xwak_color(with: "0x555555")
        view.addCorner(radius: 10)
        view.clipsToBounds = true
        return view
    }()
    private let listView: XWAKCollectionListView = {
        let view = XWAKCollectionListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var listHeight: NSLayoutConstraint!
    
    private let previewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("预览", for: .normal)
        button.tintColor = .systemGreen
        button.isEnabled = false
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("完成", for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.addCorner(radius: 5)
        button.isEnabled = false
        return button
    }()
    
    private let bottomActionBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupViews()
        setupLayouts()
        setupNotifications()
        loadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(topActionBar)
        topActionBar.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelTouched(_:)), for: .touchUpInside)
        
        topActionBar.addSubview(collectionSelectionView)
        collectionSelectionView.addSubview(titleLabel)
        collectionSelectionView.addSubview(arrowImageVIew)
        listTap = UITapGestureRecognizer(target: self, action: #selector(collectionSelectionTap(_:)))
        collectionSelectionView.addGestureRecognizer(listTap)
        collectionSelectionView.isUserInteractionEnabled = true
        
        // 可多选图片时，显示最下面的操作条
        if XWAKPhoto.shared.max > 1 {
            view.addSubview(bottomActionBar)
            bottomActionBar.addSubview(doneButton)
            bottomActionBar.addSubview(previewButton)
            previewButton.addTarget(self, action: #selector(previewTouched(_:)), for: .touchUpInside)
            doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(XWAKPhotoCell.self, forCellWithReuseIdentifier: "Cell")
        
        // 被限制访问时
        if isLimited {
            view.addSubview(limitedView)
            limitedView.addSubview(limitedCloseButton)
            limitedView.addSubview(limitedTitleLabel)
            limitedView.addSubview(moreDescriptionLabel)
            limitedView.addSubview(systemConfigButton)
            limitedView.addSubview(takeMorePhotoButton)
            limitedView.addSubview(keepCurrentButton)
        }
        
        view.addSubview(listView)
        listView.alpha = 0.0
        listView.delegate = self
    }
    
    private func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionBar.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        cancelButton.xwak.edge(equalTo: topActionBar.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        collectionSelectionView.xwak.center(equalTo: topActionBar.xwak)
            .height(30)
        titleLabel.xwak.edge(equalTo: collectionSelectionView.xwak,
                             inset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0),
                             edges: [.left, .top, .bottom])
        lableWidth = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: labelTextWidth)
        lableWidth.isActive = true
        
        arrowImageVIew.xwak.edge(equalTo: collectionSelectionView.xwak, inset: 5, edges: [.top, .bottom])
            .right(equalTo: collectionSelectionView.xwak.right, -10)
            .left(equalTo: titleLabel.xwak.right, 10)
            .width(equalTo: arrowImageVIew.xwak.height)
        
        // 多选时
        if XWAKPhoto.shared.max > 1 {
            collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right])
                .top(equalTo: topActionBar.xwak.bottom)
                .bottom(equalTo: bottomActionBar.xwak.top)
            
            bottomActionBar.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
                .height(50)
            previewButton.xwak.edge(equalTo: bottomActionBar.xwak, inset: 10, edges: [.top, .bottom, .left])
                .width(80)
            doneButton.xwak.edge(equalTo: bottomActionBar.xwak, inset: 10, edges: [.top, .bottom, .right])
                .width(100)
        }
        else {
            collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
                .top(equalTo: topActionBar.xwak.bottom)
        }
        
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
        
        listView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right])
            .top(equalTo: topActionBar.xwak.bottom)
            .bottom(equalTo: safe.bottom)
    }
    private func setupNotifications() {
        NotificationCenter.add(name: XWAKReloadPhotoDatasNotification) { [weak self](notification) in
            self?.loadData()
        }
        
        NotificationCenter.add(name: XWAKPhoto.SelectionAddNotification) { [weak self](notification) in
            if XWAKPhoto.shared.count > 0 {
                self?.previewButton.isEnabled = true
                self?.doneButton.isEnabled = true
                self?.doneButton.setTitle("完成 (\(XWAKPhoto.shared.count))", for: .normal)
            }
        }
        NotificationCenter.add(name: XWAKPhoto.SelectionRemoveIndexNotification) { [weak self](notification) in
            if XWAKPhoto.shared.count == 0 {
                self?.previewButton.isEnabled = false
                self?.doneButton.isEnabled = false
                self?.doneButton.setTitle("完成", for: .normal)
            }
            else {
                self?.doneButton.setTitle("完成 (\(XWAKPhoto.shared.count))", for: .normal)
            }
        }
    }
    
    private func loadData() {
        initListView()
        
        XWAKPhotoKit.shared.loadPhotos { [weak self]result in
            self?.configResult(result)
        }
    }
    private func configResult(_ result: Result<[XWAKPhotoAsset], Error>) {
        switch result {
        case .success(let items):
            self.items.removeAll()
            self.items.append(contentsOf: items)
            if XWAKPhoto.shared.items.count > 0 {
                let newSet = Set<XWAKPhotoAsset>(items)
                for item in XWAKPhoto.shared.items {
                    if let index = newSet.firstIndex(of: item) {
                        newSet[index].isSelected = item.isSelected
                        newSet[index].index = item.index
                    }
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure(let error):
            print("load photos: ", error)
        }
    }
    private func initListView() {
        listView.items.removeAll()
        var items = XWAKPhotoKit.shared.loadAllCollections().compactMap { $0.localizedTitle }
        let title = XWAKPhotoKit.shared.isLimited ? String.limite : .current
        items.insert(title , at: 0)
        titleLabel.text = title
        listView.items = items
        calculateTitleSize()
    }
    private func calculateTitleSize() {
        lableWidth.constant = labelTextWidth
        UIView.animate(withDuration: 0.25) {
            self.topActionBar.layoutIfNeeded()
        }
    }
    
    public func show(in viewController: UIViewController) {
        modalPresentationStyle = .fullScreen
        viewController.present(self, animated: true, completion: nil)
    }
    
    private var isShowList = false
    private func showCollectionList() {
        isShowList = true
        listTap.isEnabled = false
        UIView.animate(withDuration: 0.25) {
            self.arrowImageVIew.transform = .init(rotationAngle: .pi)
        } completion: { (finished) in
            self.listTap.isEnabled = true
        }
        listView.show()
    }
    private func hideCollectionList() {
        listView.hide()
    }
    
    @objc
    func collectionSelectionTap(_ sender: UITapGestureRecognizer) {
        if !isShowList {
            showCollectionList()
        }
        else {
            hideCollectionList()
        }
    }
    
    @objc
    func cancelTouched(_ sender: UIButton) {
        XWAKPhoto.shared.clear()
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func previewTouched(_ sender: UIButton) {
        let brower = XWAKPhotoBrowerViewController()
        brower.index = 0
        brower.items = XWAKPhoto.shared.items
        navigationController?.pushViewController(brower, animated: true)
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
        if XWAKPhoto.shared.max > 1 {
            let brower = XWAKPhotoBrowerViewController()
            brower.index = indexPath.row
            brower.items = items
            navigationController?.pushViewController(brower, animated: true)
        }
        else {
            let item = items[indexPath.row]
            let finishedSelection = {
                XWAKPhoto.shared.add(item)
                self.dismiss(animated: true) {
                    XWAKPhoto.shared.selectionHandler?()
                    XWAKPhoto.shared.clear()
                }
            }
            if item.originImage == nil {
                _ = item.loadOriginImage { (progress) in
                    XWAKHud.show()
                } _: { (image) in
                    XWAKHud.dismiss()
                    if image != nil && item.originImage != nil {
                        item.originImage = image
                        finishedSelection()
                    }
                    else {
                        if item.originImage == nil {
                            XWAKHud.show(in: nil,
                                         title: "",
                                         msg: "",
                                         showIndicator: false,
                                         delay: 1.5,
                                         ignoreInteraction: true)
                        }
                        else {
                            finishedSelection()
                        }
                    }
                }
            }
            else {
                finishedSelection()
            }
        }
    }
}

extension XWAKPhotoViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            self.loadData()
            self.hideLimitedAlertView()
        }
    }
}

extension XWAKPhotoViewController: XWAKCollectionListViewDelegate {
    func listView(_ listView: XWAKCollectionListView, will Hide: Bool) {
        isShowList = false
        listTap.isEnabled = false
        UIView.animate(withDuration: 0.25) {
            self.arrowImageVIew.transform = .identity
        } completion: { (finished) in
            self.listTap.isEnabled = true
        }
    }
    
    func listView(_ listView: XWAKCollectionListView, didSelected item: String) {
        titleLabel.text = item
        calculateTitleSize()
        if item == .current || item == .limite {
            XWAKPhotoKit.shared.loadPhotos { [weak self](result) in
                self?.configResult(result)
            }
            return
        }
        XWAKPhotoKit.shared.loadPhotos(from: item) { [weak self](result) in
            self?.configResult(result)
        }
    }
}
