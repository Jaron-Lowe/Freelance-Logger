//
//  MainScene.h
//  Freelance Logger
//
//  Created by Jaron on 6/24/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCScene.h"
#import "BackLayer.h"
#import "LoadingLayer.h"
#import "MenuLayer.h"
#import "CalculatorLayer.h"
#import "MyLogsLayer.h"
#import "LogTrackerLayer.h"
#import "AddProjectLayer.h"

@interface MainScene : CCScene {
    
    CGSize size;
    __weak CCLayer *currentLayer;
    __weak CCLayer *nextLayer;
    MainSceneState currentState;
}

-(void)switchScreen:(NSNumber*)aScreen;

@end
