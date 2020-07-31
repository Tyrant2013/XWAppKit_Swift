//
//  XWAKIAPVerify.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/31.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public enum XWAKVerifyFailed: Error {
    case initRequestData(error: Error)
    case network(error: Error)
    case decode(error: Error)
    case noResponseData
}

public struct XWAKVerifyResponse: Codable {
    // The environment for which the receipt was generated.
    // Possible values: Sandbox, Production
    let environment: String
    // An indicator that an error occurred during the request. A value of 1 indicates a temporary issue; retry validation for this receipt at a later time. A value of 0 indicates an unresolvable issue; do not retry validation for this receipt. Only applicable to status codes 21100-21199.
    let is_retryable: Bool?
    // The latest Base64 encoded app receipt. Only returned for receipts that contain auto-renewable subscriptions.
    let latest_receipt: Data?
    // An array that contains all in-app purchase transactions. This excludes transactions for consumable products that have been marked as finished by your app. Only returned for receipts that contain auto-renewable subscriptions.
    let latest_receipt_info: [XWAKVerifyResponseLastestReceiptInfo]?
    // In the JSON file, an array where each element contains the pending renewal information for each auto-renewable subscription identified by the product_id. Only returned for app receipts that contain auto-renewable subscriptions.
    let pending_renewal_info: [XWAKVerifyResponsePendingRenewalInfo]?
    // A JSON representation of the receipt that was sent for verification.
    let receipt: XWAKVrifyResponseReceipt
    // Either 0 if the receipt is valid, or a status code if there is an error. The status code reflects the status of the app receipt as a whole. See status for possible status codes and descriptions.
    let status: Int
    
}

public struct XWAKVerifyResponseLastestReceiptInfo: Codable {
    // The time Apple customer support canceled a transaction, in a date-time format similar to the ISO 8601. This field is only present for refunded transactions.
    let cancellation_date: String
    // The time Apple customer support canceled a transaction, or the time an auto-renewable subscription plan was upgraded, in UNIX epoch time format, in milliseconds. This field is only present for refunded transactions. Use this time format for processing dates. See cancellation_date_ms for more information.
    // https://developer.apple.com/documentation/appstorereceipts/cancellation_date_ms
    let cancellation_date_ms: String
    // The time Apple customer support canceled a transaction, in the Pacific Time zone. This field is only present for refunded transactions.
    let cancellation_date_pst: String
    // The reason for a refunded transaction. When a customer cancels a transaction, the App Store gives them a refund and provides a value for this key. A value of “1” indicates that the customer canceled their transaction due to an actual or perceived issue within your app. A value of “0” indicates that the transaction was canceled for another reason; for example, if the customer made the purchase accidentally.
    // Possible values: 1, 0
    let cancellation_reason: String
    // The time a subscription expires or when it will renew, in a date-time format similar to the ISO 8601.
    let expires_date: String
    // The time a subscription expires or when it will renew, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. See expires_date_ms for more information.
    // https://developer.apple.com/documentation/appstorereceipts/expires_date_ms
    let expires_date_ms: String
    // The time a subscription expires or when it will renew, in the Pacific Time zone.
    let expires_date_pst: String
    // An indicator of whether an auto-renewable subscription is in the introductory price period. See is_in_intro_offer_period for more information.
    // Possible values: true, false
    // https://developer.apple.com/documentation/appstorereceipts/is_in_intro_offer_period
    let is_in_intro_offer_period: String
    // An indicator of whether a subscription is in the free trial period. See is_trial_period for more information.
    // https://developer.apple.com/documentation/appstorereceipts/is_trial_period
    let is_trial_period: String
    // An indicator that a subscription has been canceled due to an upgrade. This field is only present for upgrade transactions.
    // Value: true
    let is_upgraded: String
    // The time of the original app purchase, in a date-time format similar to ISO 8601.
    let original_purchase_date: String
    // The time of the original app purchase, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. For an auto-renewable subscription, this value indicates the date of the subscription's initial purchase. The original purchase date applies to all product types and remains the same in all transactions for the same product ID. This value corresponds to the original transaction’s transactionDate property in StoreKit.
    let original_purchase_date_ms: String
    // The time of the original app purchase, in the Pacific Time zone.
    let original_purchase_date_pst: String
    // The transaction identifier of the original purchase. See original_transaction_id for more information.
    // https://developer.apple.com/documentation/appstorereceipts/original_transaction_id
    let original_transaction_id: String
    // The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction's payment property.
    let product_id: String
    // The identifier of the subscription offer redeemed by the user. See promotional_offer_id for more information.
    // https://developer.apple.com/documentation/appstorereceipts/promotional_offer_id
    let promotional_offer_id: String
    // The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in a date-time format similar to ISO 8601.
    let purchase_date: String
    // For consumable, non-consumable, and non-renewing subscription products, the time the App Store charged the user's account for a purchased or restored product, in the UNIX epoch time format, in milliseconds. For auto-renewable subscriptions, the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    let purchase_date_ms: String
    // The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the Pacific Time zone.
    let purchase_date_pst: String
    // The number of consumable products purchased. This value corresponds to the quantity property of the SKPayment object stored in the transaction's payment property. The value is usually “1” unless modified with a mutable payment. The maximum value is 10.
    let quantity: String
    // The identifier of the subscription group to which the subscription belongs. The value for this field is identical to the subscriptionGroupIdentifier property in SKProduct.
    let subscription_group_identifier: String
    // A unique identifier for a transaction such as a purchase, restore, or renewal. See transaction_id for more information.
    let transaction_id: String
    // A unique identifier for purchase events across devices, including subscription-renewal events. This value is the primary key for identifying subscription purchases.
    let web_order_line_item_id: String
}

