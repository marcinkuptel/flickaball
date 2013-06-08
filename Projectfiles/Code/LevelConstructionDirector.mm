//
//  LevelConstructionDirector.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import "LevelConstructionDirector.h"
#import "LevelSpecification.h"

@interface LevelConstructionDirector ()

@property (nonatomic, strong) id<LevelBuilder> levelBuilder;
@property (nonatomic, strong) LevelSpecification *levelSpecification;

@end

@implementation LevelConstructionDirector

- (id) initWithLevelBuilder: (id<LevelBuilder>) builder levelSpecification: (LevelSpecification*) levelSpecification
{
    self = [super init];
    if (self) {
        self.levelBuilder = builder;
        self.levelSpecification = levelSpecification;
    }
    return self;
}


- (void) construct
{
    [self.levelBuilder buildGameplayScene];
    [self.levelBuilder buildBackgroundLayer];
    [self.levelBuilder buildBoardLayerWithWorldObjects: self.levelSpecification.worldObjects];
    [self.levelBuilder buildControlsLayer];
    [self.levelBuilder buildBallLayerWithBallParameters: self.levelSpecification.ballParameters];
}

@end
