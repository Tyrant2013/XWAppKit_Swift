//
//  XWAKPhotoViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos

protocol XWAKPhotoViewControllerDelegate {
    func viewController(_ viewController: XWAKPhotoViewController, didSelected items: [UIImage])
}

class XWAKPhotoViewController: UIViewController {

    public var delegate: XWAKPhotoViewControllerDelegate?
    
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
        return view
    }()
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("关闭", for: .normal)
        return button
    }()
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("完成", for: .normal)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        loadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(topActionBar)
        topActionBar.addSubview(cancelButton)
        topActionBar.addSubview(doneButton)
        cancelButton.addTarget(self, action: #selector(cancelTouched(_:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneTouched(_:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(XWAKPhotoCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private func setupLayouts() {
        let safe = view.safeAreaLayoutGuide.xwak
        topActionBar.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .top])
            .height(50)
        cancelButton.xwak.edge(equalTo: topActionBar.xwak, inset: 0, edges: [.top, .bottom, .left])
            .width(80)
        doneButton.xwak.edge(equalTo: topActionBar.xwak, inset: 0, edges: [.top, .bottom, .right])
            .width(80)
        collectionView.xwak.edge(equalTo: safe, inset: 0, edges: [.left, .right, .bottom])
            .top(equalTo: topActionBar.xwak.bottom)
    }
    
    private func loadData() {
        XWAKPhotoKit.shared.loadPhotos { [weak self]result in
            switch result {
            case .success(let items):
                self?.items.append(contentsOf: items)
                self?.collectionView.reloadData()
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
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func doneTouched(_ sender: UIButton) {
        delegate?.viewController(self, didSelected: XWAKPhoto.shared.selectedItems)
        dismiss(animated: true, completion: nil)
        XWAKPhoto.shared.clear()
    }

}

extension XWAKPhotoViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! XWAKPhotoCell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        cell.setItem(items[indexPath.row], size: layout.itemSize)
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
