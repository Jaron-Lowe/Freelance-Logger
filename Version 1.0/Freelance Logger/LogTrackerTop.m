//
//  LogTrackerBox.m
//  Freelance Logger
//
//  Created by Jaron on 7/16/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "LogTrackerTop.h"
#import "LogTrackerBox.h"
#import "FadeButton.h"

@implementation LogTrackerTop

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Initialize variables
    index = 0;
    segmentSeconds = 0;
    price = 0;
    currentStartTime = 0;
    currentState = kLogStateStopped;
    title = [NSString string];
    
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
    [titleBox setContentSize:CGSizeMake(aSize.width, aSize.height*0.25f)];
    [titleBox setAnchorPoint:ccp(0.5f, 1.0f)];
    [titleBox setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height)];
    [self addChild:titleBox z:2];
    
    // Add title text field
    titleField = [CCTextField textFieldWithSpriteFrame:nil];
    titleField.textField.text = @"";
    titleField.textField.textAlignment = NSTextAlignmentCenter;
    titleField.textField.textColor = [UIColor whiteColor];
    [titleField setEnabled:YES];
    [titleField setPreferredSize:CGSizeMake(titleBox.contentSize.width*0.9f, titleBox.contentSize.height)];
    titleField.padding = 0;
    titleField.fontSize = 24;
    [titleField setAnchorPoint:ccp(0.5f, 1.0f)];
    [titleField setPosition:titleBox.position];
    [titleField setTarget:self selector:@selector(titleFieldDone:)];
    [self addChild:titleField z:3 name:@"title"];
    
    //========================================================================
    // Row 2
    //========================================================================
    
    // Add price text field
    priceField = [CCTextField textFieldWithSpriteFrame:nil];
    priceField.textField.text = @"$0";
    priceField.textField.textAlignment = NSTextAlignmentCenter;
    [priceField setPreferredSize:CGSizeMake(aSize.width*0.33f, aSize.height*0.25f)];
    priceField.padding = 8;
    priceField.fontSize = 18;
    [priceField setAnchorPoint:ccp(0.5f, 0.5f)];
    [priceField setPosition:ccp(self.boundingBox.size.width*(1.0f/3.0f)-(priceField.boundingBox.size.width/2), self.boundingBox.size.height*0.75f-(priceField.boundingBox.size.height/2))];
    [priceField setTarget:self selector:@selector(priceFieldDone:)];
    [self addChild:priceField z:2 name:@"price"];
    
    // Create and add vertical divider
    CCNodeColor *vDividerA = [CCNodeColor nodeWithColor:kBoxBorderColor];
    [vDividerA setContentSize:CGSizeMake(1, aSize.height*0.25f)];
    [vDividerA setAnchorPoint:ccp(0.5f, 1.0f)];
    [vDividerA setPosition:ccp(self.boundingBox.size.width*(1.0f/3.0f), self.boundingBox.size.height*0.75f)];
    [self addChild:vDividerA z:2];
    
    // Create and add hours field
    hoursField = [CCTextField textFieldWithSpriteFrame:nil];
    hoursField.textField.text = @"0 hr";
    hoursField.textField.adjustsFontSizeToFitWidth = YES;
    hoursField.textField.textAlignment = NSTextAlignmentCenter;
    [hoursField setPreferredSize:CGSizeMake(aSize.width*0.33f, aSize.height*0.25f)];
    hoursField.padding = 8;
    hoursField.fontSize = 18;
    [hoursField setEnabled:NO];
    [hoursField setAnchorPoint:ccp(0.5f, 0.5f)];
    [hoursField setPosition:ccp(self.boundingBox.size.width*(2.0f/3.0f)-(hoursField.boundingBox.size.width/2), self.boundingBox.size.height*0.75f-(hoursField.boundingBox.size.height/2))];
    [self addChild:hoursField z:2 name:@"hours"];
    
    // Create and add vertical divider
    CCNodeColor *vDividerB = [CCNodeColor nodeWithColor:kBoxBorderColor];
    [vDividerB setContentSize:CGSizeMake(1, aSize.height*0.25f)];
    [vDividerB setAnchorPoint:ccp(0.5f, 1.0f)];
    [vDividerB setPosition:ccp(self.boundingBox.size.width*(2.0f/3.0f), self.boundingBox.size.height*0.75f)];
    [self addChild:vDividerB z:2];
    
    // Create and add per hour field
    perHourField = [CCTextField textFieldWithSpriteFrame:nil];
    perHourField.textField.text = @"$0/hr";
    perHourField.textField.adjustsFontSizeToFitWidth = YES;
    perHourField.textField.textAlignment = NSTextAlignmentCenter;
    [perHourField setPreferredSize:CGSizeMake(aSize.width*0.33f, aSize.height*0.25f)];
    perHourField.padding = 8;
    perHourField.fontSize = 18;
    [perHourField setEnabled:NO];
    [perHourField setAnchorPoint:ccp(0.5f, 0.5f)];
    [perHourField setPosition:ccp(self.boundingBox.size.width-(perHourField.boundingBox.size.width/2), self.boundingBox.size.height*0.75f-(perHourField.boundingBox.size.height/2))];
    [self addChild:perHourField z:2 name:@"perhour"];
    
    //========================================================================
    //
    //========================================================================
    
    // Create and add horizontal divider
    CCNodeColor *hDivider = [CCNodeColor nodeWithColor:kBoxBorderColor];
    [hDivider setContentSize:CGSizeMake(aSize.width, 1)];
    [hDivider setPosition:ccp(0, self.boundingBox.size.height/2)];
    [self addChild:hDivider z:2];
    
    // Create and add timer label
    CCLabelTTF *timerLabel = [CCLabelTTF labelWithString:@"0 hr 0 min 0 sec" fontName:@"HelveticaNeue" fontSize:18 dimensions:CGSizeMake(aSize.width, aSize.height*0.25f)];
    [timerLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.5f-timerLabel.boundingBox.size.height/2)];
    [timerLabel setVerticalAlignment:CCVerticalTextAlignmentCenter];
    [timerLabel setHorizontalAlignment:CCTextAlignmentCenter];
    [timerLabel setColor:[CCColor blackColor]];
    [self addChild:timerLabel z:3 name:@"timer"];
    
    // Create and add toggle button
    FadeButton *toggleButton = [[FadeButton alloc] initWithLabel:@"Start" size:CGSizeMake(aSize.width, aSize.height*0.25f) color:kBoxBorderColor fadeColor:[CCColor colorWithRed:kBoxBorderColor.red-0.2f green:kBoxBorderColor.green-0.2f blue:kBoxBorderColor.blue-0.2f]];
    [toggleButton setAnchorPoint:ccp(0.5f, 0.0f)];
    [toggleButton setPosition:ccp(aSize.width/2, 0)];
    [toggleButton setLabelColor:[CCColor whiteColor]];
    [toggleButton setLabelFontSize:16];
    [toggleButton setTarget:self selector:@selector(toggleButtonPressed)];
    [self addChild:toggleButton z:2 name:@"toggle"];
    
    return self;
}


