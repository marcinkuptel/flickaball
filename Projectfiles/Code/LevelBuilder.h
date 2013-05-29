//
//  LevelBuilder.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import <Foundation/Foundation.h>

@protocol LevelBuilder <NSObject>

@required

- (void) buildGameplayScene;
- (void) buildBackgroundLayer;
- (void) buildBoardLayer;
- (void) buildUserControlsLayer;
- (void) buildBallLayer;

@end
