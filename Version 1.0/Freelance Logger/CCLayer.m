//
//  CCLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@implementation CCLayer

@synthesize active;

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    [self deactivate];
    size = [[CCDirector sharedDirector] viewSize];
    [self setContentSize:size];
    
    return self;
}

// DEBUG print available system fonts
-(void)printFontNames {
    for (NSString* family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {NSLog(@"  %@", name);}
    }
}

#pragma mark - Target Action Handling
// ======================================================================
// * Target Action Handling
// ======================================================================

// Sets the action to run when pressed
-(void)setTarget:(id)target selector:(SEL)selector {
    __unsafe_unretained id weakTarget = target; // avoid retain cycle
    [self setBlock:^(id sender) {
        objc_msgSend(weakTarget, selector, sender);
	}];
}

// Calls the action given to the button
-(void)triggerAction {
    if (_block) {_block(self);}
}


-(void)activate {
    self.active = YES;
    [self setUserInteractionEnabled:YES];
    for (CCNode *child in self.children) {
        [child setUserInteractionEnabled:YES];
    }
}
-(void)deactivate {
    self.active = NO;
    [self setUserInteractionEnabled:NO];
    for (CCNode *child in self.children) {
        [child setUserInteractionEnabled:NO];
    }
}

-(void)drawCornersWithColor:(CCColor*)aColor {
    
    CCDrawNode *leftMid = [CCDrawNode node];
    [leftMid drawDot:ccp(0, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:leftMid z:4];
    
    CCDrawNode *midMid = [CCDrawNode node];
    [midMid drawDot:ccp(self.contentSize.width/2, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:midMid z:4];
    
    CCDrawNode *rightMid = [CCDrawNode node];
    [rightMid drawDot:ccp(self.contentSize.width, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:rightMid z:4];
    
    CCDrawNode *botLeft = [CCDrawNode node];
    [botLeft drawDot:ccp(0, 0) radius:5 color:aColor];
    [self addChild:botLeft z:4];
    
    CCDrawNode *botMid = [CCDrawNode node];
    [botMid drawDot:ccp(self.contentSize.width/2, 0) radius:5 color:aColor];
    [self addChild:botMid z:4];
    
    CCDrawNode *botRight = [CCDrawNode node];
    [botRight drawDot:ccp(self.contentSize.width, 0) radius:5 color:aColor];
    [self addChild:botRight z:4];
    
    CCDrawNode *topLeft = [CCDrawNode node];
    [topLeft drawDot:ccp(0, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topLeft z:4];
    
    CCDrawNode *topMid = [CCDrawNode node];
    [topMid drawDot:ccp(self.contentSize.width/2, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topMid z:4];
    
    CCDrawNode *topRight = [CCDrawNode node];
    [topRight drawDot:ccp(self.contentSize.width, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topRight z:4];
}

@end
