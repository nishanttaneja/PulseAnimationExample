//
//  PulseAnimationLayer.swift
//  
//
//  Created by Nishant Taneja on 07/01/22.
//

import UIKit

public class PulseAnimationLayer: CALayer {
    
    /// KeyPath for updating pulse-scaling animaiton.
    static private let SCALE_ANIMATION_KEYPATH = "transform.scale.xy"
    /// KeyPath for updating pulse-opacity animation.
    static private let OPACITY_ANIMATION_KEYPATH = "opacity"
    /// KeyPath for pulse animation.
    static private let GROUP_ANIMATION_KEYPATH = "pulse_animation"
    
    // MARK: - Properties
    
    /// Number of times pulse is displayed in a pulse animation.
    public var pulseRepeatCount: Float {
        get {
            groupAnimation.repeatCount
        }
        set {
            groupAnimation.repeatCount = newValue
        }
    }
    /// Duration of pulse animation.
    public var pulseDuration: CFTimeInterval {
        get {
            duration
        }
        set {
            groupAnimation.duration = newValue
            scaleAnimation.duration = newValue
            opacityAnimation.duration = newValue
        }
    }
    
    
    // MARK: - Animations
    
    private let groupAnimation = CAAnimationGroup()
    private let scaleAnimation = CABasicAnimation(keyPath: SCALE_ANIMATION_KEYPATH)
    private let opacityAnimation = CAKeyframeAnimation(keyPath: OPACITY_ANIMATION_KEYPATH)
    
    private func configAnimations() {
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        opacityAnimation.keyTimes = [0, 0.5, 1]
        opacityAnimation.values = [0, 0.5, 0]
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.timingFunction = .init(name: .default)
        groupAnimation.isRemovedOnCompletion = true
    }
    
    public func startAnimating(at location: CGPoint) {
        DispatchQueue.main.async { [weak self] in
            self?.position = location
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
                guard let groupAnimation = self?.groupAnimation else { return }
                self?.add(groupAnimation, forKey: Self.GROUP_ANIMATION_KEYPATH)
            }
        }
    }
    
    
    // MARK: - Constructors
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public init(duration: CFTimeInterval = 1, repeatCount: Float = 4, radius: CGFloat = 200, color: UIColor = .systemRed) {
        super.init()
        opacity = .zero
        backgroundColor = color.cgColor
        bounds = .zero
        frame = .init(origin: .zero, size: .init(width: radius*2, height: radius*2))
        cornerRadius = radius
        pulseDuration = duration
        pulseRepeatCount = repeatCount
        configAnimations()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

