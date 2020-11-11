//
//  XWAKPhotoBrowerCell.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKPhotoBrowerCell: UICollectionViewCell {
    
    private let imageShow: XWAKImageBrower = {
        let view = XWAKImageBrower()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(imageShow)
        imageShow.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
    }
    
    func setItem(_ item: XWAKPhotoAsset, size: CGSize) {
        self.imageShow.image = item.originImage == nil ? item.thumbImage : item.originImage
        if item.originImage == nil {
            item.loadOriginImage { (image) in
                item.originImage = image
                if let image = image {
                    self.imageShow.image = image
                }
            }
        }
        item.loadThumb(size: size) { [weak self](image) in
            if let image = image {
                item.thumbImage = image
                self?.imageShow.image = image
            }
        }
    }
}
