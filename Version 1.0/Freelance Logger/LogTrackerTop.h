//
//  LogTrackerBox.h
//  Freelance Logger
//
//  Created by Jaron on 7/16/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@interface LogTrackerTop : CCLayer {
    CCTextField *titleField;
    CCTextField *hoursField;
    CCTextField *priceField;
    CCTextField *perHourField;
    LogState currentState;
    int index;
    double segmentSeconds;
    double price;
    double currentStartTime;
    NSString *title;
    
}

-(id)initWithSize:(CGSize)aSize;
-(void)refreshDataWithIndex:(int)aIndex;

@end
