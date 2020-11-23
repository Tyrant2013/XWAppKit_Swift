//
//  XWAKIAPViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/31.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKIAPViewController: UIViewController {
    private let verify = XWAKIAPVerify()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let comsumeButton = makeButton(title: "消耗型项目", sel: #selector(buyComsume(_:)))
        
        let nonComsumeButton = makeButton(title: "非消耗型项目", sel: #selector(buyNoncomsume(_:)))
        
        let autoRenewalButton = makeButton(title: "自动续费型项目", sel: #selector(buyAutoRenewal(_:)))
        
        let nonAutoRenewalButton = makeButton(title: "非自动续费型项目", sel: #selector(buyNonAutoRenewal(_:)))
        
        let showButton = makeButton(title: "显示验证数据", sel: #selector(showVerifyDataList(_:)))
        
        NSLayoutConstraint.activate([
            comsumeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            comsumeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            comsumeButton.heightAnchor.constraint(equalToConstant: 50),
            comsumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nonComsumeButton.topAnchor.constraint(equalTo: comsumeButton.bottomAnchor, constant: 10),
            nonComsumeButton.widthAnchor.constraint(equalTo: comsumeButton.widthAnchor),
            nonComsumeButton.heightAnchor.constraint(equalTo: comsumeButton.heightAnchor),
            nonComsumeButton.centerXAnchor.constraint(equalTo: comsumeButton.centerXAnchor),
            
            autoRenewalButton.topAnchor.constraint(equalTo: nonComsumeButton.bottomAnchor, constant: 10),
            autoRenewalButton.widthAnchor.constraint(equalTo: comsumeButton.widthAnchor),
            autoRenewalButton.heightAnchor.constraint(equalTo: comsumeButton.heightAnchor),
            autoRenewalButton.centerXAnchor.constraint(equalTo: comsumeButton.centerXAnchor),
            
            nonAutoRenewalButton.topAnchor.constraint(equalTo: autoRenewalButton.bottomAnchor, constant: 10),
            nonAutoRenewalButton.widthAnchor.constraint(equalTo: comsumeButton.widthAnchor),
            nonAutoRenewalButton.heightAnchor.constraint(equalTo: comsumeButton.heightAnchor),
            nonAutoRenewalButton.centerXAnchor.constraint(equalTo: comsumeButton.centerXAnchor),
            
            showButton.topAnchor.constraint(equalTo: nonAutoRenewalButton.bottomAnchor, constant: 10),
            showButton.widthAnchor.constraint(equalTo: comsumeButton.widthAnchor),
            showButton.heightAnchor.constraint(equalTo: comsumeButton.heightAnchor),
            showButton.centerXAnchor.constraint(equalTo: comsumeButton.centerXAnchor),
        ])
    }
    
    private func makeButton(title: String, sel: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: sel, for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        view.addSubview(button)
        return button
    }
    
    private func buy(name: String, productID: String) {
        XWAKIAPManager.post(productID: productID, processHandler: { state in
            print(name, ":", state)
            switch state {
            case .requestProductStart:
                XWAKHud.show(msg: "请求商品信息")
            case .requestProductSuccess:
                XWAKHud.show(msg: "商品信息请求成功")
            case .requestProductFailed:
                XWAKHud.show(msg: "商品信息请求失败", delay: 3.0)
            case .transactionPurchasing(let transaction):
                XWAKHud.show(msg: "开始支付: \(transaction)")
            case .transactionStart:
                XWAKHud.show(msg: "交易开始")
            case .transactionPurchased(let transaction):
                XWAKHud.show(msg: "交易完成: \(transaction)", delay: 3.0)
            case .transactionRestored(let transaction):
                XWAKHud.show(msg: "恢复购买完成: \(transaction)", delay: 3.0)
            case .transactionDeferred(let transaction):
                XWAKHud.show(msg: "Deferred状态: \(transaction)", delay: 3.0)
            case .transactionFailed(let transaction):
                XWAKHud.show(msg: "交易失败: \(transaction)", delay: 3.0)
            }
        }) { result in
            switch result {
            case .success(let data):
                XWAKHud.dismiss()
                XWAKHud.wait()
                self.verify.verify(receipt: data, productId: "", transactionId: "") { verifyResult in
                    switch verifyResult {
                    case .success(let response):
                        print(response)
                        XWAKHud.dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                        XWAKHud.show(in: nil, title: nil, msg: error.localizedDescription, delay: 5.0)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                XWAKHud.show(in: nil, title: nil, msg: error.localizedDescription, delay: 5.0)
            }
        }
    }
    
    @objc
    func buyComsume(_ sender: UIButton) {
        buy(name: "buyComsume", productID: "com.indie.XWAppKitDemo.productTest")
    }
    
    @objc
    func buyNoncomsume(_ sender: UIButton) {
        buy(name: "buyNoncomsume", productID: "com.indie.XWAppKitDemo.noncomsume")
    }
    
    @objc
    func buyAutoRenewal(_ sender: UIButton) {
        buy(name: "buyAutoRenewal", productID: "com.indie.XWAppKitDemo.auto_renewal")
    }
    
    @objc
    func buyNonAutoRenewal(_ sender: UIButton) {
        buy(name: "buyNonAutoRenewal", productID: "com.indie.XWAppKitDemo.non_auto_renewal")
    }

    @objc
    func showVerifyDataList(_ sender: UIButton) {
        self.verify.showSaveDataList()
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
