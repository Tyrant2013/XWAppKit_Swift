//
//  XWAKPhotoModels.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit
import Photos

public class XWAKPhotoAsset: Hashable {
    public static func == (lhs: XWAKPhotoAsset, rhs: XWAKPhotoAsset) -> Bool {
        lhs.asset.localIdentifier == rhs.asset.localIdentifier
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(asset.localIdentifier.hash)
    }
//    public var hashValue: Int {
//        return self.asset.localIdentifier.hash
//    }
    
    var asset: PHAsset
    var requestId: Int = 0
    var isDegraded: Bool = false
//    var isiCloud: Bool = false
//    var isCancel: Bool = false
    var thumbImage: UIImage?
    var originImage: UIImage?
    
    var isSelected: Bool = false
    var index: Int = 0
    init(asset: PHAsset) {
        self.asset = asset
    }
}

extension XWAKPhotoAsset {
    func loadThumb(progress: @escaping XWAKImageLoadProgressHandler, _ handler: @escaping XWAKImageLoadedHandler) -> PHImageRequestID {
        if let thumbImage = thumbImage {
            handler(thumbImage)
            return PHInvalidImageRequestID
        }
        let size = CGSize(width: 300, height: 300)
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = true
        options.progressHandler = { (percent, error, pStop, info) in
            progress(CGFloat(percent))
        }
        options.isSynchronous = true
        return PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { [weak self](image, info) in
            if let info = info {
                if let degraded = info[PHImageResultIsDegradedKey] as? Int {
                    self?.isDegraded = degraded != 0
                }
                if let error = info[PHImageErrorKey] as? NSError {
                    print("load thumb error: ", error)
                }
            }
            handler(image)
            self?.thumbImage = image
        }
    }
    
    func loadOriginImage(progress: @escaping XWAKImageLoadProgressHandler, _ handler: @escaping XWAKImageLoadedHandler) -> PHImageRequestID {
        if let originImage = originImage {
            handler(originImage)
            return PHInvalidImageRequestID
        }
        return XWAKPhotoKit.shared.loadOriginImage(from: asset, requestID: requestId, progress: progress) { (image, isDegraded, error) in
            self.originImage = image
            self.isDegraded = isDegraded
            handler(image)
        }
    }
}
