//
//  XWAKSwitchButton.swift
//  XWAppKit_Swift
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit

public class XWAKSwitchButton: UIControl {
    
    private let animationDuration: CGFloat = 0.3
    private let finalStrokeEndForCheckmark: CGFloat = 0.85
    private let finalStrokeStrartForCheckmark: CGFloat = 0.3
    private let checkmarkBounceAmount: CGFloat = 0.1
    private var isSelectedInternal = false
    
    private let trailCircle = CAShapeLayer()
    private let circle = CAShapeLayer()
    private let checkmark = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var checkmarkSplitPoint: CGPoint = .zero

    public var lineWidth: CGFloat = 2.0
    
    public var strokeColor: UIColor = .black
    
    public var trailStrokeColor: UIColor = .black
    
    public var backgroundLayerColor: UIColor = .clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
        initEvent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
        initEvent()
    }
    
    public override var isSelected: Bool {
        get {
            return self.isSelectedInternal
        }
        set {
            super.isSelected = newValue
            set(selected: newValue, animated: true)
        }
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        if layer != self.layer { return }
        
        var offset: CGPoint = .zero
        let radius = fmin(bounds.width, bounds.height) / 2.0 - (lineWidth / 2.0)
        offset.x = (bounds.width - radius * 2) / 2.0
        offset.y = (bounds.height - radius * 2) / 2.0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let circleAndTrailFrame = CGRect(origin: offset, size: CGSize(width: radius * 2, height: radius * 2))
        let circlePath = UIBezierPath(ovalIn: circleAndTrailFrame)
        trailCircle.path = circlePath.cgPath
        
        circle.transform = CATransform3DIdentity
        circle.frame = bounds
        circle.path = UIBezierPath(ovalIn: circleAndTrailFrame).cgPath
        circle.transform = CATransform3DMakeRotation(212 * .pi / 180, 0, 0, 1)
        
        let origin = CGPoint(x: offset.x + radius, y: offset.y + radius)
        let checkmarkPath = UIBezierPath()
        var checkmarkStartPoint: CGPoint = .zero
        checkmarkStartPoint.x = origin.x + radius * cos(212 * .pi / 180)
        checkmarkStartPoint.y = origin.y + radius * sin(212 * .pi / 180)
        checkmarkPath.move(to: checkmarkStartPoint)
        
        checkmarkSplitPoint = CGPoint(x: offset.x + radius * 0.9, y: offset.y + radius * 1.4)
        checkmarkPath.addLine(to: checkmarkSplitPoint)
        
        var checkmarkEndPoint: CGPoint = .zero
        checkmarkEndPoint.x = origin.x + radius * cos(320 * .pi / 180)
        checkmarkEndPoint.y = origin.y + radius * sin(320 * .pi / 180)
        checkmarkPath.addLine(to: checkmarkEndPoint)
        
        checkmark.frame = bounds
        checkmark.path = checkmarkPath.cgPath
        
        let innerCircleRadius = fmin(bounds.width, bounds.height) / 2.1 - lineWidth / 2.1
        offset.x = (bounds.width - innerCircleRadius * 2) / 2.0
        offset.y = (bounds.height - innerCircleRadius * 2) / 2.0
        
        backgroundLayer.path = UIBezierPath(ovalIn: CGRect(origin: offset, size: CGSize(width: innerCircleRadius * 2, height: innerCircleRadius * 2))).cgPath
        CATransaction.commit()
    }
    
    public func set(selected: Bool, animated: Bool) {
        isSelectedInternal = selected
        
        checkmark.removeAllAnimations()
        circle.removeAllAnimations()
        trailCircle.removeAllAnimations()
        
        reset(desiredSelected: isSelected, willBe: animated)
        if animated {
            add(animations: isSelected)
            accessibilityLabel = isSelected ? "checked" : "unchecked"
        }
    }
    
    private func initViews() {
        self.layer.addSublayer(self.backgroundLayer)
        backgroundLayer.fillColor = backgroundLayerColor.cgColor
        
        [(trailCircle, trailStrokeColor),
         (circle, strokeColor),
         (checkmark, trailStrokeColor)].forEach {
            $0.0.lineJoin = .round
            $0.0.lineCap = .round
            $0.0.lineWidth = self.lineWidth
            $0.0.fillColor = UIColor.clear.cgColor
            $0.0.strokeColor = $0.1.cgColor
            self.layer.addSublayer($0.0)
        }
        set(selected: false, animated: false)
    }
    
    private func initEvent() {
        addTarget(self, action: #selector(handleToucheUpInside), for: .touchUpInside)
    }
    
    @objc
    private func handleToucheUpInside() {
        set(selected: !isSelected, animated: true)
        sendActions(for: .valueChanged)
    }
    
    private func reset(desiredSelected state: Bool, willBe animated: Bool) {
        CATransaction.begin()
        let desiredAndAnimatedOrNot = (state && animated) || (!state && !animated)
        checkmark.strokeEnd     = desiredAndAnimatedOrNot ? 0.0 : finalStrokeEndForCheckmark
        checkmark.strokeStart   = desiredAndAnimatedOrNot ? 0.0 : finalStrokeStrartForCheckmark
        trailCircle.opacity     = desiredAndAnimatedOrNot ? 0.0 : 1.0
        circle.strokeStart      = desiredAndAnimatedOrNot ? 0.0 : 0.0
        circle.strokeEnd        = desiredAndAnimatedOrNot ? 1.0 : 0.0
        CATransaction.commit()
    }
    
    private func add(animations selected: Bool) {
        let circleAnimationDuration = animationDuration * 0.5
        
        add(checkmarkAnimations: selected, duration: circleAnimationDuration)
        
        add(circleAnimations: selected, duration: circleAnimationDuration)
        
        add(trailColorAnimations: selected)
    }
    
    private func add(checkmarkAnimations selected: Bool, duration: CGFloat) {
        let checkmarkEndDuration = animationDuration * 0.8
        let checkmarkStartDuration = checkmarkEndDuration - duration
        let checkmarkBounceDuration = animationDuration - checkmarkEndDuration
        
        let checkmarkAnimationGroup = CAAnimationGroup()
        checkmarkAnimationGroup.isRemovedOnCompletion = false
        checkmarkAnimationGroup.fillMode = .forwards
        checkmarkAnimationGroup.duration = CFTimeInterval(animationDuration)
        checkmarkAnimationGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let checkmarkStrokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        checkmarkStrokeEndAnimation.duration = CFTimeInterval(checkmarkEndDuration + checkmarkBounceDuration)
        checkmarkStrokeEndAnimation.isRemovedOnCompletion = false
        checkmarkStrokeEndAnimation.fillMode = .forwards
        checkmarkStrokeEndAnimation.calculationMode = .paced
        
        if selected {
            checkmarkStrokeEndAnimation.values = [0.0, finalStrokeEndForCheckmark + checkmarkBounceAmount, finalStrokeEndForCheckmark]
            checkmarkStrokeEndAnimation.keyTimes = [0.0, checkmarkEndDuration as NSNumber, (checkmarkEndDuration + checkmarkBounceDuration) as NSNumber]
        }
        else {
            checkmarkStrokeEndAnimation.values = [finalStrokeEndForCheckmark, finalStrokeEndForCheckmark + checkmarkBounceAmount, -0.1]
            checkmarkStrokeEndAnimation.keyTimes = [0.0, checkmarkBounceDuration as NSNumber, (checkmarkEndDuration + checkmarkBounceDuration) as NSNumber]
        }
        
        let checkmarkStrokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        checkmarkStrokeStartAnimation.duration = CFTimeInterval(checkmarkStartDuration + checkmarkBounceDuration)
        checkmarkStrokeStartAnimation.isRemovedOnCompletion = false
        checkmarkStrokeStartAnimation.fillMode = .forwards
        checkmarkStrokeStartAnimation.calculationMode = .paced
        
        if selected {
            checkmarkStrokeStartAnimation.values = [0.0, finalStrokeStrartForCheckmark + checkmarkBounceAmount, finalStrokeStrartForCheckmark]
            checkmarkStrokeStartAnimation.keyTimes = [0.0, checkmarkStartDuration as NSNumber, (checkmarkStartDuration + checkmarkBounceDuration) as NSNumber]
        }
        else {
            checkmarkStrokeStartAnimation.values = [finalStrokeStrartForCheckmark, finalStrokeStrartForCheckmark + checkmarkBounceAmount, 0.0]
            checkmarkStrokeStartAnimation.keyTimes = [0.0, checkmarkBounceDuration as NSNumber, (checkmarkStartDuration + checkmarkBounceDuration) as NSNumber]
        }
        
        if selected {
            checkmarkStrokeStartAnimation.beginTime = CFTimeInterval(duration)
        }
        
        checkmarkAnimationGroup.animations = [checkmarkStrokeEndAnimation, checkmarkStrokeStartAnimation]
        checkmark.add(checkmarkAnimationGroup, forKey: "CheckmarkAnimation")
    }
    
    private func add(circleAnimations selected: Bool, duration: CGFloat) {
        let circleAnimationGroup = CAAnimationGroup()
        circleAnimationGroup.duration = CFTimeInterval(animationDuration)
        circleAnimationGroup.isRemovedOnCompletion = false
        circleAnimationGroup.fillMode = .forwards
        circleAnimationGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let circleStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        
        circleStrokeEnd.duration = CFTimeInterval(duration)
        circleStrokeEnd.beginTime = selected ? 0.0 : CFTimeInterval(animationDuration - duration)
        circleStrokeEnd.fromValue = selected ? 1.0 : 0.0
        circleStrokeEnd.toValue = selected ? -0.1 : 1.0
        
        circleStrokeEnd.isRemovedOnCompletion = false
        circleStrokeEnd.fillMode = .forwards
        
        circleAnimationGroup.animations = [circleStrokeEnd]
        circle.add(circleAnimationGroup, forKey: "CircleStrokeEnd")
    }
    
    private func add(trailColorAnimations selected: Bool) {
        let trailCircleColor = CABasicAnimation(keyPath: "opacity")
        trailCircleColor.duration = CFTimeInterval(animationDuration)
        trailCircleColor.fromValue = selected ? 0.0 : 1.0
        trailCircleColor.toValue = selected ? 1.0 : 0.0
        trailCircleColor.timingFunction = CAMediaTimingFunction(name: .linear)
        trailCircleColor.fillMode = .forwards
        trailCircleColor.isRemovedOnCompletion = false
        trailCircle.add(trailCircleColor, forKey: "TrailCircleColor")
    }

}
