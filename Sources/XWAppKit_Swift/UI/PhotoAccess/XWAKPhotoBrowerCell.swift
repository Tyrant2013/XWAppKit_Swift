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
    private let progress: XWAKProgressView = {
        let view = XWAKProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    public weak var item: XWAKPhotoAsset! {
        didSet {
            if requestID != PHInvalidImageRequestID {
                XWAKPhotoKit.shared.cancel(requestId: requestID)
                progress.progress = 0.0
                progress.isHidden = true
            }
            let text = item.index == 0 ? "" : "\(item.index)"
            indexLabel.setupState(item.isSelected, text: text)
            
            progress.isHidden = false
            requestID = item.loadOriginImage(progress: { [weak self](pencent) in
                self?.progress.isHidden = false
                self?.progress.progress = pencent
            }, { [weak self](image) in
                self?.progress.isHidden = true
                self?.imageShow.image = image
            })
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
        contentView.addSubview(progress)
        
        imageShow.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        indexLabel.xwak.edge(equalTo: contentView.xwak, inset: 10, edges: [.top, .right])
            .size((24, 24))
        progress.xwak.center(equalTo: contentView.xwak)
            .size((80, 80))
        
        progress.progress = 0.0
        indexLabel.isHidden = true
        progress.isHidden = true
        progress.backgroundColor = .clear
    }
}
