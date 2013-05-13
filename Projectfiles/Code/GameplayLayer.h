//
//  GameplayLayer.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"
#import "GLES-Render.h"

@interface GameplayLayer : CCLayer {
    @private
    b2World *_world;
    GLESDebugDraw* _debugDraw;
}

@end
