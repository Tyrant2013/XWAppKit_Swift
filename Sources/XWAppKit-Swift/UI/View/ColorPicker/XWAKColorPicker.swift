//
//  XWAKColorPicker.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public protocol XWAKColorPickerDelegate {
    func colorPicker(_ picker: XWAKColorPicker, didSelectedColor red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    func colorPicker(_ picker: XWAKColorPicker, didSelectedColor hue: CGFloat, saturation: CGFloat, brightness: CGFloat)
}

public class XWAKColorPicker: UIView {

    public var pickerDelegate: XWAKColorPickerDelegate?
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
    public var hsbValue: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        set {
            hsbView.value = newValue
        }
        get {
            return hsbView.value
        }
    }
    public var rgbValue: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        set {
            rgbView.value = newValue
        }
        get {
            return rgbView.value
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        clipsToBounds = true
        backgroundColor = .white
        addSubview(seg)
        addSubview(hsbView)
        addSubview(rgbView)
        
        seg.xwak.edge(equalTo: xwak, inset: 20, edges: [.left, .top, .right])
            .height(20)
        seg.selectedSegmentIndex = 0
        
        hsbView.xwak.top(equalTo: seg.xwak.bottom, 20)
            .edge(equalTo: xwak, inset: 0, edges: [.left, .right, .bottom])
        rgbView.xwak.top(equalTo: seg.xwak.bottom, 20)
            .edge(equalTo: xwak, inset: 0, edges: [.left, .right, .bottom])
        
        hsbView.isHidden = true
        seg.addTarget(self, action: #selector(segValueChange(_:)), for: .valueChanged)
        hsbView.addTarget(self, action: #selector(hsbValueChange(_:)), for: .valueChanged)
        rgbView.addTarget(self, action: #selector(rgbValueChange(_:)), for: .valueChanged)
    }
    
    @objc
    private func segValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rgbView.isHidden = false
            rgbView.transform = CGAffineTransform(translationX: self.rgbView.bounds.width, y: 0)
            let val = hsbView.value
            let color = UIColor(hue: val.hue, saturation: val.saturation, brightness: val.brightness, alpha: 1.0)
            var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            print("HSB2RGB => red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)")
            rgbView.value = (red, green, blue, alpha)
            UIView.animate(withDuration: 0.25) {
                self.rgbView.transform = .identity
                self.hsbView.transform = CGAffineTransform(translationX: -self.hsbView.bounds.width, y: 0)
            } completion: { (finshed) in
                self.hsbView.transform = .identity
                self.hsbView.isHidden = true
            }
        case 1:
            hsbView.isHidden = false
            hsbView.transform = CGAffineTransform(translationX: -hsbView.bounds.width, y: 0)
            let val = rgbView.value
            let color = UIColor(displayP3Red: val.red, green: val.green, blue: val.blue, alpha: val.alpha)
            var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            print("RGB2HSB => hue: \(hue), saturation: \(saturation), brightness: \(brightness), alpha: \(alpha)")
            hsbView.value = (hue, saturation, brightness, alpha)
            UIView.animate(withDuration: 0.25) {
                self.hsbView.transform = .identity
                self.rgbView.transform = CGAffineTransform(translationX: self.rgbView.bounds.width, y: 0)
            } completion: { (finished) in
                self.rgbView.transform = .identity
                self.rgbView.isHidden = true
            }
        default:
            break
        }
    }
    
    @objc
    private func hsbValueChange(_ sender: XWAKHSBView) {
        let val = sender.value
        self.pickerDelegate?.colorPicker(self, didSelectedColor: val.hue, saturation: val.saturation, brightness: val.brightness)
    }
    
    @objc
    private func rgbValueChange(_ sender: XWAKRGBView) {
        let val = sender.value
        self.pickerDelegate?.colorPicker(self, didSelectedColor: val.red, green: val.green, blue: val.blue, alpha: val.alpha)
    }
}
