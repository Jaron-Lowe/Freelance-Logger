//
//  LogTrackerBottom.m
//  Freelance Logger
//
//  Created by Jaron on 7/17/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LogTrackerBottom.h"
#import "LogTrackerBox.h"
#import "ClippedScrollView.h"
#import "LogSegment.h"

@implementation LogTrackerBottom

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set properties
    [self setAnchorPoint:ccp(0.5f, 1.0f)];
    [self setContentSize:aSize];
    size = aSize;
    
    // Draw border box
    CGPoint verts[4] = {ccp(0, 0), ccp(aSize.width, 0), ccp(aSize.width, aSize.height), ccp(0, aSize.height)};
    CCDrawNode *box = [CCDrawNode node];
    [box drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0.92f green:0.96f blue:0.95f alpha:0.9f] borderWidth:1 borderColor:kBoxBorderColor];
    [self addChild:box z:1 name:@"box"];
    
    // Create and add title box
    CCNodeColor *titleBox = [CCNodeColor nodeWithColor:kBoxBorderColor];
    [titleBox setContentSize:CGSizeMake(aSize.width, aSize.height*0.20f)];
    [titleBox setAnchorPoint:ccp(0.5f, 1.0f)];
    [titleBox setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height)];
    [self addChild:titleBox z:2];
    
    // Add title text field
    titleField = [CCTextField textFieldWithSpriteFrame:nil];
    titleField.textField.text = @"Time Logged";
    titleField.textField.textAlignment = NSTextAlignmentCenter;
    titleField.textField.textColor = [UIColor whiteColor];
    [titleField setEnabled:NO];
    [titleField setPreferredSize:CGSizeMake(titleBox.contentSize.width*0.9f, titleBox.contentSize.height)];
    titleField.padding = 0;
    titleField.fontSize = 20;
    [titleField setAnchorPoint:ccp(0.5f, 1.0f)];
    [titleField setPosition:titleBox.position];
    [self addChild:titleField z:3 name:@"title"];
    
    // Add scroll view with segments
    ClippedScrollView *scroll = [[ClippedScrollView alloc] initWithSize:CGSizeMake(aSize.width-2, titleBox.position.y-titleBox.boundingBox.size.height) contentNode:nil];
    [scroll setAnchorPoint:ccp(0.5f, 1.0f)];
    [scroll setPosition:ccp(aSize.width/2, titleBox.position.y-titleBox.boundingBox.size.height)];
    [self addChild:scroll z:2 name:@"scroll"];
    
    return self;
}

// ======================================================================
#pragma mark - Log Data Handling
// ======================================================================

// Refreshes that data of the log tracker
-(void)refreshDataWithIndex:(int)aIndex {
    
    index = aIndex;
    
    NSDictionary *data = [[AppManager sharedAppManager] getData];
    NSArray *logs = [data objectForKey:@"Logs"];
    NSDictionary *log = [logs objectAtIndex:aIndex];
    NSArray *segments = [log objectForKey:@"Segments"];
    int count = (int)[segments count];
    
    // Create container node
    CCNode *container = [CCNode node];
    [container setAnchorPoint:ccp(0.5f, 1.0f)];
    [container setContentSize:CGSizeMake(size.width-2, 50*count)];
    
    // Clear scroll view content
    ClippedScrollView *scrollView = (ClippedScrollView*)[self getChildByName:@"scroll" recursively:NO];
    [scrollView replaceContentNode:nil];
    
    // Create log segments
    for (int i=0; i<count; i++) {
        
        NSDictionary *segment = [segments objectAtIndex:i];
        if ([segment objectForKey:@"TotalTime"] == nil) {continue;}
        LogSegment *entry = [[LogSegment alloc] initWithSize:CGSizeMake(container.contentSize.width, 50) index:i parentIndex:index data:segment container:self];
        [entry setTarget:self selector:@selector(xButtonPressed)];
        [entry setPosition:ccp(container.boundingBox.size.width/2, container.boundingBox.size.height-(50*i))];
        [container addChild:entry z:1];
    }
    
    // Add content to scroll view
    [scrollView replaceContentNode:container];
    
}


// ======================================================================
#pragma mark - Button Callbacks
// ======================================================================

// Triggered when a log segment action is triggered
-(void)xButtonPressed {
    CCLOG(@"Index: %d", index);
    [((LogTrackerBox*)self.parent) refreshDataWithIndex:index];
}

@end
