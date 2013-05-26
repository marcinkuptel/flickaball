//
//  LevelBuilder.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import "BasicLevelBuilder.h"
#import "GameplayScene.h"
#import "GameplayLayer.h"


@interface BasicLevelBuilder ()

@property (nonatomic, strong) GameplayLayer *gameplayLayer;

@end

@implementation BasicLevelBuilder


#pragma mark - LevelBuilder protocol

- (void) buildGameplayLayer
{
    if (self.gameplayLayer) {
        [NSException raise: NSInternalInconsistencyException
                    format: @"Gameplay layer already initialized!"];
    }
    
    self.gameplayLayer = [[GameplayLayer alloc] init];
}


- (void) buildBoardLayer
{
    
}


- (void) buildUserControlsLayer
{
    
}


- (void) buildBallLayer
{
    
}


#pragma mark - Public methods

- (GameplayScene*) getGameplayScene
{
    GameplayScene *gameplayScene = [[GameplayScene alloc] init];
    [gameplayScene addChild: self.gameplayLayer];
    
    return gameplayScene;
}

@end
