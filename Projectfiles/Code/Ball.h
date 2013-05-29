//
//  Ball.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 14/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

/**
 Class representing the ball object.
 */
@interface Ball : GameObject {
    
}

/**
 Creates a new ball object and adds it to the _world_.
 
 @param world Box2D world where the newly created ball should be placed.
 @param position Position of the created ball object.
 @return A new ball object.
 */
+ (id) ballWithWorld: (b2World*) world position: (CGPoint) position;

@end
