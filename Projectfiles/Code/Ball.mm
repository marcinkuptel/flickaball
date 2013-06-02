//
//  Ball.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 14/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "SimpleAudioEngine.h"

#define BALL_SHAPE_NAME             @"ball"
#define BALL_HITS_WALL_SOUND        @"ballHitsWall.wav"

@implementation Ball

+ (void) load
{
    [[ObjectFactory sharedFactory] registerClass: self
                                     forObjectID: FBBallObjectIdentifier];
}

+ (GameObject*) objectWithShape: (NSString *)shapeName
                          world: (b2World *)world
                     parameters: (NSDictionary *)parameters
{
    CGPoint position = CGPointFromString(parameters[GOParameterPositionKey]);
    Ball *ball = [[Ball alloc] initWithWorld: world position: position];
    return ball;
}


- (id) initWithWorld: (b2World*) world position: (CGPoint) position
{
    self = [super initWithShape:BALL_SHAPE_NAME inWorld: world];
    if (self) {
        
        self.physicsBody->SetTransform([Helper toMeters: position], 0);
        self.physicsBody->SetType(b2_dynamicBody);
    }
    return self;
}


#pragma mark - Contacts

- (void) beginContactWithWall: (Contact*) contact
{
    [[SimpleAudioEngine sharedEngine] playEffect: BALL_HITS_WALL_SOUND];
}


@end
