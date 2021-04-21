//
//  XWAKBezierConfigList.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/21.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKBezierConfigItemCell: UICollectionViewCell {
    public var index: Int = 0 {
        didSet {
            label.text = "\(index)"
        }
    }
    public let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        contentView.addSubview(label)
        label.xwak.center(equalTo: contentView.xwak)
            .size((20, 20))
        
        contentView.layer.borderColor = UIColor.orange.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 15
    }
}

protocol XWAKBezierConfigListDelegate {
    func listView(_ listView: XWAKBezierConfigList, didSelected index: Int) -> Void
}

class XWAKBezierConfigList: UIView {

    var dataSource = [Int]()
    var delegate: XWAKBezierConfigListDelegate?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 30, height: 30)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.register(XWAKBezierConfigItemCell.self, forCellWithReuseIdentifier: "Cell")
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    private var index: Int = 0 {
        didSet {
            collectionView.visibleCells.forEach {
                $0.contentView.backgroundColor = .white
                ($0 as! XWAKBezierConfigItemCell).label.textColor = .black
            }
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.contentView.backgroundColor = .orange
                (cell as! XWAKBezierConfigItemCell).label.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.xwak.edge(equalTo: xwak, inset: 0, edges: [.all])
    }
    
    func addOne() {
        if let last = dataSource.last {
            dataSource.append(last + 1)
        }
        else {
            dataSource.append(1)
        }
        index = dataSource.count - 1
        collectionView.reloadData()
    }

}

extension XWAKBezierConfigList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKBezierConfigItemCell
        cell.index = dataSource[indexPath.row]
        if indexPath.row == index {
            cell.contentView.backgroundColor = .orange
            cell.label.textColor = .white
        }
        else {
            cell.contentView.backgroundColor = .white
            cell.label.textColor = .black
        }
        return cell
    }
    
    
}

extension XWAKBezierConfigList: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.listView(self, didSelected: indexPath.row)
        index = indexPath.row
    }
}
