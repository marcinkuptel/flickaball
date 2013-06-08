//
//  BoardLayer.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BoardLayer.h"
#import "PhysicsSprite.h"

@implementation BoardLayer

- (void) cleanup
{
    [super cleanup];
    
    for (PhysicsSprite *sprite in self.children) {
        sprite.physicsBody->GetWorld()->DestroyBody(sprite.physicsBody);
        sprite.physicsBody = NULL;
    }
}

@end
