//
//  LoadingBox.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LoadingBox.h"
#import "LoadingIndicator.h"

@implementation LoadingBox

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set Properties
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    
    // Draw border box
    CGPoint verts[4] = {ccp(0, 0), ccp(aSize.width, 0), ccp(aSize.width, aSize.height), ccp(0, aSize.height)};
    CCDrawNode *box = [CCDrawNode node];
    [box drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0.92f green:0.96f blue:0.95f alpha:0.9f] borderWidth:1 borderColor:kBoxBorderColor];
    [self addChild:box z:1 name:@"box"];
    
    // Add title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Loading" fontName:@"HelveticaNeue-Light" fontSize:42];
    [titleLabel setColor:[CCColor blackColor]];
    [titleLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.75f)];
    [self addChild:titleLabel z:2];
    
    
    // Add loading indicator
    LoadingIndicator *loader = [[LoadingIndicator alloc] initWithRadius:18 duration:0.3f segments:3 width:5 color:[CCColor colorWithRed:0.88f green:0.0f blue:1.0f] speed:15.0f];
    [loader setPosition:ccp(aSize.width/2, aSize.height*0.3f)];
    [self addChild:loader z:2];
    
    
    
    return self;
}

@end
