//
//  XWAKIAPManager.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/30.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import StoreKit

public enum XWAKIAPFailed: Error {
    case cancel
    case network
}

extension XWAKIAPFailed {
    public var localizedDescription: String {
        switch self {
        case .cancel:
            return "User Cancel"
        case .network:
            return "Network Error"
        }
    }
}

public class XWAKIAPManager: NSObject {
    private static let shared = XWAKIAPManager()
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    public class func post(productID: String, handler: @escaping (_ result: Result<String, XWAKIAPFailed>) -> Void) {
        let request = SKProductsRequest(productIdentifiers: Set(arrayLiteral: productID))
        request.delegate = XWAKIAPManager.shared
        request.start()
    }
}

extension XWAKIAPManager: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        
    }
}

extension XWAKIAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("")
            case .purchased:
                print("")
            case .failed:
                print("")
            case .restored:
                print("")
            case .deferred:
                print("")
            @unknown default:
                print("unkndow transactionState")
            }
        }
    }
}
