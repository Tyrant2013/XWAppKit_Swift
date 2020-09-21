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
        let tv = XWAKTextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        tv.backgroundColor = .orange
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemRed.cgColor
        view.addSubview(tv)
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
