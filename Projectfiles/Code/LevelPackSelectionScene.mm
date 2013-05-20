//
//  LevelPackSelectionScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackSelectionScene.h"
#import "LevelPackLayer.h"
#import "LevelSelectionScene.h"
#import "LevelPackSpecification.h"

#define SCROLL_LAYER_WIDTH_OFFSET       20

@implementation LevelPackSelectionScene


- (id) initWithLevelPackSpecifications: (NSArray*) levelPackSpecifications
{
    self = [super init];
    if (self) {
        _levelPackSpecifications = levelPackSpecifications;
        NSArray *levelPackLayers = [self levelPackLayersFromSpecifications: levelPackSpecifications];
        _scrollLayer = [[CCScrollLayer alloc] initWithLayers: levelPackLayers widthOffset: SCROLL_LAYER_WIDTH_OFFSET];
        
        [self addChild: _scrollLayer];
        
        //register to receive touches
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                                priority: 0
                                                         swallowsTouches: NO];
    }
    return self;
}


- (void) cleanup
{
    [super cleanup];
    
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];
}


- (NSArray*) levelPackLayersFromSpecifications: (NSArray*) levelPackSpecifications
{
    NSParameterAssert(levelPackSpecifications);
    
    NSMutableArray *levelPackLayers = [@[] mutableCopy];
    LevelPackLayer *levelPackLayer = nil;
    for (LevelPackSpecification* levelPackSpecification in levelPackSpecifications) {
        levelPackLayer = [[LevelPackLayer alloc] initWithLevelPackSpecification: levelPackSpecification];
        [levelPackLayers addObject: levelPackLayer];
    }
    return levelPackLayers;
}


#pragma mark - CCScrollLayerDelegate

- (void) scrollLayer:(CCScrollLayer *)sender scrolledToPageNumber:(int)page
{
    
}


#pragma mark - Touches

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //create a new scene where the user can select a level
    LevelPackSpecification *levelPackSpecification = _levelPackSpecifications[_scrollLayer.currentScreen];
    NSArray *levelSpecifications = levelPackSpecification.levelSpecifications;
    LevelSelectionScene *levelSelectionScene = [[LevelSelectionScene alloc] initWithLevelSpecifications: levelSpecifications];
    [[CCDirector sharedDirector] replaceScene: levelSelectionScene];
}



@end
