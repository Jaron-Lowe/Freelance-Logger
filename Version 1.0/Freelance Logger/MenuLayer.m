//
//  MenuLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MenuLayer.h"
#import "MenuBox.h"
#import "FadeButton.h"

@implementation MenuLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    // Create menu box
    MenuBox *box = [[MenuBox alloc] initWithSize:CGSizeMake(size.width*0.8f, size.height*0.5f)];
    [box setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:box z:1];
    
    // Enable user input
    [self setUserInteractionEnabled:YES];
    
    return self;
}

/*
-(void)goToLoading {
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kLoadingScreen]];
}


-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.active == YES) {[self goToLoading];}
}
*/

@end
