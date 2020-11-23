//
//  XWAKTimerAnimation.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/9/25.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import QuartzCore

public final class XWAKTimerAnimation {
    public typealias Animations = (_ progress: Double, _ time: TimeInterval) -> Void
    public typealias Completion = (_ finished: Bool) -> Void
    
    private let duration: TimeInterval
    private let animations: Animations
    private let completion: Completion?
    private weak var displayLink: CADisplayLink?
    private var running = true
    private let firstFrameTimestamp: CFTimeInterval
    
    public init(duration: TimeInterval, animations: @escaping Animations, completion: Completion? = nil) {
        self.duration = duration
        self.animations = animations
        self.completion = completion
        
        firstFrameTimestamp = CACurrentMediaTime()
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleFrame(_:)))
        displayLink.add(to: .main, forMode: RunLoop.Mode.common)
        self.displayLink = displayLink
    }
    
    deinit {
        invalidate()
    }
    
    public func invalidate() {
        guard running else { return }
        running = false
        completion?(false)
        displayLink?.invalidate()
    }
    
    @objc
    private func handleFrame(_ displayLink: CADisplayLink) {
        guard running else { return }
        let elapsed = CACurrentMediaTime() - firstFrameTimestamp
        if elapsed >= duration {
            animations(1, duration)
            running = false
            completion?(true)
            displayLink.invalidate()
        }
        else {
            animations(elapsed / duration, elapsed)
        }
    }
}
