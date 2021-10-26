//
//  MyLogsLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MyLogsLayer.h"
#import "BackButton.h"
#import "MyLogsBox.h"

@implementation MyLogsLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    
    // Add back button
    BackButton *backButton = [[BackButton alloc] init];
    [backButton setTarget:self selector:@selector(backPressed)];
    [backButton setPosition:ccp(backButton.boundingBox.size.width/2+5, size.height-backButton.boundingBox.size.height/2-5)];
    [self addChild:backButton];
    
    // Add my logs box
    MyLogsBox *box = [[MyLogsBox alloc] initWithSize:CGSizeMake(size.width*0.8f, size.height*0.8f)];
    [box setTarget:self selector:@selector(addEntryPressed)];
    [box setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:box z:1 name:@"box"];
    
    // Enable user interface
    [self setUserInteractionEnabled:YES];
    
    return self;
}


// Returns screen to the menu screen
-(void)goToMenu {
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMainMenu]];
}

// Changes screen to the add entry screen
-(void)goToAddEntry {
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kAddProjectScreen]];
}

// Triggered when add entry is pressed
-(void)addEntryPressed {
    if (self.active == YES) {[self goToAddEntry];}
}

// Triggered when back button pressed
-(void)backPressed {
    if (self.active == YES) {[self goToMenu];}
}

// Refreshes the data of the Log Box
-(void)refreshData {
    MyLogsBox *box = (MyLogsBox*)[self getChildByName:@"box" recursively:NO];
    [box refreshData];
}

@end
