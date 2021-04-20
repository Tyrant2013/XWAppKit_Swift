//
//  XWAKBezierConfigView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/20.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public struct XWAKBezierConfig {
    public var startPoint: CGPoint = .zero
    public var endPoint: CGPoint = .zero
    public var control1: CGPoint = .zero
    public var control2: CGPoint = .zero
}

public protocol XWAKBezierConfigViewDelegate {
    func configView(_ configView: XWAKBezierConfigView, didUpdate data: XWAKBezierConfig) -> Void
    func configView(_ configView: XWAKBezierConfigView, updateTarget size: CGSize) -> Void
}

public class XWAKBezierConfigView: UIView {

    private(set) var index: Int = 0
    public var configs = [XWAKBezierConfig]() {
        didSet {
            let config = configs[index]
            updateUI(config: config)
        }
    }
    public var targetSize: CGSize = .init(width: 360, height: 360)
    public var delegate: XWAKBezierConfigViewDelegate?
    
    private func makeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    private func makeTextField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.backgroundColor = .white
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.orange.cgColor
        tf.delegate = self
        return tf
    }
    private func makeControlView() -> UIView {
        let view = UIView()
        view.bounds = .init(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = UIColor.xwak_color(with: "0x66ccd5").withAlphaComponent(0.5)
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }
    
    private lazy var startLabel = makeLabel("开始点:")
    private lazy var endLabel = makeLabel("结束点:")
    private lazy var control1Label = makeLabel("c1:")
    private lazy var control2Label = makeLabel("c2:")
    
    private lazy var cw = makeTextField()
    private lazy var ch = makeTextField()
    private lazy var sx = makeTextField()
    private lazy var sy = makeTextField()
    private lazy var ex = makeTextField()
    private lazy var ey = makeTextField()
    private lazy var c1x = makeTextField()
    private lazy var c1y = makeTextField()
    private lazy var c2x = makeTextField()
    private lazy var c2y = makeTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
        setupData()
    }
    
    private func setupViews() {
        [cw, ch].forEach { addSubview($0) }
        
        [startLabel, endLabel, control1Label, control2Label].forEach { addSubview($0) }
        
        [sx, sy ,ex, ey, c1x, c1y, c2x, c2y].forEach { addSubview($0) }
    }
    
    private func setupLayouts() {
        cw.xwak.centerX(equalTo: xwak.centerX, multiplier: 0.5)
            .top(equalTo: xwak.top, 10)
            .size((80, 30))
        ch.xwak.centerY(equalTo: cw.xwak.centerY)
            .centerX(equalTo: xwak.centerX, multiplier: 1.5)
            .size((80, 30))
        startLabel.xwak.left(equalTo: xwak.left, 10)
            .top(equalTo: cw.xwak.bottom, 50)
            .size((80, 30))
        sx.xwak.left(equalTo: startLabel.xwak.right, 10)
            .centerY(equalTo: startLabel.xwak.centerY)
            .size((60, 30))
        sy.xwak.left(equalTo: sx.xwak.right, 10)
            .centerY(equalTo: sx.xwak.centerY)
            .size((60, 30))
        
        endLabel.xwak.top(equalTo: startLabel.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)
            .size(equalTo: startLabel.xwak)
        ex.xwak.left(equalTo: endLabel.xwak.right, 10)
            .centerY(equalTo: endLabel.xwak.centerY)
            .size((60, 30))
        ey.xwak.left(equalTo: ex.xwak.right, 10)
            .centerY(equalTo: ex.xwak.centerY)
            .size((60, 30))
        
        control1Label.xwak.top(equalTo: endLabel.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)
            .size(equalTo: startLabel.xwak)
        c1x.xwak.left(equalTo: control1Label.xwak.right, 10)
            .centerY(equalTo: control1Label.xwak.centerY)
            .size((60, 30))
        c1y.xwak.left(equalTo: c1x.xwak.right, 10)
            .centerY(equalTo: c1x.xwak.centerY)
            .size((60, 30))
        
        control2Label.xwak.top(equalTo: control1Label.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)
            .size(equalTo: startLabel.xwak)
        c2x.xwak.left(equalTo: control2Label.xwak.right, 10)
            .centerY(equalTo: control2Label.xwak.centerY)
            .size((60, 30))
        c2y.xwak.left(equalTo: c2x.xwak.right, 10)
            .centerY(equalTo: c2x.xwak.centerY)
            .size((60, 30))
    }
    
    private func setupData() {
        let config = XWAKBezierConfig(startPoint: .init(x: 0, y: 360),
                                      endPoint: .init(x: 180, y: 0),
                                      control1: .init(x: 82, y: 347),
                                      control2: .init(x: 91, y: 15))
        configs.append(config)
        
        cw.text = "\(targetSize.width)"
        ch.text = "\(targetSize.height)"
        
        updateUI(config: config)
    }
    
    private func updateUI(config: XWAKBezierConfig) {
        sx.text = "\(config.startPoint.x)"
        sy.text = "\(config.startPoint.y)"
        ex.text = "\(config.endPoint.x)"
        ey.text = "\(config.endPoint.y)"
        c1x.text = "\(config.control1.x)"
        c1y.text = "\(config.control1.y)"
        c2x.text = "\(config.control2.x)"
        c2y.text = "\(config.control2.y)"
    }
    
}

extension XWAKBezierConfigView: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == cw || textField == ch {
            if let wStr = cw.text, let hStr = ch.text {
                let width = CGFloat((wStr as NSString).floatValue)
                let height = CGFloat((hStr as NSString).floatValue)
                targetSize = .init(width: width, height: height)
                delegate?.configView(self, updateTarget: targetSize)
            }
        }
        else {
            if let sxStr = sx.text as NSString?, let syStr = sy.text as NSString?,
               let exStr = ex.text as NSString?, let eyStr = ey.text as NSString?,
               let c1xStr = c1x.text as NSString?, let c1yStr = c1y.text as NSString?,
               let c2xStr = c2x.text as NSString?, let c2yStr = c2y.text as NSString? {
                let sp = CGPoint(x: CGFloat(sxStr.floatValue), y: CGFloat(syStr.floatValue))
                let ep = CGPoint(x: CGFloat(exStr.floatValue), y: CGFloat(eyStr.floatValue))
                let c1 = CGPoint(x: CGFloat(c1xStr.floatValue), y: CGFloat(c1yStr.floatValue))
                let c2 = CGPoint(x: CGFloat(c2xStr.floatValue), y: CGFloat(c2yStr.floatValue))
                configs[index] = XWAKBezierConfig(startPoint: sp, endPoint: ep, control1: c1, control2: c2)
                delegate?.configView(self, didUpdate: configs[index])
            }
        }
    }
}
