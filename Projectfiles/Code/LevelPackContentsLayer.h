//
//  LevelPackContentsLayer.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
#import "LevelTile.h"

@interface LevelPackContentsLayer : CCLayer<LevelTileDelegate> {
    
}

- (id) initWithLevelSpecifications: (NSArray*) levelSpecifications;

@end
