//
//  GameplayScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayScene.h"
#import "GameplayLayer.h"
#import "BackgroundLayer.h"

@implementation GameplayScene

- (id) init
{
    self = [super init];
    if (self) {
        
        _backgroundLayer = [[BackgroundLayer alloc] init];
        [self addChild: _backgroundLayer];
        
        _gameplayLayer = [[GameplayLayer alloc] init];
        [self addChild: _gameplayLayer];
    }
    return self;
}

@end
