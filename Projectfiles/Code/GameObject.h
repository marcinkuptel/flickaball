//
//  GameObject.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 27/05/13.
//
//

#import "BodySprite.h"
#import "ObjectFactory.h"
#import "ObjectIdentifiers.h"

@interface GameObject : BodySprite

+ (GameObject*) objectWithShape: (NSString*) shapeName
                          world: (b2World*) world
                     parameters: (NSDictionary*) parameters;

@end
