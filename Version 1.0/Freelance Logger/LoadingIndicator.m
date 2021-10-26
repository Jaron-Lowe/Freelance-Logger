//
//  LoadingIndicator.m
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator

-(id)initWithRadius:(float)aRadius duration:(float)aDuration segments:(int)aSegments width:(float)aWidth color:(CCColor*)aColor speed:(float)aSpeed {
    self = [super init];
    if (!self) return(nil);
    
    t = 360;
    radius = aRadius;
    duration = aDuration;
    segments = aSegments;
    width = aWidth;
    speed = aSpeed;
    
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:CGSizeMake(radius*2, radius*2)];
    origin = ccp(radius, radius);
    
    streak = [CCMotionStreak streakWithFade:aDuration minSeg:aSegments width:aWidth color:aColor texture:[CCTexture textureWithFile:@"Circle.png"]];
    [self addChild:streak];
    
    return self;
}

-(void)update:(CCTime)delta {
    t -= speed*(1.0f/60.0f);
    if (t < 360) {t = t+360;}
    
    streak.position = ccp(origin.x+radius*cos(t), origin.y+radius*sin(t));
}

@end
