//
//  LevelSelectionScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCScrollLayer.h"

@class LevelLoader;

@interface LevelSelectionScene : CCScene<CCScrollLayerDelegate> {
    CCScrollLayer *_scrollLayer;
    LevelLoader *_levelLoader;
}

- (id) initWithLevelLoader: (LevelLoader*) levelLoader;

@end
