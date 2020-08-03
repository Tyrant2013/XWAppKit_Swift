//
//  XWAKNetwork.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/8/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation

public typealias XWAKNetworkHandler = (_ result: Result<Data, Error>) -> Void
public class XWAKNetwork: NSObject {
    static let shared = XWAKNetwork()
    
    let queue = OperationQueue()
    private let session: URLSession = {
        let conf = URLSessionConfiguration.default
        let ss = URLSession(configuration: conf, delegate: XWAKNetwork.shared, delegateQueue: XWAKNetwork.shared.queue)
        return ss
    }()
    public func post(request: URLRequest, handler: @escaping XWAKNetworkHandler) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                handler(.failure(error))
                return
            }
            if let data = data {
                handler(.success(data))
            }
        }.resume()
    }
}

extension XWAKNetwork: URLSessionDelegate {
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
}
