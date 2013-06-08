//
//  LevelPackContentsLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackContentsLayer.h"
#import "LevelSpecification.h"
#import "LevelConstructionDirector.h"
#import "BasicLevelBuilder.h"

#define TILE_SIZE       CGSizeMake(100, 100)
#define GRID_WIDTH      500
#define GRID_HEIGHT     500

@interface LevelPackContentsLayer ()

@property (nonatomic, strong) NSArray *levelTiles;
@property (nonatomic, strong) NSArray *levelSpecifications;

@end

@implementation LevelPackContentsLayer

- (id) initWithLevelSpecifications: (NSArray*) levelSpecifications
{
    self = [super init];
    if (self) {
        self.levelSpecifications = levelSpecifications;
        self.levelTiles = [self levelTilesFromLevelSpecifications: self.levelSpecifications];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        [self arrangeTiles: self.levelTiles
                    inRect: CGSizeMake(GRID_WIDTH, GRID_HEIGHT)
                  tileSize: TILE_SIZE
                  vPadding: 10
                  hPadding: 10];
        
        [self addTiles: self.levelTiles
              atOrigin: ccp((winSize.width - GRID_WIDTH)/2, (winSize.height - GRID_HEIGHT)/2)];
    }
    return self;
}


#pragma mark - Tile management

- (NSArray*) levelTilesFromLevelSpecifications: (NSArray*) levelSpecifications
{
    NSParameterAssert(levelSpecifications);
    
    NSMutableArray *levelTiles = [@[] mutableCopy];
    LevelTile *levelTile = nil;
    for (LevelSpecification *specification in levelSpecifications) {
        levelTile = [[LevelTile alloc] initWithLevelSpecification: specification];
        levelTile.contentSize = TILE_SIZE;
        [levelTiles addObject: levelTile];
    }
    return [NSArray arrayWithArray: levelTiles];
}


- (void) arrangeTiles: (NSArray*) tiles
               inRect: (CGSize) rectSize
             tileSize: (CGSize) tileSize
             vPadding: (CGFloat) vPadding
             hPadding: (CGFloat) hPadding
{
    CGFloat tileWidth = 2*hPadding + tileSize.width;
    CGFloat tileHeight = 2*vPadding + tileSize.height;
    
    CGFloat areaRequired = tileWidth*tileHeight*tiles.count;
    CGFloat areaAvailable = rectSize.width * rectSize.height;
    
    if (areaRequired > areaAvailable) {
        [NSException raise: NSInternalInconsistencyException
                    format: @"Not enough space to arrange tiles"];
    }
    
    NSInteger tilesPerRow = rectSize.width/tileWidth;
    NSInteger rows = ceil(tiles.count/(double)tilesPerRow);
    
    int j = 0;
    NSUInteger index = 0;
    LevelTile *tile = nil;
    
    for (NSInteger i = 0; i < rows; i++) {
        for (j = 0; j < tilesPerRow; j++) {
            index = i*tilesPerRow + j;
            if (index < tiles.count) {
                tile = tiles[index];
                tile.position = ccp(j*tileWidth, i*tileHeight) ;
            }else break;
        }
    }
}


- (void) addTiles: (NSArray*) tiles atOrigin: (CGPoint) origin
{
    LevelTile *tile = nil;
    for (NSUInteger i = 0; i < tiles.count; i++) {
        tile = tiles[i];
        tile.position = [[CCDirector sharedDirector] convertToGL: ccpAdd(tile.position, origin)];
        tile.delegate = self;
        tile.tileIndex = i;
        [self addChild: tile];
    }
}


#pragma mark - LevelTileDelegate

- (void) didSelectTile:(LevelTile *)levelTile atIndex:(NSUInteger)tileIndex
{
    NSParameterAssert(tileIndex >= 0 && tileIndex < [self.levelSpecifications count]);
    
    LevelSpecification *levelSpecification = self.levelSpecifications[tileIndex];
    
    BasicLevelBuilder *levelBuilder = [[BasicLevelBuilder alloc] init];
    LevelConstructionDirector *constructionDirector = [[LevelConstructionDirector alloc] initWithLevelBuilder: levelBuilder
                                                                                           levelSpecification: levelSpecification];
    
    [constructionDirector construct];
    CCScene *gameplayScene = (CCScene*)[levelBuilder getGameplayScene];
    [[CCDirector sharedDirector] pushScene: gameplayScene];
}

@end
