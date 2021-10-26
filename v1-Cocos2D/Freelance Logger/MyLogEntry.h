//
//  MyLogEntry.h
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"
#import "MyLogsBox.h"

@interface MyLogEntry : CCLayer <UIAlertViewDelegate> {
    int index;
    __weak CCNode *container;
}

@property (nonatomic, readwrite) int index;

-(id)initWithSize:(CGSize)aSize index:(int)aIndex data:(NSDictionary*)aData container:(CCNode*)aContainer;

@end
