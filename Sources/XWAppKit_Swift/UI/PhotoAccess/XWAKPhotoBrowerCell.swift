//
//  XWAKPhotoBrowerCell.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos

class XWAKPhotoBrowerCell: UICollectionViewCell {
    
    private let imageShow: XWAKImageBrower = {
        let view = XWAKImageBrower()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        label.addBorder(width: 2, color: .white)
        label.addCorner(radius: 12)
        return label
    }()
    public weak var item: XWAKPhotoAsset! {
        didSet {
            if requestID != PHInvalidImageRequestID {
                XWAKPhotoKit.shared.cancel(requestId: requestID)
            }
            let text = item.index == 0 ? "" : "\(item.index)"
            indexLabel.setupState(item.isSelected, text: text)
            
            requestID = item.loadOriginImage { [weak self](image) in
                self?.imageShow.image = image
            }
        }
    }
    private var requestID: PHImageRequestID = PHInvalidImageRequestID
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        contentView.addSubview(imageShow)
        contentView.addSubview(indexLabel)
        
        imageShow.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        indexLabel.xwak.edge(equalTo: contentView.xwak, inset: 10, edges: [.top, .right])
            .size((24, 24))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(indexTap(_:)))
        indexLabel.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(forName: XWAKPhoto.SelectionRemoveIndexNotification, object: nil, queue: OperationQueue.main) { [weak self](notification) in
            let removedIndex = notification.object as! Int
            if let text = self?.indexLabel.text, let num = Int(text), num > removedIndex {
                self?.indexLabel.text = "\(num - 1)"
            }
        }
    }
    
    @objc
    func indexTap(_ sender: UITapGestureRecognizer) {
        if item.isSelected {
            if let text = indexLabel.text, let num = Int(text) {
                XWAKPhoto.shared.remove(item, index: num)
            }
        }
        else {
            XWAKPhoto.shared.add(item)
        }

        let text = item.isSelected ? "\(XWAKPhoto.shared.count)" : ""
        indexLabel.setupState(item.isSelected, text: text)
    }
}
