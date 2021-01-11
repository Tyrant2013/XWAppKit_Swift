//
//  XWAKPhotoBrowerViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKPhotoBrowerViewController: UIViewController {

    private let topActionsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("返回", for: .normal)
        button.tintColor = .white
        return button
    }()
    private let stateImageView: UIImageView = {
        let im = UIImage.xwak_frameImage(name: "check-circle")
        let image = UIImageView(image: im)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .lightGray
        return image
    }()
    private let totalNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.addCorner(radius: 5)
        label.textAlignment = .center
        label.text = "0"
        label.clipsToBounds = true
        label.addCorner(radius: 15)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isPagingEnabled = true
        view.register(XWAKPhotoBrowerCell.self, forCellWithReuseIdentifier: "Cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let selectedView: XWAKSelectedItemsView = {
        let view = XWAKSelectedItemsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.95)
        return view
    }()
    
    private let bottomActionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("完成", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.addCorner(radius: 5)
        button.isEnabled = false
        return button
    }()
    
    public var items = [XWAKPhotoAsset]()
    public var index: Int = -1 {
        didSet {
            guard items.count > index else {
                return
            }
            let item = items[index]
            if item.isSelected {
                selectedView.selectedItem = item
            }
            else {
                selectedView.selectedItem = nil
            }
        }
    }
    private var isInit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setupNotifications()
    }
    
    private func setText(index: Int) {
        totalNumLabel.text = "\(index)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isInit {
            isInit = true
            if index >= 0 {
                let indexPath = IndexPath(row: index, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                let item = items[index]
                if XWAKPhoto.shared.items.count > 0 {
                    selectedView.add(items: XWAKPhoto.shared.items)
                }
                if item.isSelected {
                    selectedView.selectedItem = item
                }
            }
        }
    }
    
    func setupViews() {
        view.backgroundColor = .systemGray
        view.addSubview(topActionsView)
        topActionsView.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backTouched(_:)), for: .touchUpInside)
        topActionsView.addSubview(totalNumLabel)
        topActionsView.addSubview(stateImageView)
        
        view.addSubview(bottomActionView)
        bottomActionView.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        
        totalNumLabel.isHidden = true
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTouched(_:)))
        stateImageView.addGestureRecognizer(imageTap)
        stateImageView.isUserInteractionEnabled = true
        
        let numTap = UITapGestureRecognizer(target: self, action: #selector(numTouched(_:)))
        totalNumLabel.addGestureRecognizer(numTap)
        totalNumLabel.isUserInteractionEnabled = true
        
        view.addSubview(selectedView)
        selectedView.delegate = self
        
        if index == 0 {
            let item = items[index]
            totalNumLabel.text = "\(item.index)"
            totalNumLabel.isHidden = !item.isSelected
            stateImageView.isHidden = item.isSelected
        }
    }
    
    func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionsView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        backButton.xwak.edge(equalTo: topActionsView.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        totalNumLabel.xwak.edge(equalTo: topActionsView.xwak, inset: 10, edges: [.right])
            .centerY(equalTo: topActionsView.xwak.centerY)
            .size((30, 30))
        stateImageView.xwak.edge(equalTo: totalNumLabel.xwak, inset: 0, edges: [.all])
        
        collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right])
            .top(equalTo: topActionsView.xwak.bottom)
            .bottom(equalTo: bottomActionView.xwak.top)
        
        bottomActionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
            .height(50)
        doneButton.xwak.centerY(equalTo: bottomActionView.xwak.centerY)
            .right(equalTo: bottomActionView.xwak.right, -10)
            .size((100, 30))
        
        selectedView.xwak.bottom(equalTo: bottomActionView.xwak.top)
            .edge(equalTo: safe, inset: 0, edges: [.left, .right])
            .height(80)
    }
    
    func setupNotifications() {
        NotificationCenter.add(name: XWAKPhoto.SelectionRemoveIndexNotification) { [weak self](notification) in
            let removedIndex = notification.object as! Int
            self?.items.filter { $0.isSelected && $0.index > removedIndex }
                .forEach({ $0.index -= 1 })
        }
    }
    
    @objc
    func backTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func imageTouched(_ sender: UITapGestureRecognizer) {
        if XWAKPhoto.shared.count < XWAKPhoto.shared.max {
            let item = items[index]
            XWAKPhoto.shared.add(item)
            selectedView.add(item: item)
            selectedView.selectedItem = item
            totalNumLabel.text = "\(XWAKPhoto.shared.count)"
            stateImageView.isHidden = true
            totalNumLabel.isHidden = false
            totalNumLabel.scaleAnimation()
            doneButton.isEnabled = true
        }
    }
    
    @objc
    func numTouched(_ sender: UITapGestureRecognizer) {
        let item = items[index]
        XWAKPhoto.shared.remove(item, index: item.index)
        selectedView.remove(removedItem: item)
        stateImageView.isHidden = false
        totalNumLabel.isHidden = true
        if XWAKPhoto.shared.selectedItems.count == 0 {
            doneButton.isEnabled = false
        }
    }
    
    @objc
    func doneTouched(_ sender: UIButton) {
        dismiss(animated: true) {
            XWAKPhoto.shared.selectionHandler?()
            XWAKPhoto.shared.clear()
        }
    }

}

extension XWAKPhotoBrowerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKPhotoBrowerCell
        cell.item = items[indexPath.row]
        return cell
    }
}

extension XWAKPhotoBrowerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.bounds
        return frame.size
    }
}

extension XWAKPhotoBrowerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var index = Int(floor(offsetX / scrollView.bounds.width))
        let mid = CGFloat(index) * scrollView.bounds.width + scrollView.bounds.width / 3
        if index >= 0 {
            var item = items[Int(index)]
            if offsetX > mid {
                index += 1
                if index < items.count {
                    item = items[Int(index)]
                }
            }
            totalNumLabel.text = "\(item.index)"
            totalNumLabel.isHidden = !item.isSelected
            stateImageView.isHidden = item.isSelected
            self.index = index
        }
    }
}

extension XWAKPhotoBrowerViewController: XWAKSelectedItemsViewDelegate {
    func selectedView(_ view: XWAKSelectedItemsView, didSelected item: XWAKPhotoAsset) {
        if let index = items.firstIndex(where: { $0.asset.localIdentifier == item.asset.localIdentifier }) {
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}