public struct XWAKVerifyResponsePendingRenewalInfo: Codable {
    // The current renewal preference for the auto-renewable subscription. The value for this key corresponds to the productIdentifier property of the product that the customer’s subscription renews. This field is only present if the user downgrades or crossgrades to a subscription of a different duration for the subsequent subscription period.
    let auto_renew_product_id: String
    // The current renewal status for the auto-renewable subscription. See auto_renew_status for more information.
    // https://developer.apple.com/documentation/appstorereceipts/auto_renew_status
    // Possible Values
    // 1
    // The subscription will renew at the end of the current subscription period.
    // 0
    // The customer has turned off automatic renewal for the subscription.
    let auto_renew_status: String
    // The reason a subscription expired. This field is only present for a receipt that contains an expired auto-renewable subscription.
    // https://developer.apple.com/documentation/appstorereceipts/expiration_intent
    // Possible Values
    // 1
    // The customer voluntarily canceled their subscription.
    // 2
    // Billing error; for example, the customer's payment information was no longer valid.
    // 3
    // The customer did not agree to a recent price increase.
    // 4
    // The product was not available for purchase at the time of renewal.
    // 5
    // Unknown error.
    let expiration_intent: String
    // The time at which the grace period for subscription renewals expires, in a date-time format similar to the ISO 8601.
    let grace_period_expires_date: String
    // The time at which the grace period for subscription renewals expires, in UNIX epoch time format, in milliseconds. This key is only present for apps that have Billing Grace Period enabled and when the user experiences a billing error at the time of renewal. Use this time format for processing dates.
    let grace_period_expires_date_ms: String
    // The time at which the grace period for subscription renewals expires, in the Pacific Time zone.
    let grace_period_expires_date_pst: String
    // A flag that indicates Apple is attempting to renew an expired subscription automatically. This field is only present if an auto-renewable subscription is in the billing retry state. See is_in_billing_retry_period for more information.
    // https://developer.apple.com/documentation/appstorereceipts/is_in_billing_retry_period
    let is_in_billing_retry_period: String
    // The transaction identifier of the original purchase.
    // https://developer.apple.com/documentation/appstorereceipts/original_transaction_id
    let original_transaction_id: String
    // The price consent status for a subscription price increase. This field is only present if the customer was notified of the price increase. The default value is "0" and changes to "1" if the customer consents.
    // Possible values: 1, 0
    let price_consent_status: String
    // The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction's payment property.
    let product_id: String
}

