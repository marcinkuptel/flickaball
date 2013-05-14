//
//  GameplayLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"
#import "Helper.h"
#import "Ball.h"

@interface GameplayLayer ()

@property (nonatomic, strong) Ball *ball;

@end

@implementation GameplayLayer

- (id) init
{
    self = [super init];
    if (self) {
        
        // pre load the sprite frames from the texture atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameplayLayer.plist"];
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"physics-ipadhd.plist"];
        
        [self initPhysics];
        
        [self addBall];
        
        [self scheduleUpdate];
    }
    return self;
}


- (void) dealloc
{
    delete _world;
    _world = NULL;
    delete _debugDraw;
    _debugDraw = NULL;
}

#if DEBUG
-(void) draw
{
	[super draw];
	
	ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position);
	kmGLPushMatrix();
	_world->DrawDebugData();
	kmGLPopMatrix();
}
#endif


#pragma mark - Physics

- (void) initPhysics
{
    b2Vec2 gravity;
    gravity.Set(0.0f, 0.0f);
    _world = new b2World(gravity);
    _world->SetAllowSleeping(true);
    _world->SetContinuousPhysics(true);
    
    _debugDraw = new GLESDebugDraw(PTM_RATIO);
    _world->SetDebugDraw(_debugDraw);
    
    uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	_debugDraw->SetFlags(flags);
    
    //create ground body
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0.0f, 0.0f);
    b2Body *groundBody = _world->CreateBody(&groundBodyDef);
    
    //create fixture
    CGSize screenSize = [CCDirector sharedDirector].winSize;
	float boxWidth = screenSize.width / PTM_RATIO;
	float boxHeight = screenSize.height / PTM_RATIO;
    
    b2EdgeShape edge;
    edge.Set(b2Vec2(0, 0), b2Vec2(0, boxHeight));
    b2Fixture *left = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, boxHeight), b2Vec2(boxWidth, boxHeight));
    b2Fixture *top = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(boxWidth, boxHeight), b2Vec2(boxWidth, 0));
    b2Fixture *right = groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, 0), b2Vec2(boxWidth, 0));
    b2Fixture *bottom = groundBody->CreateFixture(&edge, 0.0f);
}


#pragma mark - Update

- (void) update:(ccTime)delta
{
    int velocityIterations = 8;
    int positionIterations = 3;
    _world->Step(delta, velocityIterations, positionIterations);
}


#pragma mark - Others


- (void) addBall
{
    Ball *ball = [Ball ballWithWorld: _world position: [CCDirector sharedDirector].screenCenter];
    [self addChild: ball];
    self.ball = ball;
}





@end
