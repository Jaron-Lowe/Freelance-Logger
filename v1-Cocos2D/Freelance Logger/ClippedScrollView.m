//
//  ClippedScrollView.m
//
//  Created by Jaron on 3/13/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "ClippedScrollView.h"

@implementation ClippedScrollView

-(id)initWithSize:(CGSize)aSize contentNode:(CCNode*)aContentNode {
    self = [super init];
    if (!self) return(nil);
    
    // Init variables   
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    
    // Create and add a scrollview to be clipped
    CCScrollView *scrollNode = [[CCScrollView alloc] initWithContentNode:aContentNode];
    [scrollNode setHorizontalScrollEnabled:NO];
    [scrollNode setPagingEnabled:NO];
    [self addChild:scrollNode z:1 name:@"scroll"];
    
    //[self drawCornersWithColor:[CCColor blueColor]];
    
    // Enable touches
    [self setUserInteractionEnabled:YES];
    
    return self;
}

// Changes the content node of the scroll view
-(void)replaceContentNode:(CCNode*)aContentNode {
    CCScrollView *scrollNode = (CCScrollView*)[self getChildByName:@"scroll" recursively:NO];
    [scrollNode setContentNode:aContentNode];
}

// Clip the node based on it's content size
-(void)visit:(CCRenderer *)renderer parentTransform:(const GLKMatrix4 *)parentTransform {
    
    // Calculate world positions and get contentScaleFactor
    CGPoint worldPosition = [self convertToWorldSpace:CGPointZero];
    CGFloat s = [[CCDirector sharedDirector] contentScaleFactor];
    
    // Enable scissor test and clip by content size
    [renderer enqueueBlock:^{
        glEnable(GL_SCISSOR_TEST);
        glScissor((worldPosition.x*s), (worldPosition.y*s),(self.contentSizeInPoints.width*s), (self.contentSizeInPoints.height*s));
    } globalSortOrder:0 debugLabel:nil threadSafe:YES];
    
    // Call parents visit
    [super visit:renderer parentTransform:parentTransform];
    
    // Disable scissor test
    [renderer enqueueBlock:^{
        glDisable(GL_SCISSOR_TEST);
    } globalSortOrder:0 debugLabel:nil threadSafe:YES];
}

-(void)drawCornersWithColor:(CCColor*)aColor {
    
    CCDrawNode *leftMid = [CCDrawNode node];
    [leftMid drawDot:ccp(0, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:leftMid z:4];
    
    CCDrawNode *midMid = [CCDrawNode node];
    [midMid drawDot:ccp(self.contentSize.width/2, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:midMid z:4];
    
    CCDrawNode *rightMid = [CCDrawNode node];
    [rightMid drawDot:ccp(self.contentSize.width, self.contentSize.height/2) radius:5 color:aColor];
    [self addChild:rightMid z:4];
    
    CCDrawNode *botLeft = [CCDrawNode node];
    [botLeft drawDot:ccp(0, 0) radius:5 color:aColor];
    [self addChild:botLeft z:4];
    
    CCDrawNode *botMid = [CCDrawNode node];
    [botMid drawDot:ccp(self.contentSize.width/2, 0) radius:5 color:aColor];
    [self addChild:botMid z:4];
    
    CCDrawNode *botRight = [CCDrawNode node];
    [botRight drawDot:ccp(self.contentSize.width, 0) radius:5 color:aColor];
    [self addChild:botRight z:4];
    
    CCDrawNode *topLeft = [CCDrawNode node];
    [topLeft drawDot:ccp(0, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topLeft z:4];
    
    CCDrawNode *topMid = [CCDrawNode node];
    [topMid drawDot:ccp(self.contentSize.width/2, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topMid z:4];
    
    CCDrawNode *topRight = [CCDrawNode node];
    [topRight drawDot:ccp(self.contentSize.width, self.contentSize.height) radius:5 color:aColor];
    [self addChild:topRight z:4];
}

@end
