//
//  XWAKLoginInputCell.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/28.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

class XWAKLoginInputCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        let loginView = XWAKLoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginView.heightAnchor.constraint(equalToConstant: 300),
            loginView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
