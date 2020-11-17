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
    public weak var item: XWAKPhotoAsset? {
        didSet {
            if requestId != PHInvalidImageRequestID {
                XWAKPhotoKit.shared.cancel(requestId: requestId)
            }
            guard let item = item else { return }
            let text = item.index == 0 ? "" : "\(item.index)"
            numLabel.setupState(item.isSelected, text: text)
            
            requestId = item.loadThumb(progress: { (percent) in
                
            }, { [weak self](image) in
                self?.imageView.image = image
            })
        }
    }
    private var requestId: PHImageRequestID = PHInvalidImageRequestID
    
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
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
        
        NotificationCenter.default.addObserver(forName: XWAKPhoto.SelectionAddNotification, object: nil, queue: OperationQueue.main) { [weak self](notification) in
            let item = notification.object as! XWAKPhotoAsset
            if item.asset.localIdentifier == self?.item?.asset.localIdentifier {
                self?.numLabel.setupState(item.isSelected, text: "\(item.index)")
            }
        }
        
        NotificationCenter.default.addObserver(forName: XWAKPhoto.SelectionRemoveIndexNotification, object: nil, queue: OperationQueue.main) { [weak self](notification) in
            let removedIndex = notification.object as! Int
            if let text = self?.numLabel.text, let num = Int(text) {
                if num > removedIndex {
                    self?.item?.index -= 1
                    self?.numLabel.text = "\(num - 1)"
                }
                else if num == removedIndex {
                    self?.numLabel.setupState(false, text: "")
                }
            }
            else {
            }
        }
    }
    
    @objc
    func numberTap(_ sender: UITapGestureRecognizer) {
        if item?.isSelected ?? false {
            if let text = numLabel.text, let num = Int(text) {
                XWAKPhoto.shared.remove(item!, index: num)
            }
        }
        else {
            XWAKPhoto.shared.add(item!)
        }
        
        let indexText = (item?.isSelected ?? false) ? "\(XWAKPhoto.shared.count)" : ""
        numLabel.setupState((item?.isSelected ?? false), text: indexText)

//        numLabel.backgroundColor = item.isSelected ? .systemGreen : .clear
//        numLabel.layer.borderColor = item.isSelected ? UIColor.systemGreen.cgColor : UIColor.white.cgColor
//        numLabel.text = item.isSelected ? "\(XWAKPhoto.shared.count)" : ""
//        if item.isSelected { numLabel.scaleAnimation() }
    }
}
