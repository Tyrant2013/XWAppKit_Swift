//
//  XWAKProfileCell.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKProfileCell: UITableViewCell {

    
    public var data: XWAKProfileItem! {
        didSet {
            textLabel?.text = data.name
            accessoryType = data.detail == nil ? .detailButton : .none
            detailTextLabel?.text = data.detail
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
