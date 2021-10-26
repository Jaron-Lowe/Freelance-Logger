//
//  GameManager.h
//  Freelance Logger
//
//  Created by Jaron Lowe on 6/9/13.
//  Copyright (c) 2013 Jaron Lowe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject {
    
    BOOL uiWaiting;
    
    // Use global index to fix iPhone 5s - sender issue
    int indexPressed;
    
}

@property (nonatomic, readwrite) BOOL uiWaiting;
@property (nonatomic, readwrite) int indexPressed;

+(AppManager*)sharedAppManager;

-(NSMutableDictionary*)getData;
-(void)saveDataFile:(NSMutableDictionary*)aData;
-(NSString*)getPlistDirectory:(NSString*)aFilename;


@end
