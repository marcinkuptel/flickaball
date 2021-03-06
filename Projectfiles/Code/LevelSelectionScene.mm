//
//  LevelSelectionScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectionScene.h"
#import "LevelPackContentsLayer.h"
#import "ClickableNode.h"

#define LEVEL_TILES_PER_LAYER           20
#define SCROLL_LAYER_WIDTH_OFFSET       20


@interface LevelSelectionScene ()

@property (nonatomic, strong) NSArray *levelSpecifications;

@end


@implementation LevelSelectionScene


- (id) initWithLevelSpecifications: (NSArray*) levelSpecifications
{
    self = [super init];
    if (self) {
        self.levelSpecifications = levelSpecifications;
        NSArray *levelPackContentsLayers = [self levelPackContentsLayersFromSpecifications: _levelSpecifications];
        _scrollLayer = [[CCScrollLayer alloc] initWithLayers: levelPackContentsLayers
                                                 widthOffset: SCROLL_LAYER_WIDTH_OFFSET];
        [self addChild: _scrollLayer];
        [self addBackButton];
    }
    return self;
}


- (NSArray*) levelPackContentsLayersFromSpecifications: (NSArray*) specifications
{
    NSParameterAssert(specifications.count);
    
    NSRange range = NSMakeRange(0, LEVEL_TILES_PER_LAYER);
    NSArray *levelSpecifications = nil;
    LevelPackContentsLayer *contentsLayer = nil;
    NSMutableArray *contentsLayers = [@[] mutableCopy];
    
    while (range.location < specifications.count) {
        
        if (range.location + range.length > specifications.count) {
            range.length = specifications.count - range.location;
        }
        
        levelSpecifications = [specifications subarrayWithRange: range];
        contentsLayer = [[LevelPackContentsLayer alloc] initWithLevelSpecifications: levelSpecifications];
        [contentsLayers addObject: contentsLayer];
        range.location += range.length;
    }
    
    return [NSArray arrayWithArray: contentsLayers];
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


#pragma mark - CCScrollLayerDelegate

- (void) scrollLayer:(CCScrollLayer *)sender scrolledToPageNumber:(int)page
{
    
}

@end
