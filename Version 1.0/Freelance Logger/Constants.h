//
//  Constants.h
//
//  Created by Jaron Lowe
//  Copyright (c) 2012-2014 Jaron Lowe. All rights reserved.
//

// Define whether using an iPhone 5 or not
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#define kBoxBorderColor [CCColor colorWithRed:0.5f green:0.0f blue:1.0f]


// Screen Constants
typedef enum {
    kLoadingScreen = 1,
    kMainMenu = 2,
    kCalculatorScreen = 3,
    kMyLogsScreen = 4,
    kLogTrackerScreen = 5,
    kAddProjectScreen = 6
} ScreenType;

typedef enum {
    kSceneRunning = 1,
    kSceneSwitching = 2,
} MainSceneState;

typedef enum {
    kLogStateStopped = 1,
    kLogStateStopping = 2,
    kLogStateStarting = 3,
    kLogStateRunning = 4
} LogState;