//
//  LevelSelectionScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CCScrollLayer.h"

@class LevelSpecification;

/**
 Scene in which the user can browse levels included in the chosen
 level pack.
 */
@interface LevelSelectionScene : CCScene<CCScrollLayerDelegate> {
    @private
    CCScrollLayer *_scrollLayer;
}

@property (nonatomic, strong, readonly) NSArray *levelSpecifications;

- (id) initWithLevelSpecifications: (NSArray*) levelSpecifications;

@end
