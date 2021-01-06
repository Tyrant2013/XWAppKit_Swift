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
    public var hexRGBValue: String {
        set {
            rgbView.hexValue = newValue
        }
        get {
            return rgbView.hexValue
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
            let (red, green, blue, alpha) = color.rgbValue()
//            print("HSB2RGB => red: \(red), green: \(green), blue: \(blue), alpha: \(alpha)")
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
            let (hue, saturation, brightness) = RGBToHSB(hex: rgbView.hexValue)
            let alpha: CGFloat = 1.0
//            print("RGB2HSB => hue: \(hue), saturation: \(saturation), brightness: \(brightness), alpha: \(alpha)")
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
    
    private func RGBToHSB(hex: String) -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        let val = hex.hexToValue()
        let r = val.red
        let g = val.green
        let b = val.blue
        let maxValue = max(max(r, g), b)
        let minValue = min(min(r, g), b)
        
        let br = maxValue / 255.0
        let s = maxValue == 0 ? 0 : (maxValue - minValue) / maxValue
        var h: CGFloat = 0
        if maxValue == minValue {
            h = 0
        }
        else if maxValue == r && g >= b {
            h = (g - b) * 60 / (maxValue - minValue)
        }
        else if maxValue == r && g < b {
            h = (g - b) * 60 / (maxValue - minValue) + 360
        }
        else if maxValue == g {
            h = (b - r) * 60 / (maxValue - minValue) + 120
        }
        else if maxValue == b {
            h = (r - g) * 60 / (maxValue - minValue) + 240
        }
        return (h / 360.0, s, br)
    }
}
