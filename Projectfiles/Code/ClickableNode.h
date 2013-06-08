//
//  ClickableNode.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 08/06/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef void(^ClickableNodeActionBlock)(id sender);

@interface ClickableNode : CCSprite<CCTouchOneByOneDelegate> {
    
}

+ (ClickableNode*) nodeWithName: (NSString*) name block: (ClickableNodeActionBlock) block;

@end
