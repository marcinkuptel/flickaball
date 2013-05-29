//
//  BallLayers.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BallLayer.h"
#import "Ball.h"

#define MAX_BALL_DISTANCE_FROM_ORIGIN       100
#define MAX_TOUCH_DISTANCE_FROM_ORIGIN      300
#define BALL_SPEED_FACTOR                   300
#define BALL_LINEAR_DAMPING                 0.1

typedef NS_ENUM(NSUInteger, GLBallFlickState)
{
    GLBallFlickStateNone = 0,
    GLBallFlickStateAiming
};

@interface BallLayer()

@property (nonatomic, strong) Ball *ball;
@property (nonatomic, assign) GLBallFlickState ballFlickState;
@property (nonatomic, assign) CGPoint ballOrigin;

@end

@implementation BallLayer


- (id) initWithBall:(Ball *)ball
{
    self = [super init];
    if (self) {
        
        [self addChild: ball];
        self.ball = ball;
        self.ball.physicsBody->SetLinearDamping(BALL_LINEAR_DAMPING);
        
        //add touch delegate
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
    if (self.ballFlickState == GLBallFlickStateNone) {
        
        //stop ball movement
        self.ball.physicsBody->SetLinearVelocity(b2Vec2(0.0f,0.0f));
        self.ball.physicsBody->SetAngularVelocity(0);
        
        self.ballFlickState = GLBallFlickStateAiming;
        self.ballOrigin = [Helper locationFromTouch: touch];
    }
    
    return YES;
}


- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.ballFlickState == GLBallFlickStateAiming) {
        
        CGPoint touchLocation = [Helper locationFromTouch: touch];
        CGFloat distanceToOrigin = ccpDistance(self.ballOrigin, touchLocation);
        CGPoint ballLocation = CGPointZero;
        
        if (distanceToOrigin > MAX_TOUCH_DISTANCE_FROM_ORIGIN) {
            CGPoint normalized = ccpNormalize(ccpSub(touchLocation, self.ballOrigin));
            ballLocation = ccpAdd(self.ballOrigin, ccpMult(normalized, MAX_BALL_DISTANCE_FROM_ORIGIN));
        }else{
            CGFloat percent = distanceToOrigin/MAX_TOUCH_DISTANCE_FROM_ORIGIN;
            CGFloat ballDistanceFromOrigin = MAX_BALL_DISTANCE_FROM_ORIGIN * percent;
            CGPoint normalized = ccpNormalize(ccpSub(touchLocation, self.ballOrigin));
            ballLocation = ccpAdd(self.ballOrigin, ccpMult(normalized, ballDistanceFromOrigin));
        }
        
        self.ball.physicsBody->SetTransform([Helper toMeters:ballLocation], 0);
    }
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.ballFlickState == GLBallFlickStateAiming) {
        self.ballFlickState = GLBallFlickStateNone;
        
        CGPoint touchLocation = [Helper locationFromTouch: touch];
        CGPoint direction = ccpNeg(ccpNormalize(ccpSub(touchLocation, self.ballOrigin)));
        CGPoint ballPosition = [Helper toPixels: self.ball.physicsBody->GetWorldCenter()];
        CGFloat ballDistanceFromOrigin = ccpDistance(self.ballOrigin, ballPosition);
        CGFloat percentDistance = ballDistanceFromOrigin/MAX_BALL_DISTANCE_FROM_ORIGIN;
        
        b2Vec2 speedVector = b2Vec2(BALL_SPEED_FACTOR*direction.x*percentDistance, BALL_SPEED_FACTOR*direction.y*percentDistance);
        self.ball.physicsBody->ApplyLinearImpulse(speedVector, self.ball.physicsBody->GetWorldCenter());
    }
}



@end
