//
//  Ball.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 14/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"

@implementation Ball

+ (id) ballWithWorld: (b2World*) world position: (CGPoint) position
{
    return [[self alloc] initWithWorld: world position: position];
}


- (id) initWithWorld: (b2World*) world position: (CGPoint) position
{
    self = [super initWithShape: @"ball" inWorld: world];
    if (self) {
        
        self.physicsBody->SetTransform([Helper toMeters: position], 0);
        self.physicsBody->SetType(b2_dynamicBody);
    }
    return self;
}


+ (void) load
{
    [[ObjectFactory sharedFactory] registerClass: self
                                     forObjectID: FBBallObjectIdentifier];
}

+ (GameObject*) objectWithShape: (NSString *)shapeName
                          world: (b2World *)world
                     parameters: (NSDictionary *)parameters
{
    Ball *ball = [[Ball alloc] initWithWorld: world position: [CCDirector sharedDirector].screenCenter];
    return ball;
}

@end
