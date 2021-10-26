//
//  MyLogEntry.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MyLogEntry.h"
#import "XButton.h"

@implementation MyLogEntry

@synthesize index;

-(id)initWithSize:(CGSize)aSize index:(int)aIndex data:(NSDictionary*)aData container:(CCNode*)aContainer; {
    self = [super init];
    if (!self) return(nil);
    
    // Init variables
    index = aIndex;
    container = aContainer;
    [self setContentSize:aSize];
    [self setAnchorPoint:ccp(0.5f, 1.0f)];
    [self setUserInteractionEnabled:YES];
    
    // Get entry data
    NSString *title = [aData objectForKey:@"Title"];
    NSString *date = [aData objectForKey:@"StartDate"];
    
    // Determine back color
    CCColor *color;
    if (aIndex%2 == 0) {color = [CCColor colorWithRed:0.84f green:0.88f blue:0.91f alpha:0.9f];}
    else {color = [CCColor colorWithRed:0.88f green:0.92f blue:0.91f alpha:0.9f];}
    
    // Create back
    CCNodeColor *back = [CCNodeColor nodeWithColor:color];
    [back setContentSize:aSize];
    [back setAnchorPoint:ccp(0.0f, 0.0f)];
    [back setPosition:ccp(0,0)];
    [self addChild:back z:1];
    
    // Create and add title label
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:title fontName:@"HelveticaNeue" fontSize:18 dimensions:CGSizeMake(aSize.width*0.8f, 24)];
    [titleLabel setAnchorPoint:ccp(0.0f, 1.0f)];
    [titleLabel setPosition:ccp(5, self.boundingBox.size.height*0.9f)];
    [titleLabel setFontColor:[CCColor blackColor]];
    [self addChild:titleLabel z:2];
    
    // Create and add date label
    CCLabelTTF *dateLabel = [CCLabelTTF labelWithString:date fontName:@"HelveticaNeue" fontSize:14 dimensions:CGSizeMake(aSize.width*0.8f, 24)];
    [dateLabel setAnchorPoint:ccp(0.0f, 1.0f)];
    [dateLabel setPosition:ccp(titleLabel.position.x, titleLabel.position.y-titleLabel.boundingBox.size.height-1)];
    [dateLabel setFontColor:[CCColor blackColor]];
    [self addChild:dateLabel z:2];
    
    // Create and add X button
    XButton *xButton = [[XButton alloc] init];
    [xButton setPosition:ccp(self.boundingBox.size.width-5-xButton.boundingBox.size.width/2, self.boundingBox.size.height/2)];
    [xButton setTarget:self selector:@selector(XButtonPressed)];
    [self addChild:xButton z:4 name:@"xbutton"];
    
    //[self drawCornersWithColor:[CCColor greenColor]];
    
    return self;
}

// Triggered when the X button is pressed
-(void)XButtonPressed {
    [AppManager sharedAppManager].uiWaiting = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Log?" message:@"Are you sure you want to delete this log? This is a permanent action." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // Get the converted touch location
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint screenLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self.parent convertToNodeSpace:screenLocation];

    XButton *xButton = (XButton*)[self getChildByName:@"xbutton" recursively:NO];
    
    if (![xButton hitTestWithWorldPos:screenLocation]) {
        if ([self hitTestWithWorldPos:screenLocation] && [AppManager sharedAppManager].uiWaiting == NO) {
            [AppManager sharedAppManager].indexPressed = index;
            [self triggerAction];
        }
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex == buttonIndex) {
        [AppManager sharedAppManager].uiWaiting = NO;
        return;
    } else {
        NSMutableDictionary *data = [[AppManager sharedAppManager] getData];
        NSMutableArray *logs = [data objectForKey:@"Logs"];
        [logs removeObjectAtIndex:index];
        [data setValue:logs forKey:@"Logs"];
        [[AppManager sharedAppManager] saveDataFile:data];
        [((MyLogsBox*)container) refreshData];
        [AppManager sharedAppManager].uiWaiting = NO;
    }
    
}

@end
