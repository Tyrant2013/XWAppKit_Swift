//
//  StringExtension.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    public func xwak_md5() -> Data {
        let cStr = cString(using: .utf8)
        let len = CUnsignedInt(lengthOfBytes(using: .utf8))
        let digLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digLen)
        
        if #available(iOS 13.0, *) {
            CC_SHA256(cStr, len, result)
        }
        else {
            CC_MD5(cStr, len, result)
        }
        return Data(bytes: result, count: digLen)
    }
    
    public func xwak_query() -> Dictionary<String, Any>? {
        if count == 0 { return nil }
        var query = [String : Any]()
        for comp in components(separatedBy: "&") {
            let keyVal = comp.components(separatedBy: "=")
            if keyVal.count == 2 {
                let value = keyVal[1].removingPercentEncoding
                query[keyVal[0]] = value == nil ? "" : value!
            }
            else if keyVal.count == 1 {
                query[keyVal[0]] = ""
            }
        }
        return query.count > 0 ? query : nil
    }
}
