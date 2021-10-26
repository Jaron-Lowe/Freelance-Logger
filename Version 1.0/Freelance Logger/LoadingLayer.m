//
//  LoadingLayer.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LoadingLayer.h"
#import "LoadingBox.h"


@implementation LoadingLayer

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    // Create loading box
    LoadingBox *box = [[LoadingBox alloc] initWithSize:CGSizeMake(size.width*0.7f, size.height*0.25f)];
    [box setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:box z:1];
    
    // Enable user input
    [self setUserInteractionEnabled:YES];
    
    return self;
}

-(void)activate {
    [super activate];
    [self runAction:[CCActionSequence actions:
                     [CCActionDelay actionWithDuration:1.5f],
                     [CCActionCallFunc actionWithTarget:self selector:@selector(goToMainMenu)],
                     nil]];
}

-(void)goToMainMenu {
    [self.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kMainMenu]];
}

@end

