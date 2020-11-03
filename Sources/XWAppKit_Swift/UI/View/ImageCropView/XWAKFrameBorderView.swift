//
//  XWAKFrameBorderView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

protocol XWAKFrameBorderViewDelegate {
    func borderView(_ view: XWAKFrameBorderView, willChange direction: XWAKImageCropBorder.Direction)
    func borderView(_ view: XWAKFrameBorderView, didChanged direction: XWAKImageCropBorder.Direction)
}


class XWAKFrameBorderView: UIView {

    private let leftLine = XWAKImageCropBorder(border: .left)
    private let rightLine = XWAKImageCropBorder(border: .right)
    private let topLine = XWAKImageCropBorder(border: .top)
    private let bottomLine = XWAKImageCropBorder(border: .bottom)
    
    public var delegate: XWAKFrameBorderViewDelegate?
    
    private(set) var direction: XWAKImageCropBorder.Direction = .none {
        willSet {
            delegate?.borderView(self, willChange: direction)
        }
        didSet {
            leftLine.isHidden = direction != leftLine.direction && direction != .none
            rightLine.isHidden = direction != rightLine.direction && direction != .none
            topLine.isHidden = direction != topLine.direction && direction != .none
            bottomLine.isHidden = direction != bottomLine.direction && direction != .none
            isEditing = direction != .none
            delegate?.borderView(self, didChanged: direction)
        }
    }
    @objc dynamic var isEditing: Bool = false
    
    private func setup() {
        backgroundColor = .clear
        
        leftLine.delegate = self
        rightLine.delegate = self
        topLine.delegate = self
        bottomLine.delegate = self
        
        addSubview(leftLine)
        addSubview(rightLine)
        addSubview(topLine)
        addSubview(bottomLine)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var frame: CGRect {
        didSet {
            setupLinesPosition()
        }
    }

    private func setupLinesPosition() {
        let leftFrame = CGRect(x: 0, y: 0, width: 20, height: frame.height)
        let rightFrame = CGRect(x: frame.width - 20, y: 0, width: 20, height: frame.height)
        let topFrame = CGRect(x: 0, y: 0, width: frame.width, height: 20)
        let bottomFrame = CGRect(x: 0, y: frame.height - 20, width: frame.width, height: 20)
        leftLine.frame = leftFrame
        rightLine.frame = rightFrame
        topLine.frame = topFrame
        bottomLine.frame = bottomFrame
    }
    
    public func removeObstacle(_ remove: Bool) {
        let needRemove = direction != .none && remove
        leftLine.needHideSomeView(needRemove)
        rightLine.needHideSomeView(needRemove)
        topLine.needHideSomeView(needRemove)
        bottomLine.needHideSomeView(needRemove)
    }

}

extension XWAKFrameBorderView: XWAKImageCropBorderDelegate {
    func border(_ borderLine: XWAKImageCropBorder, didSelected direction: XWAKImageCropBorder.Direction) {
        self.direction = direction == self.direction ? .none : direction
    }
}
