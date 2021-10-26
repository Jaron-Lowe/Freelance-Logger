//
//  LogSegment.h
//  Freelance Logger
//
//  Created by Jaron on 7/17/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@interface LogSegment : CCLayer <UIAlertViewDelegate> {
    int index;
    int parentIndex;
    __weak CCNode *container;
}

@property (nonatomic, readwrite) int index;

-(id)initWithSize:(CGSize)aSize index:(int)aIndex parentIndex:(int)aParIndex data:(NSDictionary*)aData container:(CCNode*)aContainer;

@end
