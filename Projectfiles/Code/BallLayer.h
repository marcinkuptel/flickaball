//
//  BallLayers.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"

/**
 Class responsible for displaying and handling the logic
 behind the ball object
 */
@interface BallLayer : CCLayer {
    @private
    b2World *_world;
}

/**
 Initializes the ball layer with a world object where the ball will be placed.
 
 @param world Box2D world where the ball will be placed.
 */
- (id) initWithWorld: (b2World*) world;

@end
