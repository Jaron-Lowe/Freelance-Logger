//
//  CalculatorLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CalculatorLayer.h"
#import "BackButton.h"
#import "CalculatorBox.h"

@implementation CalculatorLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    
    // Add back button
    BackButton *backButton = [[BackButton alloc] init];
    [backButton setTarget:self selector:@selector(backPressed)];
    [backButton setPosition:ccp(backButton.boundingBox.size.width/2+5, size.height-backButton.boundingBox.size.height/2-5)];
    [self addChild:backButton];
    
    // Add calculator box
    CalculatorBox *box = [[CalculatorBox alloc] initWithSize:CGSizeMake(size.width*0.8f, size.height*0.7f)];
    [box setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:box z:1 name:@"box"];
    
    // Enable user input
    [self setUserInteractionEnabled:YES];
    
    return self;
}

-(void)goToMenu {
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMainMenu]];
}


-(void)backPressed {
    if (self.active == YES) {
        [(CalculatorBox*)[self getChildByName:@"box" recursively:NO] resetUI];
        [self goToMenu];
    }
}

@end
