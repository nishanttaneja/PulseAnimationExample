//
//  PulseAnimationView.swift
//  
//
//  Created by Nishant Taneja on 07/01/22.
//

import UIKit

public class PulseAnimationView: UIView {
    
    // MARK: - Subview
    
    private let textLabel = UILabel()
    
    private func addTextLabel() {
        textLabel.text = "Tap anywhere!"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    // MARK: - AnimationLayer
    
    public let pulseAnimationLayer = PulseAnimationLayer()
    
    
    // MARK: - GestureRecognizer
    
    @objc private func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: self)
        pulseAnimationLayer.startAnimating(at: location)
    }
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        addGestureRecognizer(tapGesture)
    }
    

    // MARK: - Constructors
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        clipsToBounds = true
        layer.addSublayer(pulseAnimationLayer)
        addGestures()
        addTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

