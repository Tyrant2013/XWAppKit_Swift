//
//  XWAKHudViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/27.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKHudViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let noTitleBtn = makeButton(title: "无标题", action: #selector(showWithNoTitle(_:)))
        
        let hasTitleBtn = makeButton(title: "有标题", action: #selector(showWithTitle(_:)))
        
        let noTitleAndMsg = makeButton(title: "无标题和内容", action: #selector(showWithNoTitleAndMsg(_:)))
        
        let autoDismiss = makeButton(title: "自动隐藏", action: #selector(autoDismiss(_:)))
        
        let dismissBtn = makeButton(title: "隐藏", action: #selector(dismissHud(_:)))
        
        let showTABtn = makeButton(title: "标题和转圈", action: #selector(showTitleAndIndicator(_:)))
        
        let showAMBtn = makeButton(title: "转圈和内容", action: #selector(showIndicatorAndMsg(_:)))
        
        noTitleAndMsg.xwak.centerX(equalTo: view.xwak.centerX)
                .width(150)
                .height(40)
                .centerY(equalTo: view.xwak.centerY, -30)
        
        hasTitleBtn.xwak.centerX(equalTo: noTitleAndMsg.xwak.centerX)
            .width(150)
            .height(40)
            .bottom(equalTo: noTitleAndMsg.xwak.top, -10)
        
        NSLayoutConstraint.activate([
//            noTitleAndMsg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            noTitleAndMsg.widthAnchor.constraint(equalToConstant: 150),
//            noTitleAndMsg.heightAnchor.constraint(equalToConstant: 40),
//            noTitleAndMsg.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
//            hasTitleBtn.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
//            hasTitleBtn.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
//            hasTitleBtn.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
//            hasTitleBtn.bottomAnchor.constraint(equalTo: noTitleAndMsg.topAnchor, constant: -10),
            
            noTitleBtn.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
            noTitleBtn.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
            noTitleBtn.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
            noTitleBtn.bottomAnchor.constraint(equalTo: hasTitleBtn.topAnchor, constant: -10),
            
            autoDismiss.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
            autoDismiss.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
            autoDismiss.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
            autoDismiss.topAnchor.constraint(equalTo: noTitleAndMsg.bottomAnchor, constant: 10),
            
            dismissBtn.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
            dismissBtn.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
            dismissBtn.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
            dismissBtn.topAnchor.constraint(equalTo: autoDismiss.bottomAnchor, constant: 10),
            
            showTABtn.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
            showTABtn.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
            showTABtn.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
            showTABtn.topAnchor.constraint(equalTo: dismissBtn.bottomAnchor, constant: 10),
            
            showAMBtn.centerXAnchor.constraint(equalTo: noTitleAndMsg.centerXAnchor),
            showAMBtn.widthAnchor.constraint(equalTo: noTitleAndMsg.widthAnchor),
            showAMBtn.heightAnchor.constraint(equalTo: noTitleAndMsg.heightAnchor),
            showAMBtn.topAnchor.constraint(equalTo: showTABtn.bottomAnchor, constant: 10),
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        XWAKHud.dismiss()
    }
    
    private func makeButton(title: String, action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        return btn
    }
    
    @objc
    func showWithNoTitle(_ sender: UIButton) {
        XWAKHud.show(msg: "这个没有标题", ignoreInteraction: false)
    }
    
    @objc
    func showWithTitle(_ sender: UIButton) {
        XWAKHud.show(title: "这里是标题", msg: "这个有标题", ignoreInteraction: false)
    }
    
    @objc
    func showWithNoTitleAndMsg(_ sender: UIButton) {
        XWAKHud.wait()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XWAKHud.dismiss()
        }
    }
    
    @objc
    func autoDismiss(_ sender: UIButton) {
        XWAKHud.show(in: view, title: "", msg: "会自动隐藏的", delay: 1.5)
    }
    
    @objc
    func dismissHud(_ sender: UIButton) {
        XWAKHud.dismiss()
    }
    
    @objc
    func showTitleAndIndicator(_ sender: UIButton) {
        XWAKHud.show(in: view, title: "标题", showIndicator: true, delay: 3, ignoreInteraction: true)
    }
    
    @objc
    func showIndicatorAndMsg(_ sender: UIButton) {
        XWAKHud.show(in: view, msg: "内容", showIndicator: true, delay: 3, ignoreInteraction: true)
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
