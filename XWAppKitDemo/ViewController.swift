//
//  ViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

import MachO

class ViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let dataSources = [
        ("工具",[("贝塞尔曲线", "XWAKBezierToolsViewController")]),
        ("Extension", [
            ("TableView", "XWAKTableViewExtensionViewController")
            ]
        ),
        ("UI", [
            ("Layout", "XWAKLayoutViewController"),
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
            ("Popup View", "XWAKPopupViewController"),
            ("SVG", "XWAKSVGViewController"),
            ("Doughnut View", "XWAKColorPickerDoughnutViewController"),
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
        ),
        
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
        
//        let svg = XWAKSVGLoader(fileName: "Data")
//        svg.parse()
        
//        var threads: thread_act_array_t?
//        var thread_count: mach_msg_type_number_t = 0
//        let kr = task_threads(mach_task_self_, &threads, &thread_count)
//        if kr != KERN_SUCCESS {
//            print("faile")
//            return
//        }
//        print("Call \(thread_count) threads:\n")
        XWAKCallStack.callStack(with: .all)
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
