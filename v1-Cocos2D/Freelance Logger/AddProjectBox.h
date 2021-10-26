//
//  AddProjectBox.h
//  Freelance Logger
//
//  Created by Jaron on 7/11/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "CCLayer.h"

@interface AddProjectBox : CCLayer {
    CCTextField *nameField;
    CCTextField *priceField;
    
    BOOL writingData;
}

-(id)initWithSize:(CGSize)aSize;
-(void)resetUI;

@end
