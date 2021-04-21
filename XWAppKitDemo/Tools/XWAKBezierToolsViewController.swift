//
//  XWAKBezierToolsViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2021/4/20.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKBezierToolsViewController: UIViewController {

    let showView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.orange.cgColor
        view.frame = CGRect(x: 20, y: 100, width: 360, height: 360)
        view.backgroundColor = .white
        return view
    }()
    let lineLayer = CAShapeLayer()
    lazy var control1: UIView = makeControlView()
    lazy var control2: UIView = makeControlView()
    lazy var controlS = makeControlView()
    lazy var controlE = makeControlView()
    var layers = [CAShapeLayer]()

    private func makeControlView() -> UIView {
        let view = UIView()
        view.bounds = .init(x: 0, y: 0, width: 20, height: 20)
        view.backgroundColor = UIColor.xwak_color(with: "0x66ccd5").withAlphaComponent(0.5)
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }
    
    private let configView: XWAKBezierConfigView = {
        let view = XWAKBezierConfigView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
        view.addSubview(showView)
//        showView.layer.addSublayer(lineLayer)
        
        showView.addSubview(control1)
        showView.addSubview(control2)
        showView.addSubview(controlS)
        showView.addSubview(controlE)
        var center = showView.center
        center.x = view.center.x
        
        view.addSubview(configView)
        configView.delegate = self
        configView.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.left, .right, .bottom])
            .height(250)
        showView.bounds = CGRect(origin: .zero, size: configView.targetSize)
        showView.center = center
        
        control1.center = configView.configs[0].control1
        control2.center = configView.configs[0].control2
        controlS.center = configView.configs[0].startPoint
        controlE.center = configView.configs[0].endPoint

        let pan1 = UIPanGestureRecognizer(target: self, action: #selector(controlPan(_:)))
        control1.addGestureRecognizer(pan1)

        let pan2 = UIPanGestureRecognizer(target: self, action: #selector(controlPan(_:)))
        control2.addGestureRecognizer(pan2)
        
        let pan3 = UIPanGestureRecognizer(target: self, action: #selector(controlPan(_:)))
        controlS.addGestureRecognizer(pan3)
        
        let pan4 = UIPanGestureRecognizer(target: self, action: #selector(controlPan(_:)))
        controlE.addGestureRecognizer(pan4)

        let layer = makeLayer()
        showView.layer.addSublayer(layer)
        layers.append(layer)
        
        updatePath(update: false)
    }
    
    func makeLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.orange.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 2
        return layer
    }
    
    var moveView: UIView?
    @objc
    func controlPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            moveView = sender.view
        case .changed:
            moveView?.center = sender.location(in: showView)
            updatePath(index: configView.index, update: true)
        case .ended:
            moveView = nil
        default:
            moveView = nil
        }
    }
    
    func updatePath(index: Int = 0, update: Bool) {
        
        if update {
            configView.configs[index].control1 = control1.center
            configView.configs[index].control2 = control2.center
            configView.configs[index].startPoint = controlS.center
            configView.configs[index].endPoint = controlE.center
        }
        control1.center = configView.configs[index].control1
        control2.center = configView.configs[index].control2
        controlS.center = configView.configs[index].startPoint
        controlE.center = configView.configs[index].endPoint
        
        let updateLayer = layers[index]
        
        let config = configView.configs[index]
        let contr1 = config.control1
        let contr2 = config.control2
        
        let path = UIBezierPath()

        path.move(to: config.startPoint)
        path.addCurve(to: config.endPoint,
                      controlPoint1: contr1,
                      controlPoint2: contr2)
        updateLayer.path = path.cgPath
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

extension XWAKBezierToolsViewController: XWAKBezierConfigViewDelegate {
    func configView(_ configView: XWAKBezierConfigView, didUpdate data: XWAKBezierConfig) {
        updatePath(index: configView.index, update: false)
    }
    
    func configView(_ configView: XWAKBezierConfigView, didAdd data: XWAKBezierConfig) {
        let layer = makeLayer()
        layers.append(layer)
        showView.layer.addSublayer(layer)
        updatePath(index: configView.index, update: false)
    }
    
    func configView(_ configView: XWAKBezierConfigView, updateTarget size: CGSize) {
        let frame = CGRect(origin: .init(x: (view.bounds.width - size.width) / 2, y: 100), size: size)
        UIView.animate(withDuration: 0.25) {
            self.showView.frame = frame
        }
    }
}
