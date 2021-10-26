//
//  LoginButton.h
//  Freelance Logger
//
//  Created by Jaron on 2/5/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface FadeButton : CCNode {
    
    int fontSize;
    NSString *label;
    CCColor *normalColor;
    CCColor *darkColor;
    
}

@property (nonatomic,copy) void(^block)(id sender);

-(id)initWithLabel:(NSString*)aLabel size:(CGSize)aSize color:(CCColor*)aColor fadeColor:(CCColor*)aFadeColor;
-(void)setTarget:(id)target selector:(SEL)selector;
-(void)setLabelString:(NSString*)aString;
-(void)setLabelColor:(CCColor*)aColor;
-(void)setLabelFontSize:(float)aSize;
@end
