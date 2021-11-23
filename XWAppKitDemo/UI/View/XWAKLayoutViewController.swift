//
//  XWAKLayoutViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2021/11/23.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKLayoutViewController: UIViewController {

    private let rectangle: UIView = {
        let vv = UIView()
        vv.translatesAutoresizingMaskIntoConstraints = false
        vv.backgroundColor = .red
        vv.addCorner(radius: 10)
        return vv
    }()
    private let move: UIButton = {
        let vv = UIButton(type: .system)
        vv.translatesAutoresizingMaskIntoConstraints = false
        vv.setTitle("改变左边位置", for: .normal)
        vv.addBorder(width: 1, color: .blue)
        vv.addCorner(radius: 10)
        return vv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(rectangle)
        view.addSubview(move)
        
        rectangle.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 50, edges: [.left, .right])
            .height(200)
            .centerY(equalTo: view.xwak.centerY)
        
        /// 重复设置的话，只有第一次的会有效
        rectangle.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 50, edges: [.left, .right])
            .height(300)
            .centerY(equalTo: view.xwak.centerY)
        
        move.xwak.top(equalTo: rectangle.xwak.bottom)
            .edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 30, edges: [.left, .right])
            .height(50)
        
        move.addTarget(self, action: #selector(moveLeft(_:)), for: .touchUpInside)
    }
    
    @objc func moveLeft(_ sender: UIButton) {
        rectangle.xwak.left.constant -= 10
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
