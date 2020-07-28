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
        let loginView = XWAKLoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            loginView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            loginView.heightAnchor.constraint(equalToConstant: 300),
            loginView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
