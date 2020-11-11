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

public typealias LoadPhotosResultHandler = (_ result: Result<[XWAKPhotoAsset], Error>) -> Void
public typealias AuthorizedHandler = (_ canUse: Bool) -> Void

public class XWAKPhotoKit {
    public static let shared = XWAKPhotoKit()
    
    internal init() { }
    
    public func authorized(_ handler: @escaping AuthorizedHandler) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { handler($0 == .authorized) }
        case .denied:
            handler(false)
        case .authorized:
            handler(true)
        default:
            handler(false)
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
    
    public func loadPhotos(from collection: PHAssetCollection, handler: LoadPhotosResultHandler) {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let assets = PHAsset.fetchAssets(in: collection, options: options)
        var results = [XWAKPhotoAsset]()
        assets.enumerateObjects { (asset, index, pStop) in
            results.append(XWAKPhotoAsset(asset: asset))
        }
        handler(.success(results))
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
