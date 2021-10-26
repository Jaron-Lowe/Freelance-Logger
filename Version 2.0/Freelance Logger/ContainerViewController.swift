//
//  ContainerViewController.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit
import Foundation


class ContainerViewController: UIViewController {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        if let image:UIImage = UIImage(named: "Background.png") { image.drawInRect(self.view.frame); }
        let background:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.view.backgroundColor = UIColor(patternImage: background);
        
        var circleOrigins:[CGPoint] = []
        circleOrigins.append(CGPoint(x: self.view.frame.size.width*0.15, y: self.view.frame.size.height*0.2));
        circleOrigins.append(CGPoint(x: self.view.frame.size.width*0.8, y: self.view.frame.size.height*0.55));
        circleOrigins.append(CGPoint(x: self.view.frame.size.width*0.25, y: self.view.frame.size.height*0.45));
        circleOrigins.append(CGPoint(x: self.view.frame.size.width*0.45, y: self.view.frame.size.height*0.35));
        circleOrigins.append(CGPoint(x: self.view.frame.size.width, y: 0.0));
        
        for var i:Int = 1; i<6; i++ {
            let circle:UIImageView = UIImageView(image: UIImage(named: "Circle_\(i).png"));
            circle.center = circleOrigins[i-1];
            self.view.addSubview(circle);
            
            var xDir:Int = 1;
            var yDir:Int = 1;
            if (arc4random_uniform(100) > 50) {xDir *= -1;}
            if (arc4random_uniform(100) > 50) {yDir *= -1;}
            var speedVariance:UInt32 = arc4random_uniform(9);
            
            
            /*
            someView.frame = frame1;
            [UIView animateKeyframesWithDuration:2.0 delay:0.0 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                someView.frame = frame2;
                }];
                [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                someView.frame = frame3;
                }];
                } completion:nil];
*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool { return true; }
    

}