// ======================================================================
#pragma mark - UI Handling
// ======================================================================

// Triggered when the toggle button is pressed
-(void)toggleButtonPressed {
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTime = [currentDate timeIntervalSinceReferenceDate];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    int year = (int)[components year];
    int month = (int)[components month];
    int day = (int)[components day];
    NSString *dateString = [NSString stringWithFormat:@"%d/%d/%d", month, day, year];
    
    NSMutableDictionary *data = [[AppManager sharedAppManager] getData];
    NSMutableArray *logs = [data objectForKey:@"Logs"];
    if ([logs count] == 0) {return;}
    NSMutableDictionary *log = [logs objectAtIndex:index];
    NSMutableArray *segments = [log objectForKey:@"Segments"];
    NSMutableDictionary *segment;
    
    if (currentState == kLogStateRunning) {
        
        currentState = kLogStateStopping;
        
        // Add to segment
        int segmentIndex = (int)[segments count]-1;
        segment = [segments objectAtIndex:segmentIndex];
        NSTimeInterval startTime = [[segment objectForKey:@"StartTime"] doubleValue];
        [segment setValue:[NSNumber numberWithDouble:currentTime] forKey:@"EndTime"];
        [segment setValue:[NSNumber numberWithDouble:currentTime-startTime] forKey:@"TotalTime"];
        [segments replaceObjectAtIndex:segmentIndex withObject:segment];
        currentStartTime = 0;
        
    } else if (currentState == kLogStateStopped) {
        
        currentState = kLogStateStarting;
        
        // Create new segment
        segment = [NSMutableDictionary dictionary];
        [segment setValue:[NSNumber numberWithDouble:currentTime] forKey:@"StartTime"];
        [segment setValue:dateString forKeyPath:@"StartDate"];
        [segments addObject:segment];
        currentStartTime = currentTime;
    } else {return;}
    
    // Save segment data
    [log setValue:segments forKey:@"Segments"];
    [logs replaceObjectAtIndex:index withObject:log];
    [data setValue:logs forKey:@"Logs"];
    [[AppManager sharedAppManager] saveDataFile:data];
    
    if (currentState == kLogStateStopping) {
        currentState = kLogStateStopped;
        [self calculateSegmentTotalWithIndex:index];
        [((LogTrackerBox*)self.parent) refreshDataWithIndex:index];
    } else if (currentState == kLogStateStarting) {currentState = kLogStateRunning;}
    
    // Update labels and toggle button
    [self updateToggleButtonWithState:currentState];
    [self updateLabels];
}

