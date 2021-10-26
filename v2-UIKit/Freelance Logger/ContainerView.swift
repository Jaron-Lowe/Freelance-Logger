//
//  ContainerView.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/7/15.
//  Copyright © 2015 Jaron Lowe. All rights reserved.
//

import UIKit

class ContainerView: UIVisualEffectView {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect);
        drawBorders();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.drawBorders();
    }
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    func drawBorders() {
        self.layer.borderColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).CGColor;
        self.layer.borderWidth = 1.0;
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
