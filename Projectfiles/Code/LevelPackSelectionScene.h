//
//  LevelPackSelectionScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCScrollLayer.h"
#import "LevelPackLayer.h"

@interface LevelPackSelectionScene : CCScene<LevelPackLayerDelegate> {
    @private
    CCScrollLayer *_scrollLayer;
}

@property (nonatomic, strong, readonly) NSArray *levelPackSpecifications;

- (id) initWithLevelPackSpecifications: (NSArray*) levelPackSpecifications;

@end
