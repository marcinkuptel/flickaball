//
//  GameObject.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 27/05/13.
//
//

#import "GameObject.h"

@implementation GameObject

+ (GameObject*) objectWithShape: (NSString*) shapeName
                          world: (b2World*) world
                     parameters: (NSDictionary*) parameters
{
    [NSException raise: @"Subclassing error"
                format: @"%@ should be onverriden.", NSStringFromSelector(_cmd)];
    return nil;
}

@end
