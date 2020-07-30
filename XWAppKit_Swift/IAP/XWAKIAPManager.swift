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
    case invalidProducts(productIDs: Array<String>)
    case product(reason: String)
    case receipt(reason: Error)
    case receiptNotFound
    case transactionFailed(reason: Error)
}

extension XWAKIAPFailed {
    public var localizedDescription: String {
        switch self {
        case .cancel:
            return "User Cancel"
        case .network:
            return "Network Error"
        case .invalidProducts(let productIDs):
            return "Invalid Products: \(productIDs)"
        case .product(let reason):
            return "Request Error: \(reason)"
        case .receipt(let reason):
            return "Receipt Error: \(reason)"
        case .receiptNotFound:
            return "Receipt Not Found"
        case .transactionFailed(let reason):
            return "transaction failed: \(reason)"
        }
    }
}

typealias XWAKIAPResultHandler = (Result<String, XWAKIAPFailed>) -> Void
public class XWAKIAPManager: NSObject {
    private static let shared = XWAKIAPManager()
    private var resultHandler: XWAKIAPResultHandler!
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    private func post(productID: String, handler: @escaping XWAKIAPResultHandler) {
        resultHandler = handler
        
        let request = SKProductsRequest(productIdentifiers: Set(arrayLiteral: productID))
        request.delegate = self
        request.start()
    }
    
    public class func post(productID: String, handler: @escaping (_ result: Result<String, XWAKIAPFailed>) -> Void) {
        XWAKIAPManager.shared.post(productID: productID, handler: handler)
    }
}

extension XWAKIAPManager: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.invalidProductIdentifiers.count > 0 {
            resultHandler(.failure(.invalidProducts(productIDs: response.invalidProductIdentifiers)))
            return
        }
        if let product = response.products.first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        resultHandler(.failure(.product(reason: error.localizedDescription)))
    }
}

extension XWAKIAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("state purchasing: do nothing")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                if let receiptURL = Bundle.main.appStoreReceiptURL {
                    do {
                        let receiptData = try Data(contentsOf: receiptURL)
                        let receiptStr = receiptData.base64EncodedString(options: .endLineWithLineFeed)
                        resultHandler(.success(receiptStr))
                    }
                    catch {
                        resultHandler(.failure(.receipt(reason: error)))
                    }
                }
                else {
                    resultHandler(.failure(.receiptNotFound))
                }
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                if let error = transaction.error {
                    resultHandler(.failure(.transactionFailed(reason: error)))
                }
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
