//
//  BackLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "BackLayer.h"

@implementation BackLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    // Add background
    CCSprite *back = [CCSprite spriteWithImageNamed:@"Background.png"];
    [back setAnchorPoint:ccp(0.0f, 0.0f)];
    [self addChild:back z:-1];
    
    circleOrigins[0] = ccp(size.width*0.15f, size.height*0.8f);
    circleOrigins[1] = ccp(size.width*0.8f, size.height*0.45f);
    circleOrigins[2] = ccp(size.width*0.25f, size.height*0.55f);
    circleOrigins[3] = ccp(size.width*0.45f, size.height*0.65f);
    circleOrigins[4] = ccp(size.width, size.height);
    for (int i=1; i<=5; i++) {[self createBubbleWithIndex:i];}
    
    return self;
}

-(void)createBubbleWithIndex:(int)aIndex {
    
    CCSprite *circle = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"Circle_%d.png", aIndex]];
    [circle setPosition:circleOrigins[aIndex-1]];
    [self addChild:circle z:aIndex];
    
    int xDir = 1;
    int yDir = 1;
    if (arc4random()%100 > 50) {xDir*=-1;}
    if (arc4random()%100 > 50) {yDir*=-1;}
    int speedVariance = arc4random()%8;
    
    int distance = 25;
    [circle runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:
        [CCActionEaseInOut actionWithAction:[CCActionMoveBy actionWithDuration:10.0f-speedVariance position:ccp(distance*xDir, distance*yDir)] rate:2.0f],
        [CCActionDelay actionWithDuration:1.0f],
        [CCActionEaseInOut actionWithAction:[CCActionMoveBy actionWithDuration:10.0f-speedVariance position:ccp(distance*xDir, distance*-yDir)] rate:2.0f],
        [CCActionDelay actionWithDuration:1.0f],
        [CCActionEaseInOut actionWithAction:[CCActionMoveBy actionWithDuration:10.0f-speedVariance position:ccp(distance*-xDir, distance*-yDir)] rate:2.0f],
        [CCActionDelay actionWithDuration:1.0f],
        [CCActionEaseInOut actionWithAction:[CCActionMoveBy actionWithDuration:10.0f-speedVariance position:ccp(distance*-xDir, distance*yDir)] rate:2.0f],
        [CCActionDelay actionWithDuration:1.0f],
                                                               nil]]];
    
    [circle runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:
        [CCActionDelay actionWithDuration:speedVariance],
        [CCActionEaseInOut actionWithAction:[CCActionScaleTo actionWithDuration:10.0f-speedVariance scale:1.1f] rate:2.0f],
        [CCActionDelay actionWithDuration:0.75f],
        [CCActionEaseInOut actionWithAction:[CCActionScaleTo actionWithDuration:10.0f-speedVariance scale:0.8f] rate:2.0f],
                                                               nil]]];
    
}





@end
