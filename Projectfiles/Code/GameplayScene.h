//
//  GameplayScene.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 13/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"
#import "GameObjectRemover.h"

@class BackgroundLayer;
@class BallLayer;
@class BoardLayer;
@class ControlsLayer;

/**
 This scene is responsible for creating the world object and advancing
 the physics simulation.
 */
@interface GameplayScene : CCScene <GameObjectRemover>{
    @private
    b2World *_world;
    ContactListener *_contactListener;
    GLESDebugDraw* _debugDraw;
}

@property (nonatomic, readonly) b2World *world;
@property (nonatomic, strong) BackgroundLayer *backgroundLayer;
@property (nonatomic, strong) BoardLayer *boardLayer;
@property (nonatomic, strong) BallLayer *ballLayer;
@property (nonatomic, strong) ControlsLayer *controlsLayer;

@end
