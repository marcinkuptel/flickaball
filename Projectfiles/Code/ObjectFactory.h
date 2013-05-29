//
//  ObjectConstructor.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import <Foundation/Foundation.h>
#import "Box2D.h"

@class GameObject;


@interface ObjectFactory : NSObject

+ (id) sharedFactory;
- (void) registerClass: (Class) objectClass forObjectID: (NSString*) objectID;
- (GameObject*) constructGameObjectWithID: (NSString*) objectID world: (b2World*) world;

@end
