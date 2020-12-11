//
//  XWAKColorPicker.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKColorPicker: UIView {

    private let seg: UISegmentedControl = {
        let view = UISegmentedControl(items: ["RGB", "HSB"])
        view.accessibilityLabel = "segment_control"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let hsbView: XWAKHSBView = {
        let view = XWAKHSBView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let rgbView: XWAKRGBView = {
        let view = XWAKRGBView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    private let wheelContainer: UIView = {
//        let view = UIView()
//        view.accessibilityLabel = "wheel_Container"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private let wheelView: XWAKColorWheelView = {
//        let view = XWAKColorWheelView()
//        view.accessibilityLabel = "wheel_view"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private let brightnessView: XWAKColorComponent = {
//        let view = XWAKColorComponent()
//        view.accessibilityLabel = "brightness_view"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isUserInteractionEnabled = true
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        backgroundColor = .white
        addSubview(seg)
        addSubview(hsbView)
        
        seg.xwak.edge(equalTo: xwak, inset: 20, edges: [.left, .top, .right])
            .height(20)
        seg.selectedSegmentIndex = 0
        
        hsbView.xwak.top(equalTo: seg.xwak.bottom, 20)
            .edge(equalTo: xwak, inset: 0, edges: [.left, .right, .bottom])
        rgbView.xwak.top(equalTo: seg.xwak.bottom, 20)
            .edge(equalTo: xwak, inset: 0, edges: [.left, .right, .bottom])
        
        hsbView.isHidden = true
    }
}
