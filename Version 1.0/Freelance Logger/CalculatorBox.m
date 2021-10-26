//
//  CalculatorBox.m
//  Freelance Logger
//
//  Created by Jaron on 6/25/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CalculatorBox.h"

@implementation CalculatorBox

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
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Calculator" fontName:@"HelveticaNeue-Light" fontSize:42];
    [titleLabel setColor:[CCColor blackColor]];
    [titleLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.9f)];
    [self addChild:titleLabel z:2];
    
    // Add price label
    CCLabelTTF *priceLabel = [CCLabelTTF labelWithString:@"Contract Price:" fontName:@"HelveticaNeue-Light" fontSize:20 dimensions:CGSizeMake(aSize.width*0.8f, 30)];
    priceLabel.horizontalAlignment = CCTextAlignmentLeft;
    [priceLabel setColor:[CCColor blackColor]];
    [priceLabel setPosition:ccp(self.boundingBox.size.width/2, self.boundingBox.size.height*0.7f)];
    [self addChild:priceLabel z:2];
    
    // Add price text field
    priceField = [CCTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"TextField.png"]];
    [priceField setPreferredSize:CGSizeMake(aSize.width*0.8f, 40)];
    priceField.padding = 8;
    priceField.fontSize = 16;
    [priceField setAnchorPoint:ccp(0.5f, 0.5f)];
    [priceField setPosition:ccp(aSize.width/2, priceLabel.position.y-38)];
    [priceField setTarget:self selector:@selector(enterPressed:)];
    [self addChild:priceField z:2];
    
    // Add time label
    CCLabelTTF *timeLabel = [CCLabelTTF labelWithString:@"Hours Worked:" fontName:@"HelveticaNeue-Light" fontSize:20 dimensions:CGSizeMake(aSize.width*0.8f, 30)];
    timeLabel.horizontalAlignment = CCTextAlignmentLeft;
    [timeLabel setColor:[CCColor blackColor]];
    [timeLabel setPosition:ccp(self.boundingBox.size.width/2, priceField.position.y-45)];
    [self addChild:timeLabel z:2];
    
    // Add time text field
    timeField = [CCTextField textFieldWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"TextField.png"]];
    [timeField setPreferredSize:CGSizeMake(aSize.width*0.8f, 40)];
    timeField.padding = 8;
    timeField.fontSize = 16;
    [timeField setAnchorPoint:ccp(0.5f, 0.5f)];
    [timeField setPosition:ccp(aSize.width/2, timeLabel.position.y-38)];
    [timeField setTarget:self selector:@selector(enterPressed:)];
    [self addChild:timeField z:2];
    
    // Add Value Label
    valueLabel = [CCLabelTTF labelWithString:@"Avg Hourly Wage:\n$0" fontName:@"HelveticaNeue-Light" fontSize:30 dimensions:CGSizeMake(aSize.width, 75)];
    valueLabel.horizontalAlignment = CCTextAlignmentCenter;
    [valueLabel setColor:[CCColor blackColor]];
    [valueLabel setAnchorPoint:ccp(0.5f, 1.0f)];
    [valueLabel setPosition:ccp(self.boundingBox.size.width/2, timeField.position.y-30)];
    [self addChild:valueLabel z:2];
    
    
    return self;
}

// Calculate wage based on text field values
-(void)enterPressed:(id)sender {
    
    // Get inputs
    double priceVal = [priceField.string doubleValue];
    double timeVal = [timeField.string doubleValue];
    double wage;
    
    // Validate inputs
    if (priceVal == 0.0 || timeVal == 0.0) {[valueLabel setString:@"Invalid input detected"];}
    else {
        // Calculate wage
        wage = priceVal/timeVal;
        [valueLabel setString:[NSString stringWithFormat:@"Avg Hourly Wage:\n$%.2f/hr", wage]];
    }
}

// Resets the UI values
-(void)resetUI {
    priceField.string = @"";
    timeField.string = @"";
    [valueLabel setString:@"Avg Hourly Wage:\n$0"];
}

@end
