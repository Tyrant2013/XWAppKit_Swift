//
//  XWAKImageBrower.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKImageBrower: UIView {

    public var image: UIImage? {
        didSet {
            imageView.image = image
            if let image = image {
                imageView.frame = image.size.fixFrameTo(bounds)
            }
        }
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imageView: UIImageView = {
        let view = UIImageView()
        
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
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.xwak.edge(equalTo: xwak, inset: 0, edges: [.all])
            .width(equalTo: xwak.width)
            .height(equalTo: xwak.height)
    }
    
    private var isInit = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isInit {
            if let image = image {
                let frame = image.size.fixFrameTo(bounds)
                imageView.frame = frame
            }
        }
    }

}
