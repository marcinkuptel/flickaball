//
//  BallLayers.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"

@class Ball;

/**
 Class responsible for displaying and handling the logic
 behind the ball object
 */
@interface BallLayer : CCLayer

- (id) initWithBall: (Ball*) ball;

@end
