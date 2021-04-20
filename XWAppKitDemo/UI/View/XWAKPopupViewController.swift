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
        let tt = XWAKPopupTriangleView()
        tt.frame = CGRect(x: 10, y: 100, width: 60, height: 60)
        view.addSubview(tt)
        
        let vv = XWAKPopupView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vv)
        vv.triangleTopPoint = .init(x: 340, y: 0)
        vv.fillColor = .red
        vv.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.left, .right, .bottom])
            .height(400)
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
