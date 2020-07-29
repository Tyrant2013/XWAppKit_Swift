//
//  XWAKLoginViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/28.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKLoginViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(XWAKLoginInputCell.self, forCellReuseIdentifier: "LoginInputCell")
        table.bounces = false
        table.allowsSelection = false
        table.separatorStyle = .none
        return table
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        initTableView()
        // Do any additional setup after loading the view.
    }
    
    private func initTableView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.rowHeight = 340
    }

}

extension XWAKLoginViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoginInputCell")!
        return cell
    }
}
