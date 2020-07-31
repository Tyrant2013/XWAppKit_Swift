//
//  ViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class ViewController: UITableViewController {

    private let dataSources = [
        [
        "XWAppKitSwitchViewController",
        "XWAKAlertViewController",
        "XWAKHudViewController",
        "XWAKToastViewController",
        "XWAKIAPViewController"
        ],
        ["XWAKLoginViewController"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] {
            let name = dataSources[indexPath.section][indexPath.row]
            if let cls: AnyClass = NSClassFromString(namespace as! String + "." + name) {
                let vcCls = cls as! UIViewController.Type
                
                let vc = vcCls.init()
                navigationController?.pushViewController(vc, animated: true)
            }
            else {
                if let cls: AnyClass = NSClassFromString("XWAppKit_Swift." + name) {
                    let vcCls = cls as! UIViewController.Type
                    let vc = vcCls.init()
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
