//
//  UITableViewExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    class func xwak_makeCommonTable(with registCellClass: AnyClass? = nil,
                                    dataSource: UITableViewDataSource? = nil,
                                    delegate: UITableViewDelegate? = nil,
                                    to view: UIView? = nil) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(registCellClass, forCellReuseIdentifier: "Cell")
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        if let view = view {
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        return tableView
    }
}