// Called every frame
-(void)update:(CCTime)delta {
    if (currentState == kLogStateRunning) {
        [self updateLabels];
    }
}

// Updates the labels in the box
-(void)updateLabels {
    
    // Get children
    CCLabelTTF *timerLabel = (CCLabelTTF*)[self getChildByName:@"timer" recursively:NO];
    
    // Calculate label values
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentTime = [currentDate timeIntervalSinceReferenceDate];
    double totalTime = 0;
    double perHourValue = 0;
    double currentSegmentSeconds = 0;
    if (currentStartTime != 0) {
        currentSegmentSeconds = (currentTime-currentStartTime);
        totalTime = ((segmentSeconds+currentSegmentSeconds)/3600.0f);
    }
    else {totalTime = ((segmentSeconds)/3600.0f);}
    
    // Check for divide by zero
    perHourValue = price/totalTime;
    if (isnan(perHourValue) || isinf(perHourValue)) {perHourValue = 0;}
    
    // Change label values
    hoursField.textField.text = [NSString stringWithFormat:@"%.2f hr", totalTime];
    perHourField.textField.text = [NSString stringWithFormat:@"$%.2f/hr", perHourValue];
    [timerLabel setString:[self timeFormatted:(int)currentSegmentSeconds]];
}

// Changes the label of the toggle button based on state
-(void)updateToggleButtonWithState:(LogState)aState {
    FadeButton *toggleButton = (FadeButton*)[self getChildByName:@"toggle" recursively:NO];
    
    if (aState == kLogStateRunning) {[toggleButton setLabelString:@"Stop"];}
    else if (aState == kLogStateStopped) {[toggleButton setLabelString:@"Start"];}
    
}

// Converts seconds to string with hours, minutes, seconds
-(NSString*)timeFormatted:(int)aSeconds {
    int seconds = aSeconds % 60;
    int minutes = (aSeconds/60)%60;
    int hours = aSeconds/3600;
    return [NSString stringWithFormat:@"%d hr %d min %d sec", hours, minutes, seconds];
}


// ======================================================================
#pragma mark - Text Field Handling
// ======================================================================

// Triggered when the title text field has lost focus
-(void)titleFieldDone:(id)sender {
    
    if ([self validateTitleField] == YES) {
        title = titleField.string;
        [self saveTitleWithIndex:index];
    } else {titleField.string = title;}
    
}

