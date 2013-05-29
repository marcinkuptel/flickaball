//
//  GameplayScene.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameplayScene.h"
#import "BallLayer.h"
#import "BackgroundLayer.h"
#import "BoardLayer.h"
#import "Helper.h"

const float32 FIXED_TIMESTEP = 1.0f / 60.0f;

// Minimum remaining time to avoid box2d unstability caused by very small delta times
// if remaining time to simulate is smaller than this, the rest of time will be added to the last step,
// instead of performing one more single step with only the small delta time.
const float32 MINIMUM_TIMESTEP = 1.0f / 600.0f;

const int32 VELOCITY_ITERATIONS = 8;
const int32 POSITION_ITERATIONS = 8;

// maximum number of steps per tick to avoid spiral of death
const int32 MAXIMUM_NUMBER_OF_STEPS = 25;

typedef NS_ENUM(NSUInteger, GSLayerOrder)
{
    GSLayerOrderBackground = 0,
    GSLayerOrderBoard,
    GSLayerOrderBall
};


@implementation GameplayScene

- (id) init
{
    self = [super init];
    if (self) {
        // pre load the sprite frames from the texture atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameplayLayer.plist"];
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"physics-ipadhd.plist"];
        
        [self initPhysics];
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


#pragma mark - Accessors

- (void) setBackgroundLayer:(BackgroundLayer *)backgroundLayer
{
    if (_backgroundLayer != backgroundLayer) {
        
        [self removeChild: _backgroundLayer];
        _backgroundLayer = backgroundLayer;
        [self addChild: _backgroundLayer z: GSLayerOrderBackground];
    }
}


- (void) setBoardLayer:(BoardLayer *)boardLayer
{
    if (_boardLayer != boardLayer) {
        [self removeChild: _boardLayer];
        _boardLayer = boardLayer;
        [self addChild: _boardLayer z: GSLayerOrderBoard];
    }
}


- (void) setBallLayer:(BallLayer *)ballLayer
{
    if (_ballLayer != ballLayer) {
        [self removeChild: _ballLayer];
        _ballLayer = ballLayer;
        [self addChild: _ballLayer z: GSLayerOrderBall];
    }
}


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
    groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, boxHeight), b2Vec2(boxWidth, boxHeight));
    groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(boxWidth, boxHeight), b2Vec2(boxWidth, 0));
    groundBody->CreateFixture(&edge, 0.0f);
    
    edge.Set(b2Vec2(0, 0), b2Vec2(boxWidth, 0));
    groundBody->CreateFixture(&edge, 0.0f);
}


#pragma mark - Update


-(void)afterStep {
	// process collisions and result from callbacks called by the step
}


- (void) update:(ccTime) dt
{
    float32 frameTime = dt;
	int stepsPerformed = 0;
	while ( (frameTime > 0.0) && (stepsPerformed < MAXIMUM_NUMBER_OF_STEPS) ){
		float32 deltaTime = std::min( frameTime, FIXED_TIMESTEP );
		frameTime -= deltaTime;
		if (frameTime < MINIMUM_TIMESTEP) {
			deltaTime += frameTime;
			frameTime = 0.0f;
		}
		_world->Step(deltaTime,VELOCITY_ITERATIONS,POSITION_ITERATIONS);
		stepsPerformed++;
		[self afterStep]; // process collisions and result from callbacks called by the step
	}
	_world->ClearForces ();
}

@end