public struct XWAKVrifyResponseReceipt: Codable {
    // See app_item_id.
    let adam_id: Int
    // Generated by App Store Connect and used by the App Store to uniquely identify the app purchased. Apps are assigned this identifier only in production. Treat this value as a 64-bit long integer.
    let app_item_id: Int
    // The app’s version number. The app's version number corresponds to the value of CFBundleVersion (in iOS) or CFBundleShortVersionString (in macOS) in the Info.plist. In production, this value is the current version of the app on the device based on the receipt_creation_date_ms. In the sandbox, the value is always "1.0".
    let application_version: String
    // The bundle identifier for the app to which the receipt belongs. You provide this string on App Store Connect. This corresponds to the value of CFBundleIdentifier in the Info.plist file of the app.
    let bundle_id: String
    // A unique identifier for the app download transaction.
    let download_id: Int
    // The time the receipt expires for apps purchased through the Volume Purchase Program, in a date-time format similar to the ISO 8601.
    let expiration_date: String
    // The time the receipt expires for apps purchased through the Volume Purchase Program, in UNIX epoch time format, in milliseconds. If this key is not present for apps purchased through the Volume Purchase Program, the receipt does not expire. Use this time format for processing dates.
    let expiration_date_ms: String
    // The time the receipt expires for apps purchased through the Volume Purchase Program, in the Pacific Time zone.
    let expiration_date_pst: String
    // An array that contains the in-app purchase receipt fields for all in-app purchase transactions.
    let in_app: [XWAKVerifyResponseInApp]
    // The version of the app that the user originally purchased. This value does not change, and corresponds to the value of CFBundleVersion (in iOS) or CFBundleShortVersionString (in macOS) in the Info.plist file of the original purchase. In the sandbox environment, the value is always "1.0".
    let original_application_version: String
    // The time of the original app purchase, in a date-time format similar to ISO 8601.
    let original_purchase_date: String
    // The time of the original app purchase, in UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    let original_purchase_date_ms: String
    // The time of the original app purchase, in the Pacific Time zone.
    let original_purchase_date_pst: String
    // The time the user ordered the app available for pre-order, in a date-time format similar to ISO 8601.
    let preorder_date: String
    // The time the user ordered the app available for pre-order, in UNIX epoch time format, in milliseconds. This field is only present if the user pre-orders the app. Use this time format for processing dates.
    let preorder_date_ms: String
    // The time the user ordered the app available for pre-order, in the Pacific Time zone.
    let preorder_date_pst: String
    // The time the App Store generated the receipt, in a date-time format similar to ISO 8601.
    let receipt_creation_date: String
    // The time the App Store generated the receipt, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. This value does not change.
    let receipt_creation_date_ms: String
    // The time the App Store generated the receipt, in the Pacific Time zone.
    let receipt_creation_date_pst: String
    // The type of receipt generated. The value corresponds to the environment in which the app or VPP purchase was made.
    // Possible values: Production, ProductionVPP, ProductionSandbox, ProductionVPPSandbox
    let receipt_type: String
    // The time the request to the verifyReceipt endpoint was processed and the response was generated, in a date-time format similar to ISO 8601.
    let request_date: String
    // The time the request to the verifyReceipt endpoint was processed and the response was generated, in UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    let request_date_ms: String
    // The time the request to the verifyReceipt endpoint was processed and the response was generated, in the Pacific Time zone.
    let request_date_pst: String
    // An arbitrary number that identifies a revision of your app. In the sandbox, this key's value is “0”.
    let version_external_identifier: Int
}

