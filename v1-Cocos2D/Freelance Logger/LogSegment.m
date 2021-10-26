//
//  LogSegment.m
//  Freelance Logger
//
//  Created by Jaron on 7/17/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LogSegment.h"
#import "LogTrackerBox.h"
#import "XButton.h"

@implementation LogSegment

@synthesize index;

-(id)initWithSize:(CGSize)aSize index:(int)aIndex parentIndex:(int)aParIndex data:(NSDictionary*)aData container:(CCNode*)aContainer {
    self = [super init];
    if (!self) return(nil);
    
    // Init variables
    index = aIndex;
    parentIndex = aParIndex;
    container = aContainer;
    [self setContentSize:aSize];
    [self setAnchorPoint:ccp(0.5f, 1.0f)];
    [self setUserInteractionEnabled:YES];
    
    // Get entry data
    NSString *date = [aData objectForKey:@"StartDate"];
    double totalHours = [[aData objectForKey:@"TotalTime"] doubleValue]/3600.0f;
    
    // Get start and end time
    NSTimeInterval rawStartTime = [[aData objectForKey:@"StartTime"] doubleValue];
    NSTimeInterval rawEndTime = [[aData objectForKey:@"EndTime"] doubleValue];
    
    // Get start and end date objects
    NSDate *startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:rawStartTime];
    NSDate *endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:rawEndTime];
    
    // Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    // Get formatted start and end times
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
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
    
    // Create and add date label
    CCLabelTTF *dateLabel = [CCLabelTTF labelWithString:date fontName:@"HelveticaNeue" fontSize:18 dimensions:CGSizeMake(aSize.width*0.8f, 24)];
    [dateLabel setAnchorPoint:ccp(0.0f, 1.0f)];
    [dateLabel setPosition:ccp(5, self.boundingBox.size.height*0.9f)];
    [dateLabel setFontColor:[CCColor blackColor]];
    [self addChild:dateLabel z:2];
    
    // Create and add time label
    CCLabelTTF *timeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@-%@", startTime, endTime] fontName:@"HelveticaNeue" fontSize:14 dimensions:CGSizeMake(aSize.width*0.8f, 24)];
    [timeLabel setAnchorPoint:ccp(0.0f, 1.0f)];
    [timeLabel setPosition:ccp(dateLabel.position.x, dateLabel.position.y-dateLabel.boundingBox.size.height-1)];
    [timeLabel setFontColor:[CCColor blackColor]];
    [self addChild:timeLabel z:2];
    
    
    // Create and add X button
    XButton *xButton = [[XButton alloc] init];
    [xButton setPosition:ccp(self.boundingBox.size.width-5-xButton.boundingBox.size.width/2, self.boundingBox.size.height/2)];
    [xButton setTarget:self selector:@selector(XButtonPressed)];
    [self addChild:xButton z:4 name:@"xbutton"];
    
    // Create and add hours label
    CCLabelTTF *hoursLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.3f hr", totalHours] fontName:@"HelveticaNeue" fontSize:18];
    [hoursLabel setAnchorPoint:ccp(1.0f, 0.5f)];
    [hoursLabel setPosition:ccp(xButton.position.x-xButton.boundingBox.size.width/2-5, xButton.position.y)];
    [hoursLabel setFontColor:[CCColor blackColor]];
    [self addChild:hoursLabel z:3];
    
    return self;
}

// Triggered when the X button is pressed
-(void)XButtonPressed {
    [AppManager sharedAppManager].uiWaiting = YES;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Log?" message:@"Are you sure you want to delete this log? This is a permanent action." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alert show];
}

// Handles deletion of a segment
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex == buttonIndex) {
        [AppManager sharedAppManager].uiWaiting = NO;
        return;
    } else {
        NSMutableDictionary *data = [[AppManager sharedAppManager] getData];
        NSMutableArray *logs = [data objectForKey:@"Logs"];
        if ([logs count] <= parentIndex) {[AppManager sharedAppManager].uiWaiting = NO; return;}
        NSMutableDictionary *log = [logs objectAtIndex:parentIndex];
        NSMutableArray *segments = [log objectForKey:@"Segments"];
        [segments removeObjectAtIndex:index];
        [log setValue:segments forKey:@"Segments"];
        [logs replaceObjectAtIndex:parentIndex withObject:log];
        [data setValue:logs forKey:@"Logs"];
        [[AppManager sharedAppManager] saveDataFile:data];
        [self triggerAction];
        [AppManager sharedAppManager].uiWaiting = NO;
    }
    
}

@end
