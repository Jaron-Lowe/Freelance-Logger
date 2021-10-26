//
//  GameManager.m
//  Freelance Logger
//
//  Created by Jaron Lowe on 6/9/13.
//  Copyright (c) 2013 Jaron Lowe. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

@synthesize uiWaiting;
@synthesize indexPressed;

+(id)sharedAppManager {
    static AppManager *sharedAppManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppManager = [[AppManager alloc] init];
    });
    return sharedAppManager;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // App Manager initialized
        NSLog(@"App Manager Singleton, init");
    }
    return self;
}

#pragma File Management

// Returns the app's data file
-(NSMutableDictionary*)getData {
    
    NSString *plistPath = [self getPlistDirectory:@"LogData"];
    NSMutableDictionary *plistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return plistDictionary;
}

// Saves the app's data file
-(void)saveDataFile:(NSMutableDictionary*)aData {
    [aData writeToFile:[self getPlistDirectory:@"LogData"] atomically:YES];
}

// Gets a plist with aFilename from Documents Directory
-(NSString*)getPlistDirectory:(NSString*)aFilename {
    
    NSString *plistPath;
    NSString *fullFileName = [aFilename stringByAppendingString:@".plist"];
    NSError *error;
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [documentDirectory stringByAppendingPathComponent:fullFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: plistPath]) {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:aFilename ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
    }
    return plistPath;
    
}

#pragma Utility



@end
