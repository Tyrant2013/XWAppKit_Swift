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

public class XWAKPhotoAsset {
    var asset: PHAsset
    var requestId: Int = 0
    var isDegraded: Bool = false
    var isiCloud: Bool = false
    var isCancel: Bool = false
    var thumbImage: UIImage?
    var originImage: UIImage?
    
    var isSelected: Bool = false
    var index: Int = 0
    init(asset: PHAsset) {
        self.asset = asset
    }
}

extension XWAKPhotoAsset {
    func loadThumb(_ handler: @escaping (_ image: UIImage?) -> Void) -> PHImageRequestID {
        if let thumbImage = thumbImage {
            handler(thumbImage)
            return PHInvalidImageRequestID
        }
        let size = CGSize(width: 80, height: 80)
        return PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { [weak self](image, info) in
            if let info = info {
                if let degraded = info[PHImageResultIsDegradedKey] as? Int {
                    self?.isDegraded = degraded != 0
                }
                if let isICloud = info[PHImageResultIsInCloudKey] as? Int {
                    self?.isiCloud = isICloud != 0
                }
                if let requestID = info[PHImageResultRequestIDKey] as? Int {
                    self?.requestId = requestID
                }
                if let cancel = info[PHImageCancelledKey] as? Int {
                    self?.isCancel = cancel != 0
                }
                if let error = info[PHImageErrorKey] as? NSError {
                    print(error)
                }
                if self?.isiCloud ?? false {
                    let options = PHImageRequestOptions()
                    options.isNetworkAccessAllowed = true
                    options.isSynchronous = false
                    options.deliveryMode = .highQualityFormat
                    PHImageManager.default().requestImageData(for: (self?.asset)!, options: options) { (iCloudImageData, str, orientation, info) in
                        if let data = iCloudImageData {
                            let image = UIImage(data: data)
                            self?.thumbImage = image
                            self?.originImage = image
                            handler(image)
                        }
                        else {
                            handler(nil)
                        }
                    }
                }
            }
            handler(image)
            self?.thumbImage = image
        }
    }
    
    func loadOriginImage(_ handler: @escaping (_ image: UIImage?) -> Void) -> PHImageRequestID {
        if let originImage = originImage {
            handler(originImage)
            return PHInvalidImageRequestID
        }
        return XWAKPhotoKit.shared.loadOriginImage(from: asset, requestID: requestId) { (image, isDegraded, error) in
            self.originImage = image
            self.isDegraded = isDegraded
            handler(image)
        }
    }
}
