//
//  XWAKColorPickerDoughnutViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2021/4/9.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKColorPickerDoughnutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let vv = XWAKDoughnutView(frame: .init(x: 80, y: 100, width: 150, height: 150))
        vv.backgroundColor = .clear
        view.addSubview(vv)
        
        let eves: UIControl.Event = UIControl.Event([.touchDown, .touchDragInside, .touchDragOutside])
        vv.addTarget(self, action: #selector(takeHue(_:)), for: eves)
        
        let v = XWAKColorSquareView(frame: .init(x: 80, y: 300, width: 150, height: 150))
        view.addSubview(v)
        
    }
    
    @objc
    func takeHue(_ sender: XWAKDoughnutView) {
        
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
