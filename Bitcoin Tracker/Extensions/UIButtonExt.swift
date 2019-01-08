//
//  UIButtonExt.swift
//  Bitcoin Tracker
//
//  Created by Hannie Kim on 1/7/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95      // starts at 95% of the size
        pulse.toValue = 1.0         // ends at 100% of the size
        pulse.autoreverses = true   // reverse the animation when done
        pulse.repeatCount = 2       // repeat twice
        // affects the bounciness of the pulse
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        // add animation to the UIView layer
        layer.add(pulse, forKey: nil)
    }       
}
