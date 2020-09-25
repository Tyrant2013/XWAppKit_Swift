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
    
    private var contentOffsetBounds: CGRect {
        let width = contentSize.width - bounds.width
        let height = contentSize.height - bounds.height
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    private let panRecognizer = UIPanGestureRecognizer()
    private var lastDate: Date?
    private var state: State = .default
    private var contentOffsetAnimation: XWAKTimerAnimation?
    
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
}
