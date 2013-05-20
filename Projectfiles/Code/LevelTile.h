//
//  LevelTile.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

@class LevelSpecification;
@protocol LevelTileDelegate;

@interface LevelTile : CCNode<CCTouchOneByOneDelegate>

@property (nonatomic, weak) id<LevelTileDelegate> delegate;
@property (nonatomic, assign) NSUInteger tileIndex;

- (id) initWithLevelSpecification: (LevelSpecification*) levelSpecification;

@end


@protocol LevelTileDelegate <NSObject>

@optional
- (void) didSelectTile: (LevelTile*) levelTile atIndex: (NSUInteger) tileIndex;

@end
