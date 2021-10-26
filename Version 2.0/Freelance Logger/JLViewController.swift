//
//  JLViewController.swift
//
//  Created by Jaron Lowe.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class JLViewController: UIViewController, UINavigationControllerDelegate {
    
    //
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator:JLSlideTransitionAnimator = JLSlideTransitionAnimator();
        animator.duration = 0.50;
        
        if (operation == UINavigationControllerOperation.Push) {animator.appearing = true;}
        else if (operation == UINavigationControllerOperation.Pop) {animator.appearing = false;}
        
        //print("JLViewController - Registering Animator");
        
        return animator;
    }
    
    
    

}
