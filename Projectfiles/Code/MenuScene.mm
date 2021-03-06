//
//  MenuScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "MenuLayer.h"

@implementation MenuScene

- (id) init
{
    self = [super init];
    if (self) {
        
        // pre load the sprite frames from the texture atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameplayLayer.plist"];
        
        _menuLayer = [[MenuLayer alloc] init];
        [self addChild: _menuLayer];
    }
    return self;
}

@end
