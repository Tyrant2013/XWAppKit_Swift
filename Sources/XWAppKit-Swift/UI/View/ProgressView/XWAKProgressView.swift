//
//  XWAKProgressView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/13.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKProgressView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        backgroundColor = .white
        progressLayer.progress = 1.0
    }
    private var progressLayer: XWAKProgressLayer {
        return layer as! XWAKProgressLayer
    }
    
    public override class var layerClass: AnyClass {
        return XWAKProgressLayer.self
    }
    
    public override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if event == #keyPath(XWAKProgressLayer.progress),
            let action = action(for: layer, forKey: #keyPath(backgroundColor)) as? CAAnimation {

            let animation = CABasicAnimation()
            animation.keyPath = #keyPath(XWAKProgressLayer.progress)
            animation.fromValue = progressLayer.progress
            animation.toValue = progress
            animation.beginTime = action.beginTime
            animation.duration = action.duration
            animation.speed = action.speed
            animation.timeOffset = action.timeOffset
            animation.repeatCount = action.repeatCount
            animation.repeatDuration = action.repeatDuration
            animation.autoreverses = action.autoreverses
            animation.fillMode = action.fillMode
            animation.timingFunction = action.timingFunction
            animation.delegate = action.delegate
            self.layer.add(animation, forKey: #keyPath(XWAKProgressLayer.progress))
        }
        return super.action(for: layer, forKey: event)
    }
    
    public dynamic var progress: CGFloat = 0 {
        didSet {
            if progress > 1 { progress = 1 }
            progressLayer.progress = progress
        }
    }
}
