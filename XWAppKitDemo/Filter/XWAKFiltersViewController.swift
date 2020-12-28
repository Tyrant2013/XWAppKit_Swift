//
//  XWAKFiltersViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/12/28.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKFiltersViewController: UIViewController {

    private let imageView: UIImageView = {
        let image = UIImage(named: "abc")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .red
        return iv
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    private lazy var items: [(String, ImageFilter)] = {
        var datas = [(String, ImageFilter)]()
        let accordionFoldTransition = CIAccordionFoldTransition()
        datas.append((accordionFoldTransition.localizedName, accordionFoldTransition))
        
        let boxBlur = CIBoxBlur()
        boxBlur.inputRadius(10)
        datas.append((boxBlur.localizedName, boxBlur))
        return datas
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.xwak.centerX(equalTo: view.safeAreaLayoutGuide.xwak.centerX)
            .top(equalTo: view.safeAreaLayoutGuide.xwak.top, 50)
            .size((250, 300))
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.xwak.top(equalTo: imageView.xwak.bottom, 10)
            .edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 10, edges: [.left, .right, .bottom])
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

extension XWAKFiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.0
        return cell
    }
}

extension XWAKFiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if let image = imageView.image?.applyingFilter(item.1) {
            imageView.image = image
            print("filter name: ", item.0)
        }
    }
}
