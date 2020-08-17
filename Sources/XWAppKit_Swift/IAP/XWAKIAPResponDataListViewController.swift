//
//  XWAKIAPResponDataListViewController.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/31.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKIAPResponDataListViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    private let dataSouce = XWAKIAPVerify().loadDeviceDatas()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        // Do any additional setup after loading the view.
    }

}

extension XWAKIAPResponDataListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = URL(fileURLWithPath: dataSouce[indexPath.row]).lastPathComponent
        cell.textLabel?.text = item
        return cell
    }
}

extension XWAKIAPResponDataListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let path = dataSouce[indexPath.row]
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let obj = try JSONDecoder().decode(XWAKVerifyResponse.self, from: data)
            print(obj)
        }
        catch {
            print("error: ", error)
        }
    }
}
