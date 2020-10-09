//
//  XWAKImageClipedView.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKImageClipedView: UIView {

    public var contentView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let contentView = contentView {
                addSubview(contentView)
                contentView.frame = CGRect(origin: contentOrigin, size: contentSize)
            }
        }
    }
    public var contentSize: CGSize = .zero {
        didSet {
            contentView?.frame.size = contentSize
        }
    }
    public var contentOffset: CGPoint = .zero {
        didSet {
            contentView?.frame.origin = contentOrigin
        }
    }
    
    private var contentOrigin: CGPoint {
        return CGPoint(x: -contentOffset.x, y: -contentOffset.y)
    }
    
    public func setupClip(_ clip: CGRect) {
        clipRect = clip
        updateClipMask()
        bringSubviewToFront(maskToView)
    }
    
    private var contentOffsetBounds: CGRect {
//        let width = contentSize.width - bounds.width
//        let height = contentSize.height - bounds.height

        let width = contentSize.width - clipRect.width
        let height = contentSize.height - clipRect.height
        return CGRect(x: -clipRect.minX, y: -clipRect.minY, width: width, height: height)
    }
    private let panRecognizer = UIPanGestureRecognizer()
    private let pinRecognizer = UIPinchGestureRecognizer()
    private var lastDate: Date?
    private var state: State = .default
    private var contentOffsetAnimation: XWAKTimerAnimation?
    
    private let maskToView = UIView()
    private let maskToLayer = CAShapeLayer()
    private var clipRect: CGRect = .zero
    
    private enum State {
        case `default`
        case dragging(initialOffset: CGPoint)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addGestureRecognizer(panRecognizer)
        panRecognizer.addTarget(self, action: #selector(handlePanRecognizer(_:)))
        
        addGestureRecognizer(pinRecognizer)
        pinRecognizer.addTarget(self, action: #selector(handlePinRecognizer(_:)))
        
        maskToView.frame = bounds
        maskToView.backgroundColor = .black
        addSubview(maskToView)
//        clipRect = CGRect(x: 20, y: 100, width: bounds.width - 40, height: bounds.height - 200)
        let path = UIBezierPath(rect: bounds)
        path.append(UIBezierPath(rect: clipRect))
        maskToLayer.path = path.cgPath
        maskToLayer.fillRule = .evenOdd
        maskToView.layer.mask = maskToLayer
    }
    
    private func updateClipMask() {
        let path = UIBezierPath(rect: maskToView.bounds)
//        path.append(UIBezierPath(rect: clipRect))
//        maskToLayer.fillRule = .evenOdd
        path.append(UIBezierPath(rect: clipRect).reversing())
        
        maskToLayer.path = path.cgPath
    }

    @objc
    private func handlePanRecognizer(_ sender: UIPanGestureRecognizer) {
        let curDate = Date()
        switch sender.state {
        case .began:
            stopOffsetAnimation()
            state = .dragging(initialOffset: contentOffset)
        case .changed:
            let translation = sender.translation(in: self)
            if case .dragging(let initialOffset) = state {
                contentOffset = clampOffset(initialOffset - translation)
            }
        case .ended:
            state = .default
            let userHadStopppedDragging = curDate.timeIntervalSince(lastDate ?? curDate) >= 0.1
            let velocity: CGPoint = userHadStopppedDragging ? .zero : sender.velocity(in: self)
            if contentOffsetBounds.containsIncludingBorders(contentOffset) {
                startDeceleration(withVelocity: -velocity)
            }
            else {
                bounce(withVelocity: -velocity)
            }
        case .cancelled, .failed:
            state = .default
        case .possible:
            break
        @unknown default:
            fatalError()
        }
        lastDate = curDate
    }
    
    var originFrame: CGRect = .zero
    var originCenter: CGPoint = .zero
    var lastScale: CGFloat = 0.0
    @objc
    private func handlePinRecognizer(_ sender: UIPinchGestureRecognizer) {
        switch sender.state {
        case .began:
            lastScale = 1.0
            print("pinch began")
        case .changed:
            let scale = 1.0 - (lastScale - sender.scale)
            contentView?.transform = (contentView?.transform.scaledBy(x: scale, y: scale))!
            lastScale = sender.scale
        case .ended:
            print("pinch ended: ")
        case .cancelled, .failed:
            print("pinch \(sender.state)")
        case .possible:
            print("pinch possible")
        @unknown default:
            fatalError()
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        stopOffsetAnimation()
    }
    
    private func stopOffsetAnimation() {
        contentOffsetAnimation?.invalidate()
        contentOffsetAnimation = nil
    }
    
    private func clampOffset(_ offset: CGPoint) -> CGPoint {
        let rubberBand = XWAKRubberBand(dims: bounds.size, bounds: contentOffsetBounds)
        return rubberBand.clamp(offset)
    }
    
    private func startDeceleration(withVelocity velocity: CGPoint) {
        let d = UIScrollView.DecelerationRate.normal.rawValue
        let parameters = XWAKDecelerationTimingParameters(initialValue: contentOffset, initialVelocity: velocity, decelerationRate: d, threshold: 0.5)
        let destination = parameters.destination
        
        let intersection = getIntersection(rect: contentOffsetBounds, segment: (contentOffset, destination))
        
        let duration: TimeInterval
        if let intersection = intersection, let intersectionDuration = parameters.duration(to: intersection) {
            duration = intersectionDuration
        }
        else {
            duration = parameters.duration
        }
        contentOffsetAnimation = XWAKTimerAnimation(
            duration: duration,
            animations: {[weak self] _, time in
                self?.contentOffset = parameters.value(at: time)
            },
            completion: { [weak self] finished in
                guard finished && intersection != nil else { return }
                let velocity = parameters.velocity(at: duration)
                self?.bounce(withVelocity: velocity)
            })
        
    }
    
    private func bounce(withVelocity velocity: CGPoint) {
        let restOffset = contentOffset.clamped(to: contentOffsetBounds)
        let displacement = contentOffset - restOffset
        let threshold = 0.5 / UIScreen.main.scale
        let spring = XWAKSpring(mass: 1, stiffness: 100, dampingRatio: 1)
        
        let parameters = XWAKSpringTimingParameters(spring: spring,
                                                    displacement: displacement,
                                                    initialVelocity: velocity,
                                                    threshold: threshold)
        contentOffsetAnimation = XWAKTimerAnimation(
            duration: parameters.duration,
            animations: { [weak self] _, time in
                self?.contentOffset = restOffset + parameters.value(at: time)
            })
    }
}

extension CGRect {
    func containsIncludingBorders(_ point: CGPoint) -> Bool {
        return !(point.x < minX || point.x > maxX || point.y < minY || point.y > maxY)
    }
    
    static func *(lhs: CGRect, rhs: CGFloat) -> CGRect {
        return CGRect(x: lhs.minX * rhs, y: lhs.minY * rhs, width: lhs.width * rhs, height: lhs.height * rhs)
    }
}
