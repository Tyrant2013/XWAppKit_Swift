//
//  XWAKImageCropBorder.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

protocol XWAKImageCropBorderDelegate {
    func border(_ borderLine: XWAKImageCropBorder, didSelected direction: XWAKImageCropBorder.Direction)
}

class XWAKImageCropBorder: UIView {

    enum Direction {
        case none
        case left
        case right
        case top
        case bottom
        case all
    }
    
    var delegate: XWAKImageCropBorderDelegate?
    let direction: Direction
    var selected = false
    
    private var line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return view
    }()
    static private let buttonBounds = CGRect(x: 0, y: 0, width: 40, height: 20)
    private var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("=", for: .normal)
        btn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        let layer = CAShapeLayer()
        let corners = UIRectCorner(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue)
        let path = UIBezierPath(roundedRect: XWAKImageCropBorder.buttonBounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: 10, height: 10))
        layer.path = path.cgPath
        btn.layer.mask = layer
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private override init(frame: CGRect) {
        self.direction = .none
        super.init(frame: frame)
        setup()
    }
    
    init(border: Direction) {
        self.direction = border
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.direction = .left
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addSubview(line)
        
        button.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside)
        addSubview(button)
        
        line.xwak.edge(equalTo: xwak, inset: 0, edges: [.top, .left, .right])
            .height(1)
        button.xwak.centerX(equalTo: xwak.centerX)
            .top(equalTo: xwak.top)
            .size((40, 20))
        switch direction {
        case .none, .all, .top:
            break
        case .left:
            transform = CGAffineTransform(rotationAngle: -.pi / 2.0)
        case .right:
            transform = CGAffineTransform(rotationAngle: .pi / 2.0)
        case .bottom:
            transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    @objc
    func buttonTouched(_ sender: UIButton) {
        delegate?.border(self, didSelected: direction)
        selected = !selected
        UIView.performWithoutAnimation {
            sender.setTitle(selected ? "√" : "=", for: .normal)
            sender.layoutIfNeeded()
        }
    }
    
    func needHideSomeView(_ needHide: Bool) {
        button.isHidden = needHide
    }

}
