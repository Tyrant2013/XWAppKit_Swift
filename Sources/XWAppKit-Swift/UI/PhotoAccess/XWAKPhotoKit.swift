//
//  XWAKPhotoKit.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/11.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import Foundation
import UIKit
import Photos

public typealias XWAKImageLoadProgressHandler = (_ pencent: CGFloat) -> Void
public typealias XWAKImageLoadedHandler = (_ image: UIImage?) -> Void
public typealias LoadPhotosResultHandler = (_ result: Result<[XWAKPhotoAsset], Error>) -> Void
public typealias AuthorizedHandler = (_ canUse: Bool, _ isLimited: Bool) -> Void

public class XWAKPhotoKit {
    public static let shared = XWAKPhotoKit()
    private(set) var isLimited: Bool = false
    
    internal init() { }
    
    public func authorized(_ handler: @escaping AuthorizedHandler) {
        let status: PHAuthorizationStatus
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: PHAccessLevel.readWrite)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {
                if #available(iOS 14, *) {
                    self.isLimited = PHPhotoLibrary.authorizationStatus(for: .readWrite) == .limited
                    print("requestAuthorization: ", self.isLimited, $0.rawValue)
                }
                handler($0 == .authorized, self.isLimited)
            }
        case .denied:
            handler(false, false)
        case .authorized:
            handler(true, false)
        case .limited:
            isLimited = true
            handler(true, true)
        default:
            handler(false, false)
        }
    }
    
    public func loadAllCollections() -> [PHAssetCollection] {
        let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        var results = [PHAssetCollection]()
        fetchResult.enumerateObjects { (collectionItem, index, pStop) in
            results.append(collectionItem)
        }
        return results
    }
    
    public func loadPhotos(handler: LoadPhotosResultHandler) {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        var results = [XWAKPhotoAsset]()
        let fetchResult = PHAsset.fetchAssets(with: options)
        fetchResult.enumerateObjects { (asset, index, pStop) in
            results.append(XWAKPhotoAsset(asset: asset))
        }
        handler(.success(results))
    }
    
    public func loadPhotos(from collection: String, handler: LoadPhotosResultHandler) {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        if let collectionItem = loadAllCollections().first(where: { $0.localizedTitle == collection }) {
            let assets = PHAsset.fetchAssets(in: collectionItem, options: options)
            var results = [XWAKPhotoAsset]()
            assets.enumerateObjects { (asset, index, pStop) in
                results.append(XWAKPhotoAsset(asset: asset))
            }
            handler(.success(results))
        }
    }
    
    public func loadOriginImage(from asset: PHAsset, requestID: Int, progress: @escaping XWAKImageLoadProgressHandler, handler: @escaping (_ image: UIImage?, _ isDegraded: Bool, _ error: NSError?) -> Void) -> PHImageRequestID {
        
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isNetworkAccessAllowed = true
        options.progressHandler = { (percent, error, pStop, info) in
            DispatchQueue.main.async {
                progress(CGFloat(percent))
            }
        }
        
        return PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
            var downloadFinished = false
            var error: NSError? = nil
            if let info = info {
                error = info[PHImageErrorKey] as? NSError
                downloadFinished = !(info[PHImageCancelledKey] as? Bool ?? false) && (error == nil)
            }
            let isDegraded = (info?[PHImageResultIsDegradedKey] as? Bool ?? false)
            if downloadFinished { handler(image, isDegraded, error) }
        }
    }
    
    public func cancel(requestId: PHImageRequestID) {
        PHImageManager.default().cancelImageRequest(requestId)
    }
    
    public func save(image: UIImage, to collectionName: String, handler: @escaping (_ error: Error?) -> Void) {
        let library = PHPhotoLibrary.shared()
        library.performChanges {
            let collections = self.loadAllCollections()
            var assetCollectionRequest: PHAssetCollectionChangeRequest
            if let saveToCollection = collections.first(where: { $0.localizedTitle == collectionName }) {
                assetCollectionRequest = PHAssetCollectionChangeRequest(for: saveToCollection)!
            }
            else {
                assetCollectionRequest = .creationRequestForAssetCollection(withTitle: collectionName)
            }
            let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let placeHolder = assetRequest.placeholderForCreatedAsset
            assetCollectionRequest.addAssets([placeHolder] as NSFastEnumeration)
        } completionHandler: { (state, error) in
            handler(error)
        }
    }
}