public struct XWAKVerifyResponseInApp: Codable {
    // The time Apple customer support canceled a transaction, or the time an auto-renewable subscription plan was upgraded, in a date-time format similar to the ISO 8601. This field is only present for refunded transactions.
    let cancellation_date: String
    // The time Apple customer support canceled a transaction, or the time an auto-renewable subscription plan was upgraded, in UNIX epoch time format, in milliseconds. This field is only present for refunded transactions. Use this time format for processing dates. See cancellation_date_ms for more information.
    // https://developer.apple.com/documentation/appstorereceipts/cancellation_date_ms
    let cancellation_date_ms: String
    // The time Apple customer support canceled a transaction, or the time an auto-renewable subscription plan was upgraded, in the Pacific Time zone. This field is only present for refunded transactions.
    let cancellation_date_pst: String
    // The reason for a refunded transaction. When a customer cancels a transaction, the App Store gives them a refund and provides a value for this key. A value of “1” indicates that the customer canceled their transaction due to an actual or perceived issue within your app. A value of “0” indicates that the transaction was canceled for another reason; for example, if the customer made the purchase accidentally.
    // Possible values: 1, 0
    let cancellation_reason: String
    // The time a subscription expires or when it will renew, in a date-time format similar to the ISO 8601.
    let expires_date: String
    //  The time a subscription expires or when it will renew, in UNIX epoch time format, in milliseconds. Use this time format for processing dates. See expires_date_ms for more information.
    // https://developer.apple.com/documentation/appstorereceipts/expires_date_ms
    let expires_date_ms: String
    // The time a subscription expires or when it will renew, in the Pacific Time zone.
    let expires_date_pst: String
    // An indicator of whether an auto-renewable subscription is in the introductory price period. See is_in_intro_offer_period for more information.
    // https://developer.apple.com/documentation/appstorereceipts/is_in_intro_offer_period
    // Possible Values
    // true
    // The customer’s subscription is in an introductory price period
    // false
    // The subscription is not in an introductory price period.
    let is_in_intro_offer_period: String
    // An indication of whether a subscription is in the free trial period. See is_trial_period for more information.
    // https://developer.apple.com/documentation/appstorereceipts/is_trial_period
    // Possible Values
    // true
    // The subscription is in the free trial period.
    // false
    // The subscription is not in the free trial period.
    let is_trial_period: String
    // The time of the original in-app purchase, in a date-time format similar to ISO 8601.
    let original_purchase_date: String
    // The time of the original in-app purchase, in UNIX epoch time format, in milliseconds. For an auto-renewable subscription, this value indicates the date of the subscription's initial purchase. The original purchase date applies to all product types and remains the same in all transactions for the same product ID. This value corresponds to the original transaction’s transactionDate property in StoreKit. Use this time format for processing dates.
    let original_purchase_date_ms: String
    // The time of the original in-app purchase, in the Pacific Time zone.
    let original_purchase_date_pst: String
    // The transaction identifier of the original purchase. See original_transaction_id for more information.
    // https://developer.apple.com/documentation/appstorereceipts/original_transaction_id
    let original_transaction_id: String
    // The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction's payment property.
    let product_id: String
    // The identifier of the subscription offer redeemed by the user. See promotional_offer_id for more information.
    let promotional_offer_id: String
    // The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in a date-time format similar to ISO 8601.
    let purchase_date: String
    // For consumable, non-consumable, and non-renewing subscription products, the time the App Store charged the user's account for a purchased or restored product, in the UNIX epoch time format, in milliseconds. For auto-renewable subscriptions, the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the UNIX epoch time format, in milliseconds. Use this time format for processing dates.
    let purchase_date_ms: String
    // The time the App Store charged the user's account for a purchased or restored product, or the time the App Store charged the user’s account for a subscription purchase or renewal after a lapse, in the Pacific Time zone.
    let purchase_date_pst: String
    // The number of consumable products purchased. This value corresponds to the quantity property of the SKPayment object stored in the transaction's payment property. The value is usually “1” unless modified with a mutable payment. The maximum value is 10.
    let quantity: String
    // A unique identifier for a transaction such as a purchase, restore, or renewal. See transaction_id for more information.
    let transaction_id: String
    // A unique identifier for purchase events across devices, including subscription-renewal events. This value is the primary key for identifying subscription purchases.
    let web_order_line_item_id: String
    
}

public typealias XWAKVerifyResult = (_ result: Result<XWAKVerifyResponse, XWAKVerifyFailed>) -> Void
public class XWAKIAPVerify: NSObject {
    private let sandBoxUrl = "https://sandbox.itunes.apple.com/verifyReceipt"
    private let productionUrl = "https://buy.itunes.apple.com/verifyReceipt"
    public func verify(receipt data: Data, productId: String, transactionId: String, completeHandler: @escaping XWAKVerifyResult) {
        let requestContents = ["receipt-data" : data.base64EncodedString()]
        do {
            var isInSandbox = true
            if let receiptURL = Bundle.main.appStoreReceiptURL {
                isInSandbox = receiptURL.path.contains("sandbox")
            }
            let verifyUrl = isInSandbox ? self.sandBoxUrl : self.productionUrl
            let requestData =  try JSONSerialization.data(withJSONObject: requestContents, options: .prettyPrinted)
            let url = URL(string: verifyUrl)!
            load(URL: url, httpBody: requestData, requestHandler: completeHandler)
        }
        catch {
            completeHandler(.failure(.initRequestData(error: error)))
        }
    }
    
    private func load(URL url: URL, httpBody: Data, requestHandler: @escaping XWAKVerifyResult) {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                requestHandler(.failure(.network(error: error)))
                return
            }
            if let data = data {
                do {
                    let responOjb = try JSONDecoder().decode(XWAKVerifyResponse.self, from: data)
                    requestHandler(.success(responOjb))
//                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
//                    let environment = jsonObj["environment"] as! String
//                    let status = jsonObj["status"] as! Int
//                    let receipt = jsonObj["receipt"] as! [String : Any]
//                    let bundleId = receipt["bundle_id"] as! String
//                    let inApp = receipt["in_app"] as! [[String : Any]]
                }
                catch {
                    requestHandler(.failure(.decode(error: error)))
                }
            }
            else {
                requestHandler(.failure(.noResponseData))
            }
        }
    }
}
