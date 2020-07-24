//
//  XWAKKeychain.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKKeychain {
    
    private class func makeQuery(for key: String) -> [String: Any] {
        return [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : key,
            kSecAttrAccount as String : key,
            kSecAttrAccessible as String : kSecAttrAccessibleAfterFirstUnlock
        ]
    }
    
    public class func save(value: Any, for key: String) {
        var query = makeQuery(for: key)
        SecItemDelete(query as CFDictionary)
        if #available(iOS 11.0, *) {
            do {
                try query[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
            }
            catch {
                print("Keychain Error: ", error)
            }
        }
        else {
            query[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: value)
        }
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Keychain Error: Save failed, ", status)
        }
    }
    
    public class func value(for key: String) -> Any? {
        var query = makeQuery(for: key)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var keyData: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &keyData) == noErr {
            do {
                let value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(keyData as! Data)
                return value
            }
            catch {
                print("Keychain Error: ", error)
            }
        }
        return nil
    }
    
    public class func remove(key: String) -> Bool {
        let query = makeQuery(for: key)
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
