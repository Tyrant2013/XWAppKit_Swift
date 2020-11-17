//
//  XWAKSelectedItemsView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/17.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSelectedCell: UICollectionViewCell {
    public let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        contentView.addSubview(imageView)
        imageView.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
    }
}

protocol XWAKSelectedItemsViewDelegate {
    func selectedView(_ view: XWAKSelectedItemsView, didSelected item: XWAKPhotoAsset)
}

class XWAKSelectedItemsView: UIView {
    public var items = [XWAKPhotoAsset]()
    public var delegate: XWAKSelectedItemsViewDelegate?
    public var index: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    public var selectedItem: XWAKPhotoAsset? {
        didSet {
            if let item = selectedItem {
                if let index = items.firstIndex(where: { $0.asset.localIdentifier == item.asset.localIdentifier }) {
                    self.index = index
                }
            }
            else {
                self.index = -1
            }
        }
    }
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(XWAKSelectedCell.self, forCellWithReuseIdentifier: "Cell")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.xwak.edge(equalTo: xwak, inset: 0, edges: [.all])
    }
    
    public func add(item: XWAKPhotoAsset) {
        items.append(item)
        collectionView.reloadData()
    }
    
    public func add(items: [XWAKPhotoAsset]) {
        self.items.append(contentsOf: items)
        collectionView.reloadData()
    }
    
    public func remove(removedItem: XWAKPhotoAsset) {
        self.index = -1
        items.removeAll { $0.asset.localIdentifier == removedItem.asset.localIdentifier }
        collectionView.reloadData()
    }
}

extension XWAKSelectedItemsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKSelectedCell
        let item = items[indexPath.row]
        cell.imageView.image = item.thumbImage
        if indexPath.row == index {
            cell.imageView.layer.borderWidth = 5
            cell.imageView.layer.borderColor = UIColor.systemGreen.cgColor
        }
        else {
            cell.imageView.layer.borderWidth = 0
        }
        return cell
    }
    
    
}

extension XWAKSelectedItemsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedView(self, didSelected: items[indexPath.row])
    }
}
