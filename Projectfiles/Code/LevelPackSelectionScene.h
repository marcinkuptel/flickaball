//
//  LevelPackSelectionScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCScrollLayer.h"

@interface LevelPackSelectionScene : CCScene<CCScrollLayerDelegate, CCTouchOneByOneDelegate> {
    @private
    CCScrollLayer *_scrollLayer;
    NSArray *_levelPackSpecifications;
}

- (id) initWithLevelPackSpecifications: (NSArray*) levelPackSpecifications;

@end
