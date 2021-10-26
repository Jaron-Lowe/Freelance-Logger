//
//  LogTrackerBottom.h
//  Freelance Logger
//
//  Created by Jaron on 7/17/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@interface LogTrackerBottom : CCLayer {
    CCTextField *titleField;
    int index;
}

-(id)initWithSize:(CGSize)aSize;
-(void)refreshDataWithIndex:(int)aIndex;

@end
