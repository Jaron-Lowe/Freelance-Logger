//
//  MyLogsBox.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MyLogsBox.h"
#import "ClippedScrollView.h"
#import "MyLogEntry.h"
#import "FadeButton.h"

@implementation MyLogsBox

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set Properties
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    size = aSize;
    
    // Draw border box
    CGPoint verts[4] = {ccp(0, 0), ccp(aSize.width, 0), ccp(aSize.width, aSize.height), ccp(0, aSize.height)};
    CCDrawNode *box = [CCDrawNode node];
    [box drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0.92f green:0.96f blue:0.95f alpha:0.9f] borderWidth:1 borderColor:kBoxBorderColor];
    [self addChild:box z:1 name:@"box"];
    
    // Add title label
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"My Logs" fontName:@"HelveticaNeue-Light" fontSize:42];
    [titleLabel setColor:[CCColor blackColor]];
    [titleLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.9f)];
    [self addChild:titleLabel z:2];
    
    // Create add entry button
    FadeButton *addEntryButton = [[FadeButton alloc] initWithLabel:@"Add Entry" size:CGSizeMake(aSize.width, 40) color:kBoxBorderColor fadeColor:[CCColor colorWithRed:kBoxBorderColor.red-0.2f green:kBoxBorderColor.green-0.2f blue:kBoxBorderColor.blue-0.2f]];
    [addEntryButton setAnchorPoint:ccp(0.5f, 0.0f)];
    [addEntryButton setPosition:ccp(aSize.width/2, titleLabel.position.y-titleLabel.boundingBox.size.height/2-45)];
    [addEntryButton setLabelColor:[CCColor whiteColor]];
    [addEntryButton setLabelFontSize:14];
    [addEntryButton setTarget:self selector:@selector(addEntryPressed)];
    [self addChild:addEntryButton z:2];
    
    // Add scroll view with logs
    ClippedScrollView *scroll = [[ClippedScrollView alloc] initWithSize:CGSizeMake(aSize.width-2, addEntryButton.position.y) contentNode:nil];
    [scroll setAnchorPoint:ccp(0.5f, 1.0f)];
    [scroll setPosition:ccp(aSize.width/2, addEntryButton.position.y)];
    [self addChild:scroll z:3 name:@"scroll"];
    
    
    return self;
}

// Generate container content
-(void)refreshData {
    
    NSDictionary *data = [[AppManager sharedAppManager] getData];
    NSArray *logs = [data objectForKey:@"Logs"];
    int count = (int)[logs count];
    
    // Create container node
    CCNode *container = [CCNode node];
    [container setAnchorPoint:ccp(0.5f, 1.0f)];
    [container setContentSize:CGSizeMake(size.width-2, 50*count)];
    
    // Clear scroll view content
    ClippedScrollView *scrollView = (ClippedScrollView*)[self getChildByName:@"scroll" recursively:NO];
    [scrollView replaceContentNode:nil];
    
    for (int i=0; i<count; i++) {
        
        NSDictionary *log = [logs objectAtIndex:i];
        
        MyLogEntry *entry = [[MyLogEntry alloc] initWithSize:CGSizeMake(container.contentSize.width, 50) index:i data:log container:self];
        [entry setTarget:self selector:@selector(entryPressed)];
        [entry setPosition:ccp(container.boundingBox.size.width/2, container.boundingBox.size.height-(50*i))];
        [container addChild:entry z:1];
        
    }
    
    // Add content to scroll view
    [scrollView replaceContentNode:container];
    
}

// Triggered when add entry button is pressed
-(void)addEntryPressed {
    [self triggerAction];
}

// Triggered when an entry is pressed
-(void)entryPressed {
    
    // Use global index to fix iPhone 5s - sender issue
    int index = [AppManager sharedAppManager].indexPressed;
    
    if (((CCLayer*)self.parent).active == YES) {
        [self.parent.parent performSelector:@selector(refreshLogTracker:) withObject:[NSNumber numberWithInt:index]];
        [self.parent.parent performSelector:@selector(switchScreen:) withObject:[NSNumber numberWithInt:kLogTrackerScreen]];
        
    }
    
    
}



@end
