//
//  LevelConstructionDirector.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 26/05/13.
//
//

#import <Foundation/Foundation.h>
#import "LevelBuilder.h"

@class LevelSpecification;

/**
 This class constructs game levels by using builder
 objects.
 */
@interface LevelConstructionDirector : NSObject

- (id) initWithLevelBuilder: (id<LevelBuilder>) builder levelSpecification: (LevelSpecification*) levelSpecification;
- (void) construct;

@end
