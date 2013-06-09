//
//  ClickableNode.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 08/06/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ClickableNode.h"
#import "Helper.h"

@interface ClickableNode()

@property (nonatomic, copy) ClickableNodeActionBlock block;

@end

@implementation ClickableNode

+ (ClickableNode*) nodeWithName: (NSString*) name block: (ClickableNodeActionBlock) block
{
    ClickableNode *node = [[ClickableNode alloc] initWithName: name
                                                        block: block];
    return node;
}


- (id) initWithName: (NSString*) name block: (ClickableNodeActionBlock) block
{
    self = [super initWithSpriteFrameName: name];
    if (self) {
        
        self.block = block;
    }
    return self;
}


- (void) onEnter
{
    [super onEnter];
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                            priority: 1
                                                     swallowsTouches: YES];
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
    CGPoint locationInNodeSpace = [self convertToNodeSpace: touchLocation];
    
    CGRect bbox = CGRectMake(0, 0,
                             self.contentSize.width,
                             self.contentSize.height);
    
    if (CGRectContainsPoint(bbox, locationInNodeSpace))
    {
        return YES;
    }else{
        return NO;
    }
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.block) {
        self.block(self);
    }
}

@end
