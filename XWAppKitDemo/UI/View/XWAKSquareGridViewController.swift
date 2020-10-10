//
//  XWAKSquareGridViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/10/10.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKSquareGridViewController: UIViewController {

    private let gridView = XWAKSquareGridView(col: 3, row: 3)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
//        gridView.frame = CGRect(x: 30, y: 100, width: 300, height: 500)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridView)
        gridView.delegate = self
        gridView.xwak.edge(equalTo: view.safeAreaLayoutGuide.xwak, inset: 0, edges: [.all])
        
    }

}

extension XWAKSquareGridViewController: XWAKSquareGridViewDelegate {
    func squareGridView(_ gridView: XWAKSquareGridView, did finishedCliped: CGRect) {
        
    }
}
