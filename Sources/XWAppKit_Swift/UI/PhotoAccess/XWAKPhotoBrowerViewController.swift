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
    private let totalNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.addCorner(radius: 5)
        label.textAlignment = .center
        label.text = "( 0 )"
        label.clipsToBounds = true
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
        button.tintColor = .systemGreen
        return button
    }()
    
    public var items = [XWAKPhotoAsset]()
    public var index: Int = 0
    private var isInit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setupNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isInit {
            isInit = true
            if index > 0 {
                let indexPath = IndexPath(row: index, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    func setupViews() {
        view.backgroundColor = .systemGray
        view.addSubview(topActionsView)
        topActionsView.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backTouched(_:)), for: .touchUpInside)
        topActionsView.addSubview(totalNumLabel)
        
        view.addSubview(bottomActionView)
        bottomActionView.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        
        totalNumLabel.text = "( \(XWAKPhoto.shared.count) )"
    }
    
    func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionsView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        backButton.xwak.edge(equalTo: topActionsView.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        totalNumLabel.xwak.edge(equalTo: topActionsView.xwak, inset: 10, edges: [.right])
            .centerY(equalTo: topActionsView.xwak.centerY)
            .width(40)
            .height(24)
        
        collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right])
            .top(equalTo: topActionsView.xwak.bottom)
            .bottom(equalTo: bottomActionView.xwak.top)
        
        bottomActionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
            .height(50)
        doneButton.xwak.edge(equalTo: bottomActionView.xwak, inset: 0, edges: [.top, .bottom, .right])
            .width(80)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(forName: XWAKPhoto.SelectionAddNotification, object: nil, queue: OperationQueue.main) { [weak self](notification) in
            self?.totalNumLabel.text = "( \(XWAKPhoto.shared.count) )"
            self?.totalNumLabel.scaleAnimation()
        }
        NotificationCenter.default.addObserver(forName: XWAKPhoto.SelectionRemoveIndexNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self](notification) in
            self?.totalNumLabel.text = "( \(XWAKPhoto.shared.count) )"
            self?.totalNumLabel.scaleAnimation()
        }
    }
    
    @objc
    func backTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func doneTouched(_ sender: UIButton) {
        XWAKPhoto.shared.selectionHandler?()
        dismiss(animated: true, completion: nil)
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
