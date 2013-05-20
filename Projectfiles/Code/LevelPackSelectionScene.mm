//
//  LevelPackSelectionScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackSelectionScene.h"
#import "LevelPackLayer.h"

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
    }
    return self;
}


- (NSArray*) levelPackLayersFromSpecifications: (NSArray*) levelPackSpecifications
{
    NSParameterAssert(levelPackSpecifications);
    
    NSMutableArray *levelPackLayers = [@[] mutableCopy];
    LevelPackLayer *levelPackLayer = nil;
    for (id levelPackSpecification in levelPackSpecifications) {
        levelPackLayer = [[LevelPackLayer alloc] initWithLevelPackSpecification: levelPackSpecification];
        [levelPackLayers addObject: levelPackLayer];
    }
    return levelPackLayers;
}


#pragma mark - CCScrollLayerDelegate

- (void) scrollLayer:(CCScrollLayer *)sender scrolledToPageNumber:(int)page
{
    
}

@end
