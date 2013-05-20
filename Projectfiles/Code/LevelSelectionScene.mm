//
//  LevelSelectionScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectionScene.h"


@implementation LevelSelectionScene


- (id) init
{
    self = [super init];
    if (self) {
//        _scrollLayer = [[CCScrollLayer alloc] init]
    }
    return self;
}

#pragma mark - CCScrollLayerDelegate

- (void) scrollLayer:(CCScrollLayer *)sender scrolledToPageNumber:(int)page
{
    
}

@end
