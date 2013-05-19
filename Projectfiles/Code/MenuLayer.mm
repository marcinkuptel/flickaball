//
//  MenuLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"


@implementation MenuLayer

- (id) init
{
    self = [super init];
    if (self) {
        CCLabelBMFont *playLabel = [[CCLabelBMFont alloc] initWithString: @"Play" fntFile: @"MenuFont.fnt"];
        CCMenuItemLabel *playMenuItem = [[CCMenuItemLabel alloc] initWithLabel: playLabel block:^(id sender) {
            CCLOG(@"Test!");
        }];
        
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCMenu *menu = [CCMenu menuWithItems: playMenuItem, nil];
        menu.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild: menu];
    }
    return self;
}

@end
