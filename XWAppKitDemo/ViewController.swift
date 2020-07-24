//
//  ViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let dataSources = [
        "XWSwitchButton"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = XWAppKitSwitchViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
