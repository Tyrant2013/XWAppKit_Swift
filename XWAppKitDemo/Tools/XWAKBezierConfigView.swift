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
    public var rate: CGFloat = 1.0
}

public protocol XWAKBezierConfigViewDelegate {
    func configView(_ configView: XWAKBezierConfigView, didUpdate data: XWAKBezierConfig) -> Void
    func configView(_ configView: XWAKBezierConfigView, didAdd data: XWAKBezierConfig) -> Void
    func configView(_ configView: XWAKBezierConfigView, updateTarget size: CGSize) -> Void
}

public class XWAKBezierConfigView: UIView {

    public var index: Int = 0
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
    private lazy var rateLabel = makeLabel("比率:")
    
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
    
    private lazy var rate = makeTextField()
    private lazy var sxRate = makeTextField()
    private lazy var syRate = makeTextField()
    private lazy var exRate = makeTextField()
    private lazy var eyRate = makeTextField()
    private lazy var c1xRate = makeTextField()
    private lazy var c1yRate = makeTextField()
    private lazy var c2xRate = makeTextField()
    private lazy var c2yRate = makeTextField()
    
    private let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    private lazy var add: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("+", for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(addTouched(_:)), for: .touchUpInside)
        return view
    }()
    private let listView: XWAKBezierConfigList = {
        let view = XWAKBezierConfigList()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.orange.cgColor
//        view.layer.cornerRadius = 15
        return view
    }()
    
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
        
        [startLabel, endLabel, control1Label, control2Label, rateLabel].forEach { addSubview($0) }
        
        [sx, sy ,ex, ey, c1x, c1y, c2x, c2y].forEach { addSubview($0) }
        
        [sxRate, syRate ,exRate, eyRate, c1xRate, c1yRate, c2xRate, c2yRate].forEach { addSubview($0) }
        
        addSubview(add)
        addSubview(listView)
        addSubview(line)
        addSubview(rate)
        listView.delegate = self
    }
    
    private func setupLayouts() {
        let tfSize: (CGFloat, CGFloat) = (60, 30)
        let labelSize: (CGFloat, CGFloat) = (90, 30)
        [cw, ch, startLabel, endLabel, control1Label, control2Label, rateLabel].forEach { $0.xwak.size(labelSize) }
        [sx, sy, ex, ey, c1x, c1y, c2x, c2y, rate, sxRate, syRate, exRate, eyRate, c1xRate, c1yRate, c2xRate, c2yRate].forEach{ $0.xwak.size(tfSize) }
        cw.xwak.left(equalTo: xwak.left, 20)
            .top(equalTo: xwak.top, 10)
        ch.xwak.centerY(equalTo: cw.xwak.centerY)
            .left(equalTo: cw.xwak.right, 20)
        startLabel.xwak.left(equalTo: xwak.left, 10)
            .top(equalTo: cw.xwak.bottom, 50)
        sx.xwak.left(equalTo: startLabel.xwak.right, 10)
            .centerY(equalTo: startLabel.xwak.centerY)
        sy.xwak.left(equalTo: sx.xwak.right, 10)
            .centerY(equalTo: sx.xwak.centerY)
        
        endLabel.xwak.top(equalTo: startLabel.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)
        ex.xwak.left(equalTo: endLabel.xwak.right, 10)
            .centerY(equalTo: endLabel.xwak.centerY)
        ey.xwak.left(equalTo: ex.xwak.right, 10)
            .centerY(equalTo: ex.xwak.centerY)
        
        control1Label.xwak.top(equalTo: endLabel.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)

        c1x.xwak.left(equalTo: control1Label.xwak.right, 10)
            .centerY(equalTo: control1Label.xwak.centerY)
        c1y.xwak.left(equalTo: c1x.xwak.right, 10)
            .centerY(equalTo: c1x.xwak.centerY)
        
        control2Label.xwak.top(equalTo: control1Label.xwak.bottom, 10)
            .left(equalTo: startLabel.xwak.left)

        c2x.xwak.left(equalTo: control2Label.xwak.right, 10)
            .centerY(equalTo: control2Label.xwak.centerY)
        c2y.xwak.left(equalTo: c2x.xwak.right, 10)
            .centerY(equalTo: c2x.xwak.centerY)
        
        add.xwak.centerY(equalTo: listView.xwak.centerY)
            .size((30, 30))
            .right(equalTo: xwak.right, -20)
        listView.xwak.left(equalTo: xwak.left, 10)
            .right(equalTo: add.xwak.left, -10)
            .top(equalTo: cw.xwak.bottom, 10)
            .height(30)
        
        line.xwak.left(equalTo: sy.xwak.right, 10)
            .top(equalTo: sy.xwak.top)
            .width(1)
            .bottom(equalTo: c2y.xwak.bottom)
        
        sxRate.xwak.left(equalTo: line.xwak.right, 10)
            .top(equalTo: line.xwak.top)
        syRate.xwak.left(equalTo: sxRate.xwak.right, 10)
            .top(equalTo: sxRate.xwak.top)
        exRate.xwak.left(equalTo: line.xwak.right, 10)
            .top(equalTo: sxRate.xwak.bottom, 10)
        eyRate.xwak.left(equalTo: exRate.xwak.right, 10)
            .top(equalTo: exRate.xwak.top)
        c1xRate.xwak.left(equalTo: line.xwak.right, 10)
            .top(equalTo: exRate.xwak.bottom, 10)
        c1yRate.xwak.left(equalTo: c1xRate.xwak.right, 10)
            .top(equalTo: c1xRate.xwak.top)
        c2xRate.xwak.left(equalTo: line.xwak.right, 10)
            .top(equalTo: c1xRate.xwak.bottom, 10)
        c2yRate.xwak.left(equalTo: c2xRate.xwak.right, 10)
            .top(equalTo: c2xRate.xwak.top)
        
        rateLabel.xwak.left(equalTo: ch.xwak.right, 10)
            .centerY(equalTo: ch.xwak.centerY)

        rate.xwak.centerY(equalTo: rateLabel.xwak.centerY)
            .left(equalTo: rateLabel.xwak.right, 10)
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
        
        listView.addOne()
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
        rate.text = "\(config.rate)"
        
        sxRate.text = "\(config.startPoint.x / config.rate)"
        syRate.text = "\(config.startPoint.y / config.rate)"
        exRate.text = "\(config.endPoint.x / config.rate)"
        eyRate.text = "\(config.endPoint.y / config.rate)"
        c1xRate.text = "\(config.control1.x / config.rate)"
        c1yRate.text = "\(config.control1.y / config.rate)"
        c2xRate.text = "\(config.control2.x / config.rate)"
        c2yRate.text = "\(config.control2.y / config.rate)"
    }
    
    @objc
    func addTouched(_ sender: UIButton) {
        index += 1
        let newConfig = configs[index - 1]
        configs.append(newConfig)
        listView.addOne()
        delegate?.configView(self, didAdd: newConfig)
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
               let c2xStr = c2x.text as NSString?, let c2yStr = c2y.text as NSString?,
               let rStr = rate.text as NSString? {
                let sp = CGPoint(x: CGFloat(sxStr.floatValue), y: CGFloat(syStr.floatValue))
                let ep = CGPoint(x: CGFloat(exStr.floatValue), y: CGFloat(eyStr.floatValue))
                let c1 = CGPoint(x: CGFloat(c1xStr.floatValue), y: CGFloat(c1yStr.floatValue))
                let c2 = CGPoint(x: CGFloat(c2xStr.floatValue), y: CGFloat(c2yStr.floatValue))
                let r = CGFloat(rStr.floatValue)
                configs[index] = XWAKBezierConfig(startPoint: sp,
                                                  endPoint: ep,
                                                  control1: c1,
                                                  control2: c2,
                                                  rate: r)
                delegate?.configView(self, didUpdate: configs[index])
            }
        }
    }
}

extension XWAKBezierConfigView: XWAKBezierConfigListDelegate {
    func listView(_ listView: XWAKBezierConfigList, didSelected index: Int) {
        self.index = index
        let config = configs[index]
        updateUI(config: config)
        delegate?.configView(self, didUpdate: config)
    }
}
