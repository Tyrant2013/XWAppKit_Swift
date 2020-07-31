//
//  XWAKIAPManager.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/30.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import StoreKit

public enum XWAKIAPProcess {
    case requestProductStart
    case requestProductSuccess
    case requestProductFailed
    case transactionStart
    case transactionPurchasing
    case transactionPurchased
    case transactionFailed
    case transactionRestored
    case transactionDeferred
}

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

public typealias XWAKIAPProcessHandler = (_ state: XWAKIAPProcess) -> Void
public typealias XWAKIAPResultHandler = (_ result: Result<Data, XWAKIAPFailed>) -> Void
public class XWAKIAPManager: NSObject {
    private static let shared = XWAKIAPManager()
    private var processHandler: XWAKIAPProcessHandler?
    private var resultHandler: XWAKIAPResultHandler!
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    private func post(productID: String, processHandler: XWAKIAPProcessHandler?, handler: @escaping XWAKIAPResultHandler) {
        resultHandler = handler
        self.processHandler = processHandler
        
        let request = SKProductsRequest(productIdentifiers: Set(arrayLiteral: productID))
        request.delegate = self
        request.start()
        processHandler?(.requestProductStart)
    }
    
    public class func post(productID: String, processHandler: XWAKIAPProcessHandler?, handler: @escaping XWAKIAPResultHandler) {
        XWAKIAPManager.shared.post(productID: productID, processHandler: processHandler, handler: handler)
    }
}

extension XWAKIAPManager: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        processHandler?(.requestProductSuccess)
        if response.invalidProductIdentifiers.count > 0 {
            resultHandler(.failure(.invalidProducts(productIDs: response.invalidProductIdentifiers)))
            return
        }
        if let product = response.products.first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
            processHandler?(.transactionStart)
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        processHandler?(.requestProductFailed)
        resultHandler(.failure(.product(reason: error.localizedDescription)))
    }
}

extension XWAKIAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                processHandler?(.transactionPurchasing)
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                processHandler?(.transactionPurchased)
                if let receiptURL = Bundle.main.appStoreReceiptURL {
                    do {
                        let receiptData = try Data(contentsOf: receiptURL)
                        resultHandler(.success(receiptData))
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
                processHandler?(.transactionFailed)
                if let error = transaction.error {
                    resultHandler(.failure(.transactionFailed(reason: error)))
                }
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                processHandler?(.transactionRestored)
            case .deferred:
                processHandler?(.transactionDeferred)
            @unknown default:
                print("unkndow transactionState")
            }
        }
    }
}
