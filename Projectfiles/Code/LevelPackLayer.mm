//
//  LevelPackLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackLayer.h"
#import "LevelPackSpecification.h"

@implementation LevelPackLayer

- (id) initWithLevelPackSpecification: (LevelPackSpecification*) levelPackSpecification
{
    self = [super init];
    if (self) {
        CCLabelBMFont *levelPackName = [[CCLabelBMFont alloc] initWithString: levelPackSpecification.levelPackName
                                                                     fntFile: @"MenuFont.fnt"];
        levelPackName.position = self.boundingBoxCenter;
        [self addChild: levelPackName];
        
    }
    return self;
}

@end
