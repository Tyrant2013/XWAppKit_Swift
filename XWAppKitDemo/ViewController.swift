//
//  ViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class ViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let dataSources = [
        ("Extension", [
            ("TableView", "XWAKTableViewExtensionViewController")
            ]
        ),
        ("UI", [
            ("SwitchButton", "XWAppKitSwitchViewController"),
            ("Alert", "XWAKAlertViewController"),
            ("Hud", "XWAKHudViewController"),
            ("Toast", "XWAKToastViewController"),
            ("TextView", "XWAKTextViewViewController"),
            ("ClipedImage", "XWAKClipedImageViewController"),
            ("SquareGird", "XWAKSquareGridViewController"),
            ("Photo Asset", "XWAKPhotoAssetViewController"),
            ("Progress", "XWAKProgressViewController"),
            ("Color Picker", "XWAKColorPickerViewController"),
            ]
        ),
        ("Filters",[
            ("Filters", "XWAKFiltersViewController"),
        ]),
        ("ViewController", [
            ("LoginViewController", "XWAKLoginViewController")
            ]
        ),
        ("IAP", [("iap", "XWAKIAPViewController")]
        )
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
        tableView.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 0, edges: [.all])
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSources[section].0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.section].1[indexPath.row].0
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] {
            let name = dataSources[indexPath.section].1[indexPath.row].1
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
