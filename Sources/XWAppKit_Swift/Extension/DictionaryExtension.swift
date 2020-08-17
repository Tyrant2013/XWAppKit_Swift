//
//  DictionaryExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation

extension Dictionary {
    public func xwak_toUrlQueryString() -> String {
        let charactersToEscape = "!*'();:@&=+$,/?%#[]"
        let allowedCharacters = NSCharacterSet(charactersIn: charactersToEscape).inverted
        var queryStr = ""
        self.forEach {
            let value = ($0.value as! String).addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
            queryStr += "&\($0.key)=\(value)"
        }
        if queryStr.count > 0 {
            queryStr = String(queryStr.dropFirst())
        }
        return queryStr
    }
}
