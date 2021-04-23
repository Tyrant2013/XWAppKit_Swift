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
//        let tt = XWAKPopupTriangleView()
//        tt.frame = CGRect(x: 10, y: 100, width: 22, height: 14)
//        view.addSubview(tt)
//
//        let tt1 = XWAKPopupTriangleView()
//        tt1.frame = CGRect(x: 50, y: 100, width: 22, height: 14)
//        view.addSubview(tt1)
//        tt1.transform = CGAffineTransform.identity.rotated(by: .pi / 2)
//
//        let tt2 = XWAKPopupTriangleView()
//        tt2.frame = CGRect(x: 90, y: 100, width: 22, height: 14)
//        view.addSubview(tt2)
//        tt2.transform = CGAffineTransform.identity.rotated(by: .pi)
//
//        let tt3 = XWAKPopupTriangleView()
//        tt3.frame = CGRect(x: 130, y: 100, width: 22, height: 14)
//        view.addSubview(tt3)
//        tt3.transform = CGAffineTransform.identity.rotated(by: -.pi / 2)
        
        let cc = UIView()
        cc.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cc)
        cc.backgroundColor = .yellow
        cc.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 0, edges: [.all])
        
        let vv = XWAKPopupView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        cc.addSubview(vv)
        vv.fillColor = .red
        vv.arrowPosition = .left
        vv.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.left, .top])
            .size((340, 340))
        
//        let vv1 = XWAKPopupView()
//        vv1.translatesAutoresizingMaskIntoConstraints = false
//        cc.addSubview(vv1)
//        vv1.fillColor = .red
//        vv1.arrowPosition = .right
//        vv1.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.right, .top])
//            .size((170, 170))
//
//        let vv2 = XWAKPopupView()
//        vv2.translatesAutoresizingMaskIntoConstraints = false
//        cc.addSubview(vv2)
//        vv2.fillColor = .red
//        vv2.arrowPosition = .top
//        vv2.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.left, .bottom])
//            .size((170, 170))
//
//        let vv3 = XWAKPopupView()
//        vv3.translatesAutoresizingMaskIntoConstraints = false
//        cc.addSubview(vv3)
//        vv3.fillColor = .red
//        vv3.arrowPosition = .bottom
//        vv3.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.right, .bottom])
//            .size((170, 170))
        
        let targetView = UIView(frame: CGRect(x: 20, y: 20, width: 88, height: 150))
        cc.addSubview(targetView)
        targetView.backgroundColor = .black
        
        vv.targetView = targetView
        vv.sourceView = cc
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
