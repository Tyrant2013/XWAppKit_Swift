//
//  XWAKSVGViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2021/3/26.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKSVGViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let svg = XWAKSVGView(named: "Data")
        svg.translatesAutoresizingMaskIntoConstraints = false
//        svg.backgroundColor = .red
        view.addSubview(svg)
        svg.xwak.center(equalTo: view.safeAreaLayoutGuide.xwak)
            .size((750, 500))
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
