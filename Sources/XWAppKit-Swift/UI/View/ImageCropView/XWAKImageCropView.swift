//
//  XWAKImageCropView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/11/3.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKImageCropView: UIView {

    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var outerContainer: UIScrollView = {
        let scroll = UIScrollView()
        scroll.maximumZoomScale = 3.0
        scroll.minimumZoomScale = 0.5
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        return scroll
    }()
    private let innerContainer = UIView()
    @objc private let borderContainer = XWAKFrameBorderView()
    
    private let imageView = UIImageView()
    
    private let maskToView = UIView()
    private let maskLayer = CAShapeLayer()
    private var maskFrame: CGRect = .zero
    
    private lazy var imgMovePan = UIPanGestureRecognizer(target: self, action: #selector(imagePanGestureHandler(_:)))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.frame.size == .zero, let image = image {
            let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            let imgSizeFrame = image.size.fixFrameTo(bounds.inset(by: inset))
            let imgFrame = CGRect(origin: imgSizeFrame.origin + .init(x: 10, y: 10), size: imgSizeFrame.size)
            innerContainer.frame = imgFrame
            imageView.frame = innerContainer.bounds
            maskFrame = innerContainer.bounds
            
            updateMaskPath()
            
            borderContainer.frame = maskFrame
            imageCenter = borderContainer.center
            
            setupState()
            
        }
    }
    
    private func setupState() {
        let imgFrame = imageView.frame

        leftState = MoveState(dis: 0, min: -imgFrame.width, max: 0)
        rightState = MoveState(dis: 0, min: 0, max: imgFrame.width)
        hMaskState = MoveState(dis: imgFrame.width, min: 0, max: imgFrame.width)
        
        topState = MoveState(dis: 0, min: -imgFrame.height, max: 0)
        bottomState = MoveState(dis: 0, min: 0, max: imgFrame.height)
        vMaskState = MoveState(dis: imgFrame.height, min: 0, max: imgFrame.height)
    }
    
    private func updateMaskPath() {
        let path = UIBezierPath(rect: maskFrame)
        maskLayer.path = path.cgPath
    }
    
//    private var observation: NSKeyValueObservation?
    private func setup() {
        backgroundColor = .white
        outerContainer.backgroundColor = .lightGray
        innerContainer.backgroundColor = .red
        
        addSubview(outerContainer)
        
        outerContainer.addSubview(innerContainer)
        innerContainer.addSubview(imageView)
        innerContainer.mask = maskToView
        maskToView.layer.addSublayer(maskLayer)
        
        innerContainer.addSubview(borderContainer)
        borderContainer.delegate = self
        
        outerContainer.xwak.edge(equalTo: xwak, inset: 0, edges: [.all])
            .width(equalTo: xwak.width)
            .height(equalTo: xwak.height)
        
        innerContainer.addGestureRecognizer(imgMovePan)
        imgMovePan.isEnabled = false
    }
    
    private enum EditState {
        case none
        case move(origin: CGPoint, direction: XWAKImageCropBorder.Direction, originMask: CGRect)
    }
    private var state: EditState = .none
    
    private struct MoveState {
        var dis: CGFloat = 0
        var min: CGFloat = 0
        var max: CGFloat = 0
        
        var limits: ClosedRange<CGFloat> {
            return min...max
        }
    }
    
    private var leftState: MoveState!
    private var rightState: MoveState!
    private var hMaskState: MoveState!
    
    private var topState: MoveState!
    private var bottomState: MoveState!
    private var vMaskState: MoveState!
    
    @objc
    func imagePanGestureHandler(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            borderContainer.removeObstacle(true)
            state = .move(origin: imageView.frame.origin, direction: borderContainer.direction, originMask: maskFrame)
            break
        case .changed:
            let translate = sender.translation(in: innerContainer)
            let imgFrame = imageView.frame
            var movedOrigin = imgFrame.origin
            if case .move(let origin, let direction, let originMask) = state {
                let point = (origin + translate)
                switch direction {
                case .left:
                    movedOrigin.x = point.x.clamped(to: leftState.limits)
                    let widthLimits = 0...(hMaskState.dis + leftState.dis)
                    maskFrame.size.width = (originMask.width + translate.x).clamped(to: widthLimits)
                case .right:
                    movedOrigin.x = point.x.clamped(to: rightState.limits)
                    maskFrame.origin.x = (originMask.minX + translate.x).clamped(to: hMaskState.limits)
                    let widthLimits = 0...(hMaskState.dis + rightState.dis)
                    maskFrame.size.width = (originMask.width - translate.x).clamped(to: widthLimits)
                case .top:
                    movedOrigin.y = point.y.clamped(to: topState.limits)
                    let heightLimits = 0...(vMaskState.dis + topState.dis)
                    maskFrame.size.height = (originMask.height + translate.y).clamped(to: heightLimits)
                case .bottom:
                    movedOrigin.y = point.y.clamped(to: bottomState.limits)
                    maskFrame.origin.y = (originMask.minY + translate.y).clamped(to: vMaskState.limits)
                    let heightLimits = 0...(vMaskState.dis + bottomState.dis)
                    maskFrame.size.height = (originMask.height - translate.y).clamped(to: heightLimits)
                default:
                    break
                }
                imageView.frame.origin = movedOrigin
                updateMaskPath()
            }
            break
        default:
            borderContainer.removeObstacle(false)
            break
        }
    }
    
    var imageCenter: CGPoint = .zero

}

