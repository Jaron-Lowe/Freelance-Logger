//
//  XButton.m
//  Freelance Logger
//
//  Created by Jaron on 7/16/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "XButton.h"

@implementation XButton

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    CCSprite *image = [CCSprite spriteWithImageNamed:@"XButton.png"];
    [self addChild:image];
    
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:CGSizeMake(image.contentSize.width*2.5, image.contentSize.height*2.5)];
    [self setUserInteractionEnabled:YES];
    
    [image setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2)];
    
    return self;
}

#pragma mark - Touch Handling
// ======================================================================
// * Touch Handling
// ======================================================================

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self stopAllActions];
    [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:0.9f]];
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint screenLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    if ([self hitTestWithWorldPos:screenLocation]) {
        
        [self stopAllActions];
        [self runAction:[CCActionSequence actions:
                         [CCActionCallBlock actionWithBlock:^{[self triggerAction];}],
                         [CCActionScaleTo actionWithDuration:0.05f scale:1.1f],
                         [CCActionScaleTo actionWithDuration:0.1f scale:1.0f],
                         nil]];
    } else {
        [self stopAllActions];
        [self runAction:[CCActionScaleTo actionWithDuration:0.1f scale:1.0f]];
    }
}


@end
