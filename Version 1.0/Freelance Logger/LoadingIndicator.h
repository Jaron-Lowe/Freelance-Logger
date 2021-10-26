//
//  LoadingIndicator.h
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCNode.h"

@interface LoadingIndicator : CCNode {
    
    
    float radius;
    float duration;
    int segments;
    float width;
    
    float t;
    float speed;
    
    CGPoint origin;
    
    CCMotionStreak *streak;
}

-(id)initWithRadius:(float)aRadius duration:(float)aDuration segments:(int)aSegments width:(float)aWidth color:(CCColor*)aColor speed:(float)aSpeed;

@end
