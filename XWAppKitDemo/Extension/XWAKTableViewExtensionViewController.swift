//
//  XWAKTableViewExtensionViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/8/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKTableViewExtensionViewController: UIViewController {

    private var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView.xwak_makeCommonTable(with: UITableViewCell.self,
                                                     dataSource: self,
                                                     delegate: self,
                                                     to: view)
        // Do any additional setup after loading the view.
        
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

extension XWAKTableViewExtensionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
}

extension XWAKTableViewExtensionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
