//
//  LogTrackerBox.m
//  Freelance Logger
//
//  Created by Jaron on 7/17/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LogTrackerBox.h"
#import "LogTrackerTop.h"
#import "LogTrackerBottom.h"

@implementation LogTrackerBox

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set properties
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    
    // Add log tracker top
    LogTrackerTop *top = [[LogTrackerTop alloc] initWithSize:CGSizeMake(aSize.width*0.9f, aSize.height*0.3f)];
    [top setPosition:ccp(aSize.width/2, aSize.height*0.88)];
    [self addChild:top z:1 name:@"top"];
    
    LogTrackerBottom *bottom = [[LogTrackerBottom alloc] initWithSize:CGSizeMake(aSize.width*0.9f, aSize.height*0.4f)];
    [bottom setPosition:ccp(aSize.width/2, aSize.height*0.45)];
    [self addChild:bottom z:1 name:@"bottom"];
    
    return self;
}


// ======================================================================
#pragma mark - Log Data Handling
// ======================================================================

-(void)refreshDataWithIndex:(int)aIndex {
    [((LogTrackerTop*)[self getChildByName:@"top" recursively:NO]) refreshDataWithIndex:aIndex];
    [((LogTrackerBottom*)[self getChildByName:@"bottom" recursively:NO]) refreshDataWithIndex:aIndex];
}


@end
