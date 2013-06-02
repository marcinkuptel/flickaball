//
//  GameObjectRemover.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 02/06/13.
//
//

#import <Foundation/Foundation.h>

@protocol GameObjectRemover <NSObject>

@required

- (void) markObjectForRemoval: (CCSprite*) gameObject;

@end
