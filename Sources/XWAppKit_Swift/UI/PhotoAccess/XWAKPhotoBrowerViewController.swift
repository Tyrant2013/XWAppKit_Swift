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
        return view
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("返回", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("完成", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
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
    public var items = [XWAKPhotoAsset]()
    public var index: Int = 0
    private var isInit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        if index > 0 {
            isInit = true
            view.layoutIfNeeded()
            collectionView.reloadData()
            
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func setupViews() {
        view.backgroundColor = .black
        view.addSubview(topActionsView)
        topActionsView.addSubview(backButton)
        topActionsView.addSubview(doneButton)
        
        backButton.addTarget(self, action: #selector(backTouched(_:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionsView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        backButton.xwak.edge(equalTo: topActionsView.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        doneButton.xwak.edge(equalTo: topActionsView.xwak, inset: 0, edges: [.top, .bottom, .right])
            .width(80)
        collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
            .top(equalTo: topActionsView.xwak.bottom)
    }
    
    @objc
    func backTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func doneTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension XWAKPhotoBrowerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKPhotoBrowerCell
        cell.setItem(items[indexPath.row], size: collectionView.frame.size)
        return cell
    }
}

extension XWAKPhotoBrowerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.bounds
        return frame.size
    }
}
