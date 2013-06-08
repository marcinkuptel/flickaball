//
//  LevelPackSelectionScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackSelectionScene.h"
#import "LevelSelectionScene.h"
#import "LevelPackSpecification.h"
#import "ClickableNode.h"

#define SCROLL_LAYER_WIDTH_OFFSET       20

@interface LevelPackSelectionScene ()

@property (nonatomic, strong) NSArray *levelPackSpecifications;

@end


@implementation LevelPackSelectionScene


- (id) initWithLevelPackSpecifications: (NSArray*) levelPackSpecifications
{
    self = [super init];
    if (self) {
        self.levelPackSpecifications = levelPackSpecifications;
        NSArray *levelPackLayers = [self levelPackLayersFromSpecifications: levelPackSpecifications delegate: self];
        _scrollLayer = [[CCScrollLayer alloc] initWithLayers: levelPackLayers
                                                 widthOffset: SCROLL_LAYER_WIDTH_OFFSET];
        
        [self addChild: _scrollLayer];
        [self addBackButton];
    }
    return self;
}


- (NSArray*) levelPackLayersFromSpecifications: (NSArray*) levelPackSpecifications delegate: (id<LevelPackLayerDelegate>) delegate
{
    NSParameterAssert(levelPackSpecifications);
    
    NSMutableArray *levelPackLayers = [@[] mutableCopy];
    LevelPackLayer *levelPackLayer = nil;
    for (LevelPackSpecification* levelPackSpecification in levelPackSpecifications) {
        levelPackLayer = [[LevelPackLayer alloc] initWithLevelPackSpecification: levelPackSpecification];
        levelPackLayer.delegate = self;
        [levelPackLayers addObject: levelPackLayer];
    }
    return levelPackLayers;
}


#pragma mark - Back button

- (void) addBackButton
{
    id block = ^(id sender){
        [[CCDirector sharedDirector] popScene];
    };
    
    ClickableNode *backButton = [ClickableNode nodeWithName: @"arrowBack"
                                                      block: block];
    CGFloat x = backButton.boundingBox.size.width/2;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CGFloat y = winSize.height - backButton.boundingBox.size.height/2;
    backButton.position = ccp(x, y);
    
    [self addChild: backButton];
}


#pragma mark - LevelPackLayerDelegate

- (void) didSelectLevelPackLayer:(LevelPackLayer *)layer
{
    //create a new scene where the user can select a level
    LevelPackSpecification *levelPackSpecification = _levelPackSpecifications[_scrollLayer.currentScreen];
    NSArray *levelSpecifications = levelPackSpecification.levelSpecifications;
    LevelSelectionScene *levelSelectionScene = [[LevelSelectionScene alloc] initWithLevelSpecifications: levelSpecifications];
    [[CCDirector sharedDirector] pushScene: levelSelectionScene];
}



@end
