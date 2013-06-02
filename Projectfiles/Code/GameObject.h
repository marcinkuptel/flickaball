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
#import "ContactListener.h"
#import "GameObjectRemover.h"

extern NSString * const GOParameterPositionKey;

@interface GameObject : BodySprite

@property (nonatomic, weak) id<GameObjectRemover> gameObjectRemover;

+ (GameObject*) objectWithShape: (NSString*) shapeName
                          world: (b2World*) world
                     parameters: (NSDictionary*) parameters;

@end
