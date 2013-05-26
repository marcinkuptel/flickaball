//
//  LevelBuilder.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import <Foundation/Foundation.h>
#import "LevelBuilder.h"

@class GameplayScene;

@interface BasicLevelBuilder : NSObject<LevelBuilder>

- (GameplayScene*) getGameplayScene;

@end
