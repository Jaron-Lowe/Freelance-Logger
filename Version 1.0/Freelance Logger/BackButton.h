//
//  BackButton.h
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface BackButton : CCNode {
    
    int initialTouchLocation;
    
}

@property (nonatomic,copy) void(^block)(id sender);

-(void)setTarget:(id)target selector:(SEL)selector;

@end
