//
//  CalculatorBox.h
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@interface CalculatorBox : CCLayer {
    CCTextField *priceField;
    CCTextField *timeField;
    
    CCLabelTTF *valueLabel;
}

-(id)initWithSize:(CGSize)aSize;
-(void)resetUI;

@end