extension XWAKImageCropView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return innerContainer
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        visibleImageShowInCenter()
    }
    
    private func visibleImageShowInCenter(animated: Bool = false) {
        let visibleFrame = innerContainer.convert(maskFrame, to: outerContainer)
        let outerFrame = outerContainer.frame
        let contentWidth = visibleFrame.width > outerFrame.width ? visibleFrame.width : outerFrame.width
        let contentHeight = visibleFrame.height > outerFrame.height ? visibleFrame.height : outerFrame.height

        // scroll view 的内容中心
        let outerCenter: CGPoint = CGPoint(x: contentWidth / 2, y: contentHeight / 2)
        // 计算当前可见图片处于scroll view中心时左上角的点
        let realOrigin: CGPoint = CGPoint(x: outerCenter.x - visibleFrame.width / 2,
                                          y: outerCenter.y - visibleFrame.height / 2)
        // 计算当前可见图片需要移动的长度
        let delta = realOrigin - visibleFrame.origin
        // 移动可见图片外面的view 并设备 scroll view 的contentSize, 以便只显示可见图片，
        var frame = innerContainer.frame
        frame.origin = frame.origin + delta
        
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.outerContainer.contentSize = CGSize(width: contentWidth, height: contentHeight)
            self.innerContainer.frame = frame
        }
    }
}

extension XWAKImageCropView: XWAKFrameBorderViewDelegate {
    func borderView(_ view: XWAKFrameBorderView, willChange direction: XWAKImageCropBorder.Direction) {
        hMaskState.dis = maskFrame.width
        vMaskState.dis = maskFrame.height
        let imgFrame = imageView.frame
        switch direction {
        case .left:
            leftState.dis = abs(abs(imgFrame.minX) - abs(maskFrame.minX))
            rightState.min = imgFrame.minX - rightState.dis
            rightState.max = imgFrame.minX + hMaskState.dis
        case .right:
            rightState.dis = abs(imgFrame.maxX - maskFrame.maxX)
            leftState.min = imgFrame.minX - hMaskState.dis
            leftState.max = maskFrame.minX
            
            hMaskState.min = maskFrame.minX - rightState.dis
            hMaskState.max = maskFrame.minX + hMaskState.dis
        case .top:
            topState.dis = abs(abs(imgFrame.minY) - abs(maskFrame.minY))
            bottomState.min = imgFrame.minY - bottomState.dis
            bottomState.max = imgFrame.minY + vMaskState.dis
        case .bottom:
            bottomState.dis = abs(imgFrame.maxY - maskFrame.maxY)
            topState.min = imgFrame.minY - vMaskState.dis
            topState.max = maskFrame.minY
            
            vMaskState.min = maskFrame.minY - bottomState.dis
            vMaskState.max = maskFrame.minY + vMaskState.dis
        default:
            break
        }
    }
    
    func borderView(_ view: XWAKFrameBorderView, didChanged direction: XWAKImageCropBorder.Direction) {
        imgMovePan.isEnabled = direction != .none
        view.frame = maskFrame
        if direction == .none { visibleImageShowInCenter(animated: true) }
    }
    
}

public extension XWAKImageCropView {
    func cliped() -> UIImage? {
        guard let image = image else { return nil }
        let scale = image.size.width / imageView.frame.size.width
        let clipRectFromImageView = innerContainer.convert(maskFrame, to: imageView)
        let realClipRect = CGRect(x: clipRectFromImageView.origin.x * scale,
                                  y: clipRectFromImageView.origin.y * scale,
                                  width: clipRectFromImageView.size.width * scale,
                                  height: clipRectFromImageView.size.height * scale)
        if let cgImage = image.cgImage?.cropping(to: realClipRect) {
            let clipImage = UIImage(cgImage: cgImage)
            return clipImage
        }
        return nil
    }
}
