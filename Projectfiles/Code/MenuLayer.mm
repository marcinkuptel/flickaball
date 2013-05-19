//
//  MenuLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"

#define MENU_FNT_FILE       @"MenuFont.fnt"

@implementation MenuLayer

- (id) init
{
    self = [super init];
    if (self) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        NSArray *menuItems = [self menuItemsWithFntFile: MENU_FNT_FILE];
        CCMenu *menu = [CCMenu menuWithArray: menuItems];
        menu.position = CGPointMake(winSize.width/2, winSize.height/2);
        [menu alignItemsVertically];
        [self addChild: menu];
    }
    return self;
}


- (NSArray*) menuItemsWithFntFile: (NSString*) fntFile
{
    CCMenuItemLabel *play = [self playItemWithFntFile: fntFile];
    CCMenuItemLabel *options = [self optionsItemWithFntFile: fntFile];
    CCMenuItemLabel *achievements = [self achievementsItemWithFntFile: fntFile];
    CCMenuItemLabel *leaderboards = [self leaderboardsItemWithFntFile: fntFile];
    return @[play, options, achievements, leaderboards];
}


- (CCMenuItemLabel*) playItemWithFntFile: (NSString*) fntFile
{
    CCLabelBMFont *playLabel = [[CCLabelBMFont alloc] initWithString: NSLocalizedString(@"Play", ) fntFile: fntFile];
    CCMenuItemLabel *playMenuItem = [[CCMenuItemLabel alloc] initWithLabel: playLabel block:^(id sender) {
        CCLOG(@"Test!");
    }];
    
    return playMenuItem;
}


- (CCMenuItemLabel*) optionsItemWithFntFile: (NSString*) fntFile
{
    CCLabelBMFont *optionsLabel = [[CCLabelBMFont alloc] initWithString: NSLocalizedString(@"Options", ) fntFile: @"MenuFont.fnt"];
    CCMenuItemLabel *optionsMenuItem = [[CCMenuItemLabel alloc] initWithLabel: optionsLabel block:^(id sender) {
        CCLOG(@"Test!");
    }];
    
    return optionsMenuItem;
}


- (CCMenuItemLabel*) achievementsItemWithFntFile: (NSString*) fntFile
{
    CCLabelBMFont *achievementsLabel = [[CCLabelBMFont alloc] initWithString: NSLocalizedString(@"Achievements", ) fntFile: @"MenuFont.fnt"];
    CCMenuItemLabel *achievementsMenuItem = [[CCMenuItemLabel alloc] initWithLabel: achievementsLabel block:^(id sender) {
        CCLOG(@"Test!");
    }];
    
    return achievementsMenuItem;
}


- (CCMenuItemLabel*) leaderboardsItemWithFntFile: (NSString*) fntFile
{
    CCLabelBMFont *leaderboardsLabel = [[CCLabelBMFont alloc] initWithString: NSLocalizedString(@"Leaderboards", ) fntFile: @"MenuFont.fnt"];
    CCMenuItemLabel *leaderboardsMenuItem = [[CCMenuItemLabel alloc] initWithLabel: leaderboardsLabel block:^(id sender) {
        CCLOG(@"Test!");
    }];
    
    return leaderboardsMenuItem;
}

@end
