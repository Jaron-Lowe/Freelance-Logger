//
//  LogTrackerLayer.m
//  Freelance Logger
//
//  Created by Jaron on 7/3/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LogTrackerLayer.h"
#import "BackButton.h"
#import "LogTrackerBox.h"

@implementation LogTrackerLayer


-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    
    // Add back button
    BackButton *backButton = [[BackButton alloc] init];
    [backButton setTarget:self selector:@selector(backPressed)];
    [backButton setPosition:ccp(backButton.boundingBox.size.width/2+5, size.height-backButton.boundingBox.size.height/2-5)];
    [self addChild:backButton];

    // Add log tracker box
    LogTrackerBox *box = [[LogTrackerBox alloc] initWithSize:CGSizeMake(size.width, size.height)];
    [box setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2)];
    [self addChild:box z:1 name:@"box"];
    
    // Enable user interaction
    [self setUserInteractionEnabled:YES];
    
    return self;
}

-(void)goToMyLogs {
    [self.parent performSelector:@selector(refreshMyLogs)];
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMyLogsScreen]];
}


-(void)backPressed {
    
    if (self.active == YES) {
        [self goToMyLogs];
    }
}



-(void)refreshDataWithIndex:(int)aIndex {
    LogTrackerBox *mainBox = (LogTrackerBox*)[self getChildByName:@"box" recursively:NO];
    [mainBox refreshDataWithIndex:aIndex];
    
    
}

@end
