//
//  XWAKPhotoCell.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos

class XWAKPhotoCell: UICollectionViewCell {
    private var item: XWAKPhotoAsset!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.addCorner()
//        view.clipsToBounds = true
        return view
    }()
    private let numLabel: UILabel = {
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
    
    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(numLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(numberTap(_:)))
        numLabel.addGestureRecognizer(tap)
        
        imageView.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        numLabel.xwak.edge(equalTo: contentView.xwak, inset: 5, edges: [.top, .right])
            .size((24, 24))
    }
    
    @objc
    func numberTap(_ sender: UITapGestureRecognizer) {
        if item.isSelected {
            XWAKPhoto.shared.remove(item)
        }
        else {
            XWAKPhoto.shared.add(item)
        }
        
        numLabel.backgroundColor = item.isSelected ? .systemGreen : .clear
        numLabel.layer.borderColor = item.isSelected ? UIColor.systemGreen.cgColor : UIColor.white.cgColor
        numLabel.text = item.isSelected ? "\(XWAKPhoto.shared.count)" : ""
        if item.isSelected {
            numLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.15) {
                self.numLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } completion: { (finished) in
                UIView.animate(withDuration: 0.1) {
                    self.numLabel.transform = .identity
                }
            }
        }
    }
    
    func setItem(_ item: XWAKPhotoAsset, size: CGSize) {
        self.item = item
        item.loadThumb(size: size) { [weak self](image) in
            self?.imageView.image = image
        }
    }
}
