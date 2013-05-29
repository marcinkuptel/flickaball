//
//  LevelBuilder.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import "BasicLevelBuilder.h"
#import "GameplayScene.h"
#import "BackgroundLayer.h"
#import "BallLayer.h"
#import "BoardLayer.h"
#import "GameObject.h"
#import "ObjectFactory.h"
#import "Ball.h"

@interface BasicLevelBuilder ()

@property (nonatomic, strong) GameplayScene *gameplayScene;

@end

@implementation BasicLevelBuilder


#pragma mark - LevelBuilder protocol

- (void) buildGameplayScene
{
    if (self.gameplayScene) {
        [NSException raise: NSInternalInconsistencyException
                    format: @"Gameplay scene already initialized!"];
    }
    
    self.gameplayScene = [[GameplayScene alloc] init];
}


- (void) buildBackgroundLayer
{
    if (self.gameplayScene == nil) {
        [NSException raise: NSInternalInconsistencyException
                    format: @"Gameplay scene not initialized!"];
    }
    
    BackgroundLayer *backgroundLayer = [[BackgroundLayer alloc] init];
    [self.gameplayScene setBackgroundLayer: backgroundLayer];
}


- (void) buildBoardLayer
{
    
}


- (void) buildUserControlsLayer
{
    
}


- (void) buildBallLayer
{
    GameObject *ball = [[ObjectFactory sharedFactory] constructGameObjectWithID: FBBallObjectIdentifier
                                                                          world: self.gameplayScene.world];
    
    BallLayer *ballLayer = [[BallLayer alloc] initWithBall: (Ball*)ball];
    [self.gameplayScene setBallLayer: ballLayer];
}


#pragma mark - Public methods

- (GameplayScene*) getGameplayScene
{
    GameplayScene *gameplayScene = self.gameplayScene;
    self.gameplayScene = nil;
    
    return gameplayScene;
}

@end
