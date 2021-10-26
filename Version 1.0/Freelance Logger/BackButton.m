//
//  BackButton.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

-(id)init {
    self = [super init];
    if (!self) return(nil);
    

    CCSprite *image = [CCSprite spriteWithImageNamed:@"BackButton.png"];
    [image setAnchorPoint:ccp(0.0f, 0.0f)];
    [image setPosition:ccp(0,0)];
    [image setColor:kBoxBorderColor];
    [self addChild:image];
    
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:image.contentSize];
    [self setUserInteractionEnabled:YES];
    
    return self;
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

#pragma mark - Touch Handling
// ======================================================================
// * Touch Handling
// ======================================================================

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    initialTouchLocation = touchLocation.y;
    
    [self stopAllActions];
    [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:0.9f]];
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    
    // Cancel accepting touch
    if (abs(initialTouchLocation - touchLocation.y) > 10) {
        [self stopAllActions];
        [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:1.0f]];
        [super touchMoved:touch withEvent:event];
    }
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint screenLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    if ([self hitTestWithWorldPos:screenLocation]) {
        
        [self stopAllActions];
        [self runAction:[CCActionSequence actions:
                         [CCActionScaleTo actionWithDuration:0.05f scale:1.1f],
                         [CCActionScaleTo actionWithDuration:0.1f scale:1.0f],
                         [CCActionDelay actionWithDuration:0.09f],
                         [CCActionCallBlock actionWithBlock:^{[self triggerAction];}],
                         nil]];
    } else {
        [self stopAllActions];
        [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:1.0f]];
    }
    
    
}

-(void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [self stopAllActions];
    [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:1.0f]];
}


#pragma mark - DEBUG
// ======================================================================
// * DEBUG
// ======================================================================

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
