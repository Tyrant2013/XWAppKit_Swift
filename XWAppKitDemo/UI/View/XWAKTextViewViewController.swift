//
//  XWAKTextViewViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/9/21.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKTextViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
//        let markup = "<font color=\"red\" strokeColor=\"orange\" face=\"Zapfino\">Letter from the editor<font color=\"black\" strokeColor=\"gray\" face=\"Palatino\">One of the most famous zombie-themed television appearances was 1983's Thriller"
//        do {
//        let regex = try NSRegularExpression(pattern: "(.*?)(<[^>]+>|\\Z)",
//                                            options: [.caseInsensitive, .dotMatchesLineSeparators])
//        //3
//        let chunks = regex.matches(in: markup,
//                                   options: NSRegularExpression.MatchingOptions(rawValue: 0),
//                                   range: NSRange(location: 0,
//                                                  length: markup.count))
//            for chunk in chunks {
//                guard let range = markup.range(from: chunk.range) else { return }
//                let parts = markup[range]//.components(separatedBy: "<")
//                print(chunk.range, parts)
//            }
//        }
//        catch {
//
//        }
        // Do any additional setup after loading the view.
        let tv = XWAKTextView(frame: CGRect(x: 50, y: 100, width: 300, height: 400))
        tv.backgroundColor = .orange
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemRed.cgColor
        tv.tag = 1111
        view.addSubview(tv)
        
        let btn = UIButton(type: .system)
        btn.setTitle("复制", for: .normal)
        btn.addTarget(self, action: #selector(printSelected(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 150, y: 550, width: 100, height: 50)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.cornerRadius = 10
        view.addSubview(btn)
        
        let drawStr = "这是开始，这是中间，这是结束\n这里换行"
        let attrs = [
            NSAttributedString.Key.foregroundColor : UIColor.red,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)
        ]
        let attr = NSMutableAttributedString(string: drawStr, attributes: attrs)
        if let image = UIImage(named: "abc") {
            attr.append(XWAKImageMetaData.makeImageAttributeString(image: image, size: CGSize(width: 50, height: 50), tapHandler: { (image, frame) in
                self.view.viewWithTag(1111)?.removeFromSuperview()
                
                let iv = UIImageView(image: image)
                iv.frame = tv.convert(frame, to: self.view)
                iv.tag = 1111
                self.view.addSubview(iv)
                
                UIView.animate(withDuration: 1.0) {
                    iv.frame = CGRect(x: (self.view.bounds.width - image.size.width) / 2, y: (self.view.bounds.height - image.size.height) / 2, width: image.size.width, height: image.size.height)
                }
            }))
        }
        attr.append(NSAttributedString(string: "图片后面的文字", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25)
        ]))
        
        let shadowItem = XWAKTextShadow(offset: CGSize(width: 2, height: 3),
                                        color: UIColor.lightGray, blur: 1.0)
        let shadow = NSMutableAttributedString(string: "这里带阴影\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 23)
        ])
        shadow.addAttribute(NSAttributedString.Key.xwak_shadow, value: shadowItem, range: NSRange(location: 0, length: 2))
        attr.append(shadow)
        
        let borderFont = UIFont(name: "PingFangSC-Regular", size: 20)!
        attr.append(NSAttributedString(string: "带Dash边框的文字\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.orange,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_border : XWAKTextBorder(borderStyle: .dash, width: 1, color: .black)
        ]))
        
        attr.append(NSAttributedString(string: "带Dot边框的文字\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.orange,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_border : XWAKTextBorder(borderStyle: .dot, width: 1, color: .black)
        ]))
        attr.append(NSAttributedString(string: "带DashDot边框的文字\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.backgroundColor : UIColor.orange,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_border : XWAKTextBorder(borderStyle: .dashdot, width: 1, color: .black)
        ]))
        attr.append(NSAttributedString(string: "带DashDotDot边框的文字\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_border : XWAKTextBorder(borderStyle: .dashdotdot, width: 3, color: .black)
        ]))
        
        attr.append(NSAttributedString(string: "带CircleDot边框的文字\n", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_border : XWAKTextBorder(borderStyle: .circledot, width: 4, color: .black)
        ]))
        
        let selectedAttr = XWAKTextSelected(backgroundColor: .red, foregroundColor: .white)
        attr.append(NSAttributedString(string: "这里设置了选中时的背景色和前景色", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.white,
            NSAttributedString.Key.font : borderFont,
            NSAttributedString.Key.xwak_selected : selectedAttr
        ]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        paragraphStyle.headIndent = 5
        attr.addAttributes([
            NSAttributedString.Key.paragraphStyle : paragraphStyle,
            NSAttributedString.Key.kern : 5
        ],
                           range: NSRange(location: 0, length: attr.length))
        tv.attributeString = attr
    }
    
    @objc
    func printSelected(_ sender: UIButton) {
        let clipedView = view.viewWithTag(1111) as! XWAKTextView
        print(clipedView.selectedString as Any)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
  func range(from range: NSRange) -> Range<String.Index>? {
    guard let from16 = utf16.index(utf16.startIndex,
                                   offsetBy: range.location,
                                   limitedBy: utf16.endIndex),
      let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
      let from = String.Index(from16, within: self),
      let to = String.Index(to16, within: self) else {
        return nil
    }

    return from ..< to
  }
}
