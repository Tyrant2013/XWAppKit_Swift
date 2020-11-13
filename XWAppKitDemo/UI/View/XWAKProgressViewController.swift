//
//  XWAKProgressViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/11/13.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKProgressViewController: UIViewController {

    private let progress = XWAKProgressView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        progress.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        progress.progress = 1
        progress.backgroundColor = .white
        view.addSubview(progress)
        
        progress.progress = 0.0
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(valueChange(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 20, edges: [.left, .right])
            .centerY(equalTo: view.safeAreaLayoutGuide.xwak.centerY)
    }
    
    @objc
    func valueChange(_ sender: UISlider) {
        let pencent = CGFloat(sender.value / 100)
        progress.progress = pencent
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
