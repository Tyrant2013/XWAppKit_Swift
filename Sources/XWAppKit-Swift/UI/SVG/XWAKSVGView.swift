//
//  XWAKSVGView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKSVGView: UIView {
    private var loader: XWAKSVGLoader?
    public var named: String? {
        didSet {
            if let name = named, name.count > 0 {
                loadSVG(name: name)
            }
            else {
                loader = nil
            }
        }
    }
    
    private func loadSVG(name: String) {
        loader = XWAKSVGLoader(fileName: name)
        loader?.delegate = self
        loader?.parse()
    }
    
    public init(named: String) {
        super.init(frame: .zero)
        self.named = named
//        clipsToBounds = true
        if named.count > 0 { loadSVG(name: named) }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.named = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if loader != nil {
            let w = bounds.width / loader!.root.viewBox.width
            let h = bounds.height / loader!.root.viewBox.height
            drawNode(loader!.root, deep: 0, widthScale: w, heightScale: h)
        }
    }

}

extension XWAKSVGView: XWAKSVGLoaderDelegate {
    func loaderDidStart(_ loader: XWAKSVGLoader) {
        print("start")
    }
    
    func loaderDidEnd(_ loader: XWAKSVGLoader) {

    }
    
    func drawNode(_ ele: XWAKSVGElement, deep: Int, widthScale: CGFloat = 1.0, heightScale: CGFloat = 1.0) {
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.path = ele.path.cgPath
        layer.lineWidth = 1
        layer.strokeColor = ele.strokeColor.cgColor
        layer.fillColor = ele.fillColor.cgColor
        
        self.layer.addSublayer(layer)
        layer.transform = CATransform3DScale(layer.transform, widthScale, heightScale, 1.0)
        
        for subEle in ele.children {
            drawNode(subEle, deep: deep + 1)
        }
    }
}
