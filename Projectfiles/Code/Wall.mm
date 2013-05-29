//
//  Wall.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 28/05/13.
//
//

#import "Wall.h"

@implementation Wall

+ (void) load
{
    [[ObjectFactory sharedFactory] registerClass: self
                                     forObjectID: FBWallObjectIdentifier];
}

+ (GameObject*) objectWithShape: (NSString *)shapeName
                          world: (b2World *)world
                     parameters: (NSDictionary *)parameters
{
    Wall *wall = [[Wall alloc] initWithShape: shapeName inWorld: world];
    return wall;
}

@end