// Triggered when the price text field has lost focus
-(void)priceFieldDone:(id)sender {
    // Get inputs
    NSString *priceValue = [priceField.string stringByReplacingOccurrencesOfString:@"$" withString:@""];
    double priceVal = [priceValue doubleValue];
    
    // Validate inputs
    if (priceVal != 0.0) {
        price = priceVal;
        [self savePriceWithIndex:index];
    }
    priceField.string = [NSString stringWithFormat:@"$%.2f", price];
    [self updateLabels];
}

// Check that all text fields have valid input
-(BOOL)validateTitleField {
    BOOL titleValid = YES;
    
    // Check name field
    if (titleField.string == nil || [titleField.string isEqualToString:@""]) {
        titleValid = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your project must have a valid name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    return titleValid;
}

// Save the title for a log by index
-(void)saveTitleWithIndex:(int)aIndex {
    NSMutableDictionary *data = [[AppManager sharedAppManager] getData];
    NSMutableArray *logs = [data objectForKey:@"Logs"];
    NSMutableDictionary *log = [logs objectAtIndex:aIndex];
    
    [log setValue:title forKey:@"Title"];
    [logs replaceObjectAtIndex:aIndex withObject:log];
    [data setValue:logs forKey:@"Logs"];
    [[AppManager sharedAppManager] saveDataFile:data];
}

// Save the price for a log by index
-(void)savePriceWithIndex:(int)aIndex {
    NSMutableDictionary *data = [[AppManager sharedAppManager] getData];
    NSMutableArray *logs = [data objectForKey:@"Logs"];
    NSMutableDictionary *log = [logs objectAtIndex:aIndex];
    
    [log setValue:[NSNumber numberWithDouble:price] forKey:@"Price"];
    [logs replaceObjectAtIndex:aIndex withObject:log];
    [data setValue:logs forKey:@"Logs"];
    [[AppManager sharedAppManager] saveDataFile:data];
    
}

// ======================================================================
#pragma mark - Log Data Handling
// ======================================================================

// Calculates the total time duration of all time segments
-(double)calculateSegmentTotalWithIndex:(int)aIndex {
    segmentSeconds = 0;
    
    NSDictionary *data = [[AppManager sharedAppManager] getData];
    NSArray *logs = [data objectForKey:@"Logs"];
    NSDictionary *log = [logs objectAtIndex:aIndex];
    NSArray *segments = [log objectForKey:@"Segments"];
    
    for (NSDictionary *segment in segments) {
        if ([segment objectForKey:@"TotalTime"] != nil) {
            double time = [[segment objectForKey:@"TotalTime"] doubleValue];
            segmentSeconds += time;
        }
    }
    return segmentSeconds;
}

// Refreshes the data used by the box
-(void)refreshDataWithIndex:(int)aIndex {
    index = -1;
    
    NSDictionary *data = [[AppManager sharedAppManager] getData];
    NSArray *logs = [data objectForKey:@"Logs"];
    if ([logs count] == 0) {return;}
    index = aIndex;
    NSDictionary *log = [logs objectAtIndex:aIndex];
    NSArray *segments = [log objectForKey:@"Segments"];
    
    segmentSeconds = 0;
    [self calculateSegmentTotalWithIndex:aIndex];
    
    // Determine if latest segment is still active
    currentState = kLogStateStopped;
    currentStartTime = 0;
    if ([segments count] != 0) {
        if ([[segments objectAtIndex:[segments count]-1] objectForKey:@"TotalTime"] == nil) {
            currentState = kLogStateRunning;
            currentStartTime = [[[segments objectAtIndex:[segments count]-1] objectForKey:@"StartTime"] doubleValue];
        }
    }
    
    // Update the toggle button
    [self updateToggleButtonWithState:currentState];
    
    // Get log values
    title = [log objectForKey:@"Title"];
    price = [[log objectForKey:@"Price"] doubleValue];
    
    // Update fields and labels
    titleField.textField.text = title;
    priceField.textField.text = [NSString stringWithFormat:@"$%.2f", price];
    
    // Update data labels
    [self updateLabels];
    
    
}


@end
