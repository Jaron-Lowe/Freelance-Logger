//
//  JLSlideTransitionAnimator.swift
//
//  Created by Jaron Lowe.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


enum ScreenEdge {
    case Top
    case Left
    case Bottom
    case Right
}

class JLSlideTransitionAnimator: JLBaseTransitionAnimator {
    
    
    // ============================================================================
    // MARK: - Properties
    // ============================================================================
    
    // Variables
    var edge:ScreenEdge = .Right;
    
    
    // ============================================================================
    // MARK: - Transition Protocol Methods
    // ============================================================================
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let fromView:UIView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view;
        let toView:UIView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view;
        
        // Get Container View that transition will take place in
        let containerView:UIView = transitionContext.containerView()!;
        
        // Get Duration
        let duration:NSTimeInterval = self.transitionDuration(transitionContext);
        
        
        // Get animation offset
        let initialRect:CGRect = transitionContext.initialFrameForViewController(transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!)
        let startRect:CGRect = self.rectStartOffset(originRect: initialRect);
        let endRect:CGRect = self.rectEndOffset(originRect: initialRect);
        
        // Appearing
        if (self.appearing == true) {
            
            // Position destination view offscreen
            toView.frame = startRect;
            containerView.addSubview(fromView);
            containerView.addSubview(toView);
            
            
            UIView.animateWithDuration(duration,
                delay:0.0,
                options:[.CurveEaseInOut],
                animations: {_ in
                    toView.frame = initialRect;
                    fromView.frame = endRect;
                },
                completion: {_ in
                    transitionContext.completeTransition(true);
                }
            );
            
        }
        
        // Disappearing
        else {
            containerView.addSubview(toView);
            containerView.addSubview(fromView);
            containerView.sendSubviewToBack(toView);
            
            UIView.animateWithDuration(duration,
                delay:0.0,
                options:[.CurveEaseInOut],
                animations: {_ in
                    fromView.frame = startRect;
                    toView.frame = initialRect;
                },
                completion: {_ in
                    fromView.removeFromSuperview();
                    transitionContext.completeTransition(true);
                }
            );
        }
    }
    
    
    // ============================================================================
    // MARK: - Action Methods
    // ============================================================================
    
    // Get start offset of transition based on edge
    func rectStartOffset(originRect originRect:CGRect) -> CGRect {
        var offsetRect:CGRect = originRect;
        
        switch (self.edge) {
            
            case .Top:
                offsetRect.origin.y -= CGRectGetHeight(originRect);
            
            case .Left:
                offsetRect.origin.x -= CGRectGetHeight(originRect);
            
            case .Bottom:
                offsetRect.origin.y += CGRectGetHeight(originRect);
            
            case .Right:
                offsetRect.origin.x += CGRectGetHeight(originRect);
            
        }
        return offsetRect;
    }
    
    // Get End offset of transition based on edge
    func rectEndOffset(originRect originRect:CGRect) -> CGRect {
        var offsetRect:CGRect = originRect;
        
        switch (self.edge) {
            
        case .Top:
            offsetRect.origin.y += CGRectGetHeight(originRect);
            
        case .Left:
            offsetRect.origin.x += CGRectGetHeight(originRect);
            
        case .Bottom:
            offsetRect.origin.y -= CGRectGetHeight(originRect);
            
        case .Right:
            offsetRect.origin.x -= CGRectGetHeight(originRect);
            
        }
        return offsetRect;
    }

}
