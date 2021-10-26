//
//  CCLayer.h
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface CCLayer : CCNode {
    
    CGSize size;
    BOOL active;
}

@property (nonatomic, readwrite) BOOL active;
@property (nonatomic,copy) void(^block)(id sender);


-(void)printFontNames;
-(void)setTarget:(id)target selector:(SEL)selector;
-(void)triggerAction;
-(void)activate;
-(void)deactivate;
-(void)drawCornersWithColor:(CCColor*)aColor;


@end
