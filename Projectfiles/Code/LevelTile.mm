//
//  LevelTile.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelTile.h"
#import "Helper.h"


@interface LevelTile ()

@property (nonatomic, strong) CCLabelBMFont *title;

@end

@implementation LevelTile

- (id) initWithLevelSpecification: (LevelSpecification*) levelSpecification
{
    self = [super init];
    if (self) {
        self.title = [[CCLabelBMFont alloc] initWithString: @"1"
                                                   fntFile: @"MenuFont.fnt"];
        self.title.position = ccp(0,0);
        [self addChild: self.title];
        
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                                priority: 0
                                                         swallowsTouches: NO];
    }
    return self;
}


- (void) cleanup
{
    [super cleanup];
    
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];
}

#pragma mark - Touches

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [Helper locationFromTouch: touch];

    if (CGRectContainsPoint(self.boundingBox, touchLocation)) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectTile:atIndex:)]) {
            [self.delegate didSelectTile: self atIndex: self.tileIndex];
        } 
    }
}

#pragma mark - Overriden methods

- (void) setContentSize:(CGSize)contentSize
{
    [super setContentSize: contentSize];
    
    self.title.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
}


@end
