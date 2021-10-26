//
//  AddProjectBox.m
//  Freelance Logger
//
//  Created by Jaron on 7/11/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "AddProjectBox.h"
#import "FadeButton.h"

@implementation AddProjectBox

-(id)initWithSize:(CGSize)aSize {
    self = [super init];
    if (!self) return(nil);
    
    // Set Properties
    [self setAnchorPoint:ccp(0.5f, 0.5f)];
    [self setContentSize:aSize];
    writingData = NO;
    size = aSize;
    
    // Draw border box
    CGPoint verts[4] = {ccp(0, 0), ccp(aSize.width, 0), ccp(aSize.width, aSize.height), ccp(0, aSize.height)};
    CCDrawNode *box = [CCDrawNode node];
    [box drawPolyWithVerts:verts count:4 fillColor:[CCColor colorWithRed:0.92f green:0.96f blue:0.95f alpha:0.9f] borderWidth:1 borderColor:kBoxBorderColor];
    [self addChild:box z:1 name:@"box"];
    
    // Add title label
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"New Project" fontName:@"HelveticaNeue-Light" fontSize:42];
    [titleLabel setColor:[CCColor blackColor]];
    [titleLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.9f)];
    [self addChild:titleLabel z:2];
    
    // Add name label
    CCLabelTTF *nameLabel = [CCLabelTTF labelWithString:@"Project Name:" fontName:@"HelveticaNeue-Light" fontSize:20 dimensions:CGSizeMake(aSize.width*0.8f, 30)];
    nameLabel.horizontalAlignment = CCTextAlignmentLeft;
    [nameLabel setColor:[CCColor blackColor]];
    [nameLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.7f)];
    [self addChild:nameLabel z:2];
    
    // Add name text field
    nameField = [CCTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"TextField.png"]];
    [nameField setPreferredSize:CGSizeMake(aSize.width*0.8f, 40)];
    nameField.padding = 8;
    nameField.fontSize = 16;
    [nameField setAnchorPoint:ccp(0.5f, 0.5f)];
    [nameField setPosition:ccp(aSize.width/2, nameLabel.position.y-38)];
    [nameField setTarget:self selector:@selector(enterPressed:)];
    [self addChild:nameField z:2];
    
    // Add price label
    CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:@"Project Price:" fontName:@"HelveticaNeue-Light" fontSize:20 dimensions:CGSizeMake(aSize.width*0.8f, 30)];
    priceLabel.horizontalAlignment = CCTextAlignmentLeft;
    [priceLabel setColor:[CCColor blackColor]];
    [priceLabel setPosition:ccp(self.boundingBox.size.width/2, nameField.position.y-45)];
    [self addChild:priceLabel z:2];
    
    // Add time text field
    priceField = [CCTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"TextField.png"]];
    [priceField setPreferredSize:CGSizeMake(aSize.width*0.8f, 40)];
    priceField.padding = 8;
    priceField.fontSize = 16;
    [priceField setAnchorPoint:ccp(0.5f, 0.5f)];
    [priceField setPosition:ccp(aSize.width/2, priceLabel.position.y-38)];
    [priceField setTarget:self selector:@selector(enterPressed:)];
    [self addChild:priceField z:2];
    
    // Create finish button
    FadeButton *finishButton = [[FadeButton alloc] initWithLabel:@"Finish" size:CGSizeMake(aSize.width, 40) color:kBoxBorderColor fadeColor:[CCColor colorWithRed:kBoxBorderColor.red-0.2f green:kBoxBorderColor.green-0.2f blue:kBoxBorderColor.blue-0.2f]];
    [finishButton setAnchorPoint:ccp(0.5f, 0.0f)];
    [finishButton setPosition:ccp(aSize.width/2, 0)];
    [finishButton setLabelColor:[CCColor whiteColor]];
    [finishButton setLabelFontSize:16];
    [finishButton setTarget:self selector:@selector(finishButtonPressed)];
    [self addChild:finishButton z:2];
    
    
    return self;
}

// Override activate
-(void)activate {
    [super activate];
    nameField.enabled = YES;
    priceField.enabled = YES;
    writingData = NO;
}

// Triggered when the finish button is pressed
-(void)finishButtonPressed {
    if (writingData == NO) {
        writingData = YES;
        
        nameField.enabled = NO;
        priceField.enabled = NO;
        
        if ([self validateFields] == YES) {
            NSDictionary *log = [self createProjectLog];
            
            NSMutableDictionary *saveData = [[AppManager sharedAppManager] getData];
            NSMutableArray *logData = [saveData objectForKey:@"Logs"];
            [logData addObject:log];
            [saveData setValue:logData forKeyPath:@"Logs"];
            [[AppManager sharedAppManager] saveDataFile:saveData];
            
            [self triggerAction];
            
        } else {
            nameField.enabled = YES;
            priceField.enabled = YES;
            writingData = NO;
        }
        
        
        
    }
}

// Check that all text fields have valid input
-(BOOL)validateFields {
    BOOL titleValid = YES;
    BOOL priceValid = YES;
    
    // Check name field
    if (nameField.string == nil || [nameField.string isEqualToString:@""]) {
        titleValid = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your project must have a valid name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    // Get inputs
    double priceVal = [priceField.string doubleValue];
    
    // Validate inputs
    if (priceVal == 0.0) {
        priceValid = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must enter a valid price number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

// Creates a new project log with the values in the input fields
-(NSMutableDictionary*)createProjectLog {
    
    // Create empty log
    NSMutableDictionary *log = [NSMutableDictionary dictionary];
    
    // Create empty segments array
    NSArray *segments = [NSArray array];
    
    // Get title string
    NSString *title = nameField.string;
    
    // Get price value
    NSNumber *price = [NSNumber numberWithDouble:[priceField.string doubleValue]];
    
    // Get current date string
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    int year = (int)[components year];
    int month = (int)[components month];
    int day = (int)[components day];
    NSString *dateString = [NSString stringWithFormat:@"%d/%d/%d", month, day, year];
    
    // Construct log
    [log setValue:title forKeyPath:@"Title"];
    [log setValue:price forKeyPath:@"Price"];
    [log setValue:dateString forKeyPath:@"StartDate"];
    [log setValue:segments forKeyPath:@"Segments"];
    
    return log;
    
}

// Triggered when a text field becomes inactive
-(void)enterPressed:(id)sender {

    // Get inputs
    double priceVal = [priceField.string doubleValue];
    
    // Validate inputs
    if (priceVal != 0.0) {[priceField setString:[NSString stringWithFormat:@"%.2f", priceVal]];}
}

// Resets the UI values
-(void)resetUI {
    nameField.string = @"";
    priceField.string = @"";
}

@end
