//
//  AddProjectLayer.m
//  Freelance Logger
//
//  Created by Jaron on 7/11/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "AddProjectLayer.h"
#import "AddProjectBox.h"
#import "BackButton.h"

@implementation AddProjectLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    
    // Add back button
    BackButton *backButton = [[BackButton alloc] init];
    [backButton setTarget:self selector:@selector(backPressed)];
    [backButton setPosition:ccp(backButton.boundingBox.size.width/2+5, size.height-backButton.boundingBox.size.height/2-5)];
    [self addChild:backButton];
    
    // Add my logs box
    AddProjectBox *box = [[AddProjectBox alloc] initWithSize:CGSizeMake(size.width*0.8f, size.height*0.62f)];
    [box setTarget:self selector:@selector(backPressed)];
    [box setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:box z:1 name:@"box"];
    
    
    // Enables user input
    [self setUserInteractionEnabled:YES];
    
    return self;
}

// Switches screens to the my logs screen
-(void)goToMyLogs {
    [self.parent performSelector:@selector(refreshMyLogs)];
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMyLogsScreen]];
    [((AddProjectBox*)[self getChildByName:@"box" recursively:NO]) resetUI];
}


// Triggered when the back button is pressed
-(void)backPressed {
    if (self.active == YES) {[self goToMyLogs];}
}


-(void)activate {
    [super activate];
    [((CCLayer*)[self getChildByName:@"box" recursively:NO]) activate];
}

@end
