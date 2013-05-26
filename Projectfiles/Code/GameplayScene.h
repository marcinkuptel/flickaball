//
//  GameplayScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BackgroundLayer;
@class GameplayLayer;

@interface GameplayScene : CCScene {
    BackgroundLayer *_backgroundLayer;
    GameplayLayer *_gameplayLayer;
}

@end
