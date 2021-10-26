//
//  MainScene.m
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

-(id)init {
    self = [super init];
    if (!self) return(nil);
    
    // Get the screen size
    size = [[CCDirector sharedDirector] viewSize];
    
    // Add background layer
    BackLayer *back = [[BackLayer alloc] init];
    [self addChild:back z:-1];
    
    // Add loading layer
    LoadingLayer *loading = [[LoadingLayer alloc] init];
    [self addChild:loading z:1 name:[NSString stringWithFormat:@"%d", kLoadingScreen]];
    currentLayer = loading;
    [loading activate];
    currentState = kSceneRunning;
    
    // Add menu layer
    MenuLayer *menu = [[MenuLayer alloc] init];
    menu.visible = NO;
    [self addChild:menu z:1 name:[NSString stringWithFormat:@"%d", kMainMenu]];
    
    // Add calculator layer
    CalculatorLayer *calculator = [[CalculatorLayer alloc] init];
    calculator.visible = NO;
    [self addChild:calculator z:1 name:[NSString stringWithFormat:@"%d", kCalculatorScreen]];
    
    // Add my logs layer
    MyLogsLayer *myLogs = [[MyLogsLayer alloc] init];
    myLogs.visible = NO;
    [self addChild:myLogs z:1 name:[NSString stringWithFormat:@"%d", kMyLogsScreen]];
    
    // Add log tracker layer
    LogTrackerLayer *logTracker = [[LogTrackerLayer alloc] init];
    logTracker.visible = NO;
    [self addChild:logTracker z:1 name:[NSString stringWithFormat:@"%d", kLogTrackerScreen]];
    
    // Add add project layer
    AddProjectLayer *addProject = [[AddProjectLayer alloc] init];
    addProject.visible = NO;
    [self addChild:addProject z:1 name:[NSString stringWithFormat:@"%d", kAddProjectScreen]];
    
    
    return self;
}


-(void)switchScreen:(NSNumber*)aScreen {
    
    if (currentState == kSceneRunning && [AppManager sharedAppManager].uiWaiting == NO) {
        currentState = kSceneSwitching;
        [AppManager sharedAppManager].uiWaiting = YES;
        [currentLayer deactivate];
        nextLayer = (CCLayer*)[self getChildByName:[NSString stringWithFormat:@"%d", [aScreen intValue]] recursively:NO];
        
        [nextLayer setPosition:ccp(size.width, 0)];
        nextLayer.visible = YES;
        [currentLayer runAction:[CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:0.5f position:ccp(-size.width, 0)] rate:2.0f]];
        [nextLayer runAction:[CCActionSequence actions:
                              [CCActionEaseInOut actionWithAction:[CCActionMoveTo actionWithDuration:0.5f position:ccp(0,0)] rate:2.0f],
                              [CCActionDelay actionWithDuration:0.1f],
                              [CCActionCallBlock actionWithBlock:^{
            currentLayer.visible = NO;
            currentLayer = nextLayer;
            [currentLayer activate];
            currentState = kSceneRunning;
            [AppManager sharedAppManager].uiWaiting = NO;
        }],
                              nil]];
    }
    
}

// Refreshes the My Logs layer
-(void)refreshMyLogs {
    [((MyLogsLayer*)[self getChildByName:[NSString stringWithFormat:@"%d", kMyLogsScreen] recursively:NO]) refreshData];
}

// Refreshes the Log Tracker layer
-(void)refreshLogTracker:(NSNumber*)aIndex {
    [((LogTrackerLayer*)[self getChildByName:[NSString stringWithFormat:@"%d", kLogTrackerScreen] recursively:NO]) refreshDataWithIndex:[aIndex intValue]];
}

@end
