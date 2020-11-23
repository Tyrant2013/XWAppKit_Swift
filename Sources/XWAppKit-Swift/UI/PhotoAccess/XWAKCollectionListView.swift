//
//  XWAKCollectionListView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/16.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import Photos

protocol XWAKCollectionListViewDelegate {
    func listView(_ listView: XWAKCollectionListView, will Hide: Bool)
    func listView(_ listView: XWAKCollectionListView, didSelected item: String)
}

class XWAKCollectionListView: UIView {

    public var items = [String]() {
        didSet {
            let height = CGFloat(items.count > 10 ? 10 : items.count) * tableView.rowHeight
            self.height.constant = height
        }
    }
    public var delegate: XWAKCollectionListViewDelegate?
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 40
        return table
    }()
    private(set) var height: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayouts()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupLayouts()
    }
    
    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.9)
        clipsToBounds = true
        
        addSubview(container)
        container.addSubview(tableView)
        container.layer.mask = pathLayer
        addSubview(bottomView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTouched(_:)))
        bottomView.addGestureRecognizer(tap)
    }
    
    @objc
    func tapTouched(_ sender: UITapGestureRecognizer) {
        hide()
    }
    
    private func setupLayouts() {
        tableView.xwak.edge(equalTo: container.xwak, inset: 0, edges: [.left, .top, .right, .bottom])
        container.xwak.edge(equalTo: xwak, inset: 0, edges: [.left, .top, .right])
        bottomView.xwak.edge(equalTo: xwak, inset: 0, edges: [.left, .right, .bottom])
            .top(equalTo: container.xwak.bottom)
        
        height = NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
        height.isActive = true
    }
    private let pathLayer = CAShapeLayer()
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: container.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        pathLayer.frame = container.bounds
        pathLayer.path = path.cgPath
    }
    
    public func show() {
        container.transform = CGAffineTransform(translationX: 0, y: -height.constant)
        UIView.animate(withDuration: 0.25) {
            self.container.transform = .identity
            self.alpha = 1.0
        } completion: { (finished) in
            
        }

    }
    
    public func hide() {
        delegate?.listView(self, will: true)
        UIView.animate(withDuration: 0.25) {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.height.constant)
            self.alpha = 0.0
        } completion: { (finished) in
            
        }

    }
}

extension XWAKCollectionListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
}

extension XWAKCollectionListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        delegate?.listView(self, didSelected: item)
        hide()
    }
}
