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


const float32 FIXED_TIMESTEP = 1.0f / 60.0f;

// Minimum remaining time to avoid box2d unstability caused by very small delta times
// if remaining time to simulate is smaller than this, the rest of time will be added to the last step,
// instead of performing one more single step with only the small delta time.
const float32 MINIMUM_TIMESTEP = 1.0f / 600.0f;

const int32 VELOCITY_ITERATIONS = 8;
const int32 POSITION_ITERATIONS = 8;

// maximum number of steps per tick to avoid spiral of death
const int32 MAXIMUM_NUMBER_OF_STEPS = 25;

typedef NS_ENUM(NSUInteger, GLBallFlickState)
{
    GLBallFlickStateNone = 0,
    GLBallFlickStateAiming
};


@interface GameplayLayer ()

@property (nonatomic, strong) Ball *ball;
@property (nonatomic, assign) GLBallFlickState ballFlickState;
@property (nonatomic, assign) CGPoint ballOrigin;

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
        
        
        //add touch delegate
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate: self
                                                                priority: 0
                                                         swallowsTouches: NO];
        
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


- (void) cleanup
{
    [super cleanup];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];
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


-(void)afterStep {
	// process collisions and result from callbacks called by the step
}

-(void)step:(ccTime)dt {
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



- (void) update:(ccTime) dt
{
    //It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
    
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
    //	world->Step(dt, velocityIterations, positionIterations);
	[self step:dt];
    
	//Iterate over the bodies in the physics world
	for (b2Body* b = _world->GetBodyList(); b; b = b->GetNext())
	{
		if (b->GetUserData() != NULL) {
			//Synchronize the AtlasSprites position and rotation with the corresponding body
			CCSprite *myActor = (__bridge CCSprite*)b->GetUserData();
			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO, b->GetPosition().y * PTM_RATIO);
			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
		}
	}
}


#pragma mark - Touches 


- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.ballFlickState == GLBallFlickStateNone) {
        
        self.ball.physicsBody->SetLinearVelocity(b2Vec2(0.0f,0.0f));
        self.ball.physicsBody->SetAngularVelocity(0);
        
        self.ballFlickState = GLBallFlickStateAiming;
        self.ballOrigin = [Helper locationFromTouch: touch];
    }
    
    return YES;
}


- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGFloat maxDistanceFromOrigin = 100;
    CGFloat maxTouchDistanceFromOrigin = 300;
    
    if (self.ballFlickState == GLBallFlickStateAiming) {
        CGPoint touchLocation = [Helper locationFromTouch: touch];
        CGFloat distanceToOrigin = ccpDistance(self.ballOrigin, touchLocation);
        CGPoint ballLocation = CGPointZero;
        
        if (distanceToOrigin > maxTouchDistanceFromOrigin) {
            CGPoint normalized = ccpNormalize(ccpSub(touchLocation, self.ballOrigin));
            ballLocation = ccpAdd(self.ballOrigin, ccpMult(normalized, maxDistanceFromOrigin));
        }else{
            CGFloat percent = distanceToOrigin/maxTouchDistanceFromOrigin;
            CGFloat ballDistanceFromOrigin = maxDistanceFromOrigin * percent;
            CGPoint normalized = ccpNormalize(ccpSub(touchLocation, self.ballOrigin));
            ballLocation = ccpAdd(self.ballOrigin, ccpMult(normalized, ballDistanceFromOrigin));
            
            NSLog(@"%f", ballDistanceFromOrigin);
        }
        
        self.ball.physicsBody->SetTransform([Helper toMeters:ballLocation], 0);
        
//        NSLog(@"%@", NSStringFromCGPoint(ballLocation));
//        NSLog(@"%f", distanceToOrigin);
    }
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.ballFlickState == GLBallFlickStateAiming) {
        self.ballFlickState = GLBallFlickStateNone;
        
        CGPoint touchLocation = [Helper locationFromTouch: touch];
        CGPoint direction = ccpNeg(ccpNormalize(ccpSub(touchLocation, self.ballOrigin)));
        CGFloat ballDistanceFromOrigin = ccpDistance(self.ball.position, self.ballOrigin);
        CGFloat percentDistance = ballDistanceFromOrigin/100;
        
        self.ball.physicsBody->ApplyLinearImpulse(b2Vec2(300*direction.x*percentDistance, 300*direction.y*percentDistance), self.ball.physicsBody->GetWorldCenter());
    }
}


#pragma mark - Others


- (void) addBall
{
    Ball *ball = [Ball ballWithWorld: _world position: [CCDirector sharedDirector].screenCenter];
    [self addChild: ball];
    self.ball = ball;
    self.ball.physicsBody->SetLinearDamping(0.1);
}


@end
