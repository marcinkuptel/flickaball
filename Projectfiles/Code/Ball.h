//
//  Ball.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 14/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BodySprite.h"

@interface Ball : BodySprite {
    
}

+ (id) ballWithWorld: (b2World*) world position: (CGPoint) position;

@end
