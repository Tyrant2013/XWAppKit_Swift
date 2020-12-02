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
            
            _ = XWAKPhoto.shared.isSelectedItem(item)
            
            let text = item.index == 0 ? "" : "\(item.index)"
            
            numLabel.setupState(item.isSelected, text: text)
            
            if item.isSelected {
                selectionView.isHidden = false
                noActionView.isHidden = true
            }
            else {
                selectionView.isHidden = true
                noActionView.isHidden = !(XWAKPhoto.shared.count == XWAKPhoto.shared.max)
            }
            
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
        label.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return label
    }()
    private let selectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    private let noActionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        return view
    }()
    
    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(selectionView)
        contentView.addSubview(numLabel)
        contentView.addSubview(noActionView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(numberTap(_:)))
        numLabel.addGestureRecognizer(tap)
        
        imageView.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        numLabel.xwak.edge(equalTo: contentView.xwak, inset: 5, edges: [.top, .right])
            .size((24, 24))
        selectionView.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        noActionView.xwak.edge(equalTo: contentView.xwak, inset: 0, edges: [.all])
        
        selectionView.isHidden = true
        noActionView.isHidden = true
        
        NotificationCenter.add(name: XWAKPhoto.SelectionAddNotification) { [weak self](notification) in
            let item = notification.object as! XWAKPhotoAsset
            if item.asset.localIdentifier == self?.item?.asset.localIdentifier {
                self?.numLabel.setupState(item.isSelected, text: "\(item.index)")
                self?.selectionView.isHidden = !item.isSelected
            }
        }

        NotificationCenter.add(name: XWAKPhoto.SelectionRemoveIndexNotification) { [weak self](notification) in
            let removedIndex = notification.object as! Int
            if let text = self?.numLabel.text, let num = Int(text) {
                if num > removedIndex {
                    self?.item?.index -= 1
                    self?.numLabel.text = "\(num - 1)"
                }
                else if num == removedIndex {
                    self?.numLabel.setupState(false, text: "")
                    self?.selectionView.isHidden = true
                }
            }
        }

        NotificationCenter.add(name: XWAKPhoto.NoMorePhotoSelectionNotification) { [weak self](notification) in
            self?.noActionView.isHidden = false || (self?.item?.isSelected ?? false)
        }

        NotificationCenter.add(name: XWAKPhoto.ContinuePhotoSelectionNotification) { [weak self](notification) in
            self?.noActionView.isHidden = true
        }

    }
    
    @objc
    func numberTap(_ sender: UITapGestureRecognizer) {
        if item?.isSelected ?? false {
            if let text = numLabel.text, let num = Int(text) {
                XWAKPhoto.shared.remove(item!, index: num)
                selectionView.isHidden = true
            }
        }
        else {
            XWAKPhoto.shared.add(item!)
            selectionView.isHidden = false
        }
        
        let indexText = (item?.isSelected ?? false) ? "\(XWAKPhoto.shared.count)" : ""
        numLabel.setupState((item?.isSelected ?? false), text: indexText)

    }
}
