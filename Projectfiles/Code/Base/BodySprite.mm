//
//  BodySprite.m
//  PhysicsBox2d
//
//  Created by Steffen Itterheim on 21.09.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//
//  Enhanced to use PhysicsEditor shapes and retina display
//  by Andreas Loew / http://www.physicseditor.de
//

#import "BodySprite.h"

@implementation BodySprite

-(id) initWithShape:(NSString*)shapeName inWorld:(b2World*)world
{
    NSAssert(world != NULL, @"world is null!");
    NSAssert(shapeName != nil, @"name is nil!");

    // init the sprite itself with the given shape name
    self = [super initWithSpriteFrameName:shapeName];
    if (self)
    {        
        // create the body
        b2BodyDef bodyDef;
        physicsBody = world->CreateBody(&bodyDef);
        physicsBody->SetUserData((__bridge void*)self);
        
        // set the shape
        [self setBodyShape:shapeName];
    }
    return self;
}

-(void) setBodyShape:(NSString*)shapeName
{
    // remove any existing fixtures from the body
    b2Fixture* fixture;
    while ((fixture = physicsBody->GetFixtureList()))
    {
        physicsBody->DestroyFixture(fixture);
    }

    // attach a new shape from the shape cache
    if (shapeName)
    {
        GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache];
        [shapeCache addFixturesToBody:physicsBody forShapeName:shapeName];
        self.anchorPoint = [shapeCache anchorPointForShape:shapeName];
    }
}

-(void) dealloc
{
    // remove the body from the world
    if (physicsBody) {
        physicsBody->GetWorld()->DestroyBody(physicsBody);
    }
    
}

@end
