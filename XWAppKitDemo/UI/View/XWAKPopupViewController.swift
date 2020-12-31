//
//  XWAKPopupViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/12/31.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        let vv = XWAKPopupView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vv)
        vv.xwak.center(equalTo: view.safeAreaLayoutGuide.xwak)
            .size((300, 350))
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
