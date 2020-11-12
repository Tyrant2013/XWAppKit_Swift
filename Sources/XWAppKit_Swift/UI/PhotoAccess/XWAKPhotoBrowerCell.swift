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
    public weak var item: XWAKPhotoAsset? {
        didSet {
            if requestID != PHInvalidImageRequestID {
                XWAKPhotoKit.shared.cancel(requestId: requestID)
            }
            if let item = item {
                requestID = item.loadOriginImage { [weak self](image) in
                    self?.imageShow.image = image
                }
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
        imageShow.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
    }
}
