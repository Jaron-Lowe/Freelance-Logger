//
//  JLBaseTransitionAnimator.swift
//
//  Created by Jaron Lowe.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//


import UIKit


class JLBaseTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // ============================================================================
    // MARK: - Properties
    // ============================================================================
    
    // Variables
    var appearing:Bool = false;
    var duration:NSTimeInterval = 1.0;
    
    
    // ============================================================================
    // MARK: - Transition Protocol Methods
    // ============================================================================
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Override within child classes
    }
    

}
