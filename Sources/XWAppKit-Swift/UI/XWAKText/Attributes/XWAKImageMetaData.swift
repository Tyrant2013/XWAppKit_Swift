//
//  XWAKImageMetaData.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/9.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public struct XWAKImageMetaData {
    public let ascent: CGFloat
    public let descent: CGFloat
    public let width: CGFloat
    public let image: UIImage
    public var imageFrame: CGRect = .zero
    public let ClickBlock: ((_ image: UIImage, _ frame: CGRect) -> Void)?
}

public extension XWAKImageMetaData {
    static func makeImageAttributeString(image: UIImage, size: CGSize? = nil, tapHandler: @escaping (_ image: UIImage, _ frame: CGRect) -> Void) -> NSAttributedString {
        let imageSize = size ?? image.size
        let extentBuffer = UnsafeMutablePointer<XWAKImageMetaData>.allocate(capacity: 1)
        extentBuffer.initialize(to: XWAKImageMetaData(ascent: imageSize.height, descent: 0, width: imageSize.width, image: image, ClickBlock: tapHandler))
        var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1) { (pointer) in
        } getAscent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.ascent
        } getDescent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.descent
        } getWidth: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: XWAKImageMetaData.self)
            return d.pointee.width
        }
        let delegate = CTRunDelegateCreate(&callbacks, extentBuffer)
        let attrDictionaryDelegate = [(kCTRunDelegateAttributeName as NSAttributedString.Key) : delegate as Any]
        return NSAttributedString(string: " ", attributes: attrDictionaryDelegate)
    }
}
