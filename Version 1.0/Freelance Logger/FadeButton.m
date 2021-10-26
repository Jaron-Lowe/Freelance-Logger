//
//  LoginButton.m
//  Freelance Logger
//
//  Created by Jaron on 2/5/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "FadeButton.h"

@implementation FadeButton

-(void)dealloc {
    normalColor = nil;
    darkColor = nil;
}

-(id)initWithLabel:(NSString*)aLabel size:(CGSize)aSize color:(CCColor*)aColor fadeColor:(CCColor*)aFadeColor {

    self = [super init];
    if (!self) return(nil);
    
    // Init variables
    label = aLabel;
    fontSize = 18;
    
    normalColor = aColor;
    darkColor = aFadeColor;
    
    // Set object properties
    [self setContentSize:aSize];
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    
    // Get the alpha
    float alpha = 0.9f;
    
    // Create the button back
    CCNodeColor *buttonBack = [CCNodeColor nodeWithColor:normalColor];
    [buttonBack setOpacity:alpha];
    [buttonBack setContentSize:aSize];
    [buttonBack setAnchorPoint:ccp(0.0f, 0.0f)];
    [self addChild:buttonBack z:0 name:@"back"];
    
    // Create button label
    CCLabelTTF *buttonLabel = [CCLabelTTF labelWithString:aLabel fontName:@"HelveticaNeue" fontSize:fontSize dimensions:aSize];
    buttonLabel.horizontalAlignment = CCTextAlignmentCenter;
    buttonLabel.verticalAlignment = CCVerticalTextAlignmentCenter;
    [buttonLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2)];
    [buttonLabel setFontColor:[CCColor blackColor]];
    [self addChild:buttonLabel z:1 name:@"label"];

    // Enable touches on the node
    [self setUserInteractionEnabled:YES];
    
    return self;
}

// Sets the label string
-(void)setLabelString:(NSString*)aString {
    [((CCLabelTTF*)[self getChildByName:@"label" recursively:NO]) setString:aString];
}

// Set the label color
-(void)setLabelColor:(CCColor*)aColor {
    [((CCLabelTTF*)[self getChildByName:@"label" recursively:NO]) setFontColor:aColor];
}

// Set the label font size
-(void)setLabelFontSize:(float)aSize {
    [((CCLabelTTF*)[self getChildByName:@"label" recursively:NO]) setFontSize:aSize];
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

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
        
    CCNode *buttonBack = [self getChildByName:@"back" recursively:NO];
    id tintDark = [CCActionTintTo actionWithDuration:0.0f color:darkColor];
        
    [buttonBack stopAllActions];
    [buttonBack runAction:tintDark];
    
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint screenLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
    id reTint = [CCActionTintTo actionWithDuration:0.3f color:normalColor];
    CCNode *buttonBack = [self getChildByName:@"back" recursively:NO];
    [buttonBack runAction:reTint];
    
    if ([self hitTestWithWorldPos:screenLocation]) {
        [self triggerAction];
    }
    
}

@end
