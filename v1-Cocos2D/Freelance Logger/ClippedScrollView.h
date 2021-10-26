//
//  ClippedScrollView.h
//
//  Created by Jaron on 3/13/14.
//  Copyright (c) 2014 Jaron Lowe. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCNode.h"

@interface ClippedScrollView : CCNode {
    
}

-(id)initWithSize:(CGSize)aSize contentNode:(CCNode*)aContentNode;
-(void)replaceContentNode:(CCNode*)aContentNode;

@end
