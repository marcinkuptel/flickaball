//
//  LevelPackLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelPackLayer.h"
#import "LevelPackSpecification.h"
#import "Helper.h"


@interface LevelPackLayer ()

@property (nonatomic, weak) CCLabelBMFont *titleLabel;

@end


@implementation LevelPackLayer

- (id) initWithLevelPackSpecification: (LevelPackSpecification*) levelPackSpecification
{
    self = [super init];
    if (self) {
        CCLabelBMFont *levelPackName = [[CCLabelBMFont alloc] initWithString: levelPackSpecification.levelPackName
                                                                     fntFile: @"MenuFont.fnt"];
        levelPackName.position = self.boundingBoxCenter;
        [self addChild: levelPackName];
        self.titleLabel = levelPackName;
    }
    return self;
}


- (void) onEnter
{
    [super onEnter];
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                            priority: 0
                                                     swallowsTouches: NO];
}


- (void) onExit
{
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];
    [super onExit];
}


#pragma mark - Touches

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [Helper locationFromTouch: touch];
    CGPoint locationInNodeSpace = [self.titleLabel convertToNodeSpace: touchLocation];
    
    CGRect bbox = CGRectMake(0, 0, self.titleLabel.contentSize.width, self.titleLabel.contentSize.height);
    
    if (CGRectContainsPoint(bbox, locationInNodeSpace)) {
        return YES;
    }else{
        return NO;
    }
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(didSelectLevelPackLayer:)]) {
        [self.delegate didSelectLevelPackLayer: self];
    }
}

@end
