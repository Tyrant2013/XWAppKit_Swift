//
//  XWAKSlider.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKSlider: UIControl {
    public var min: Int = 0
    public var max: Int = 255
    public let backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        layer.startPoint = .init(x: 0.0, y: 0.5)
        layer.endPoint = .init(x: 1.0, y: 0.5)
        return layer
    }()
    public let cursorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = .init(width: 0, height: 3)
        view.layer.shadowOpacity = 0.8
        view.isUserInteractionEnabled = false
        return view
    }()
    private var realMoveDis: CGFloat {
        return bounds.width - cursorView.bounds.width
    }
    
    public var value: Int = 0 {
        didSet {
            let x = CGFloat(value) / CGFloat(max) * realMoveDis
            cursorView.transform = CGAffineTransform.identity.translatedBy(x: x, y: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.addSublayer(backgroundLayer)
        addSubview(cursorView)
        
        cursorView.xwak.edge(equalTo: xwak, inset: 0, edges: [.left, .top, .bottom])
            .width(equalTo: cursorView.xwak.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds.insetBy(dx: 0, dy: 5)
        backgroundLayer.cornerRadius = backgroundLayer.bounds.height / 2
        cursorView.layer.cornerRadius = cursorView.bounds.height / 2
        
        let val = value
        value = val
    }
    
    private enum State {
        case normal
        case move(startPoint: CGPoint)
    }
    private var touchState: State = .normal
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch(touches)
    }
    
    private func touch(_ touches: Set<UITouch>) {
        if let location = touches.first?.location(in: self) {
            let offset = cursorView.bounds.width / 2 // cursor view 的中点
            let real = realMoveDis
            let x = (location.x - offset).clamped(to: CGFloat(min)...real)
            value = Int((x / real) * CGFloat(max))
            cursorView.transform = CGAffineTransform.identity.translatedBy(x: x, y: 0)
            sendActions(for: .valueChanged)
        }
    }

}
