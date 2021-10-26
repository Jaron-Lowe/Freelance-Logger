//
//  MenuBox.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MenuBox.h"
#import "FadeButton.h"
#import "CCActionShake.h"

@implementation MenuBox

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set Properties
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    
    // Draw border box
    CGPoint verts[4] = {ccp(0, 0), ccp(aSize.width, 0), ccp(aSize.width, aSize.height), ccp(0, aSize.height)};
    CCDrawNode *box = [CCDrawNode node];
    [box drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0.92f green:0.96f blue:0.95f alpha:0.9f] borderWidth:1 borderColor:kBoxBorderColor];
    [self addChild:box z:1 name:@"box"];
    
    // Add title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Welcome" fontName:@"HelveticaNeue-Light" fontSize:42];
    [titleLabel setColor:[CCColor blackColor]];
    [titleLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.85f)];
    [self addChild:titleLabel z:2];
    
    // Add instruction
    CCLabelTTF *instructLabel = [CCLabelTTF labelWithString:@"Choose an Option" fontName:@"HelveticaNeue-Light" fontSize:24 dimensions:CGSizeMake(self.boundingBox.size.width, 30)];
    [instructLabel setAnchorPoint:ccp(0.5f, 0.0f)];
    instructLabel.horizontalAlignment = CCTextAlignmentCenter;
    [instructLabel setColor:[CCColor blackColor]];
    [instructLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.1f)];
    [self addChild:instructLabel z:2];
    
    // Calculate Button Positions
    float baseY = titleLabel.position.y;
    float dy = (titleLabel.position.y-instructLabel.position.y)/2;
    
    
    // Add log button
    FadeButton *myLogs = [[FadeButton alloc] initWithLabel:@"My Logs" size:CGSizeMake(aSize.width-2, 50) color:[CCColor colorWithRed:0.84 green:0.84f blue:0.84f alpha:0.4f] fadeColor:[CCColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:0.4f]];
    [myLogs setTarget:self selector:@selector(myLogsPressed)];
    [myLogs setAnchorPoint:ccp(0.5f, 0.0f)];
    [myLogs setPosition:ccp(aSize.width/2, baseY-dy)];
    [self addChild:myLogs z:4];
    
    // Add calculator button
    FadeButton *calculator = [[FadeButton alloc] initWithLabel:@"Calculator" size:CGSizeMake(aSize.width-2, 50) color:[CCColor colorWithRed:0.78f green:0.78f blue:0.78f alpha:0.4f] fadeColor:[CCColor colorWithRed:0.68f green:0.68f blue:0.68f alpha:0.4f]];
    [calculator setTarget:self selector:@selector(calculatorPressed)];
    [calculator setAnchorPoint:ccp(0.5f, 1.0f)];
    [calculator setPosition:ccp(aSize.width/2, baseY-dy)];
    [self addChild:calculator z:4];
    
    return self;
}

// Triggered by the My Logs button
-(void)myLogsPressed {
    if (((CCLayer*)self.parent).active == YES) {
        [self.parent.parent performSelector:@selector(refreshMyLogs)];
        [self.parent.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMyLogsScreen]];
        
    }
}

// Triggered by the Calculator button
-(void)calculatorPressed {
    if (((CCLayer*)self.parent).active == YES) {
        [self.parent.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kCalculatorScreen]];
        
    }
}

@end
