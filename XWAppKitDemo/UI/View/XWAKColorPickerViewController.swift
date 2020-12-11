//
//  XWAKColorPickerViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/12/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKColorPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        let view = XWAKColorPicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.xwak.center(equalTo: self.view.xwak)
            .size((250, 250))
        // Do any additional setup after loading the view.
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
