//
//  ControlsLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 08/06/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ControlsLayer.h"
#import "ClickableNode.h"

@implementation ControlsLayer

- (id) init
{
    self = [super init];
    if (self) {
        [self addBackButton];
    }
    return self;
}


- (void) addBackButton
{
    id block = ^(id sender){
        [[CCDirector sharedDirector] popScene];
    };
    
    ClickableNode *backButton = [ClickableNode nodeWithName: @"arrowBack"
                                                      block: block];
    CGFloat x = backButton.boundingBox.size.width/2;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CGFloat y = winSize.height - backButton.boundingBox.size.height/2;
    backButton.position = ccp(x, y);
    
    [self addChild: backButton];
}

@end
