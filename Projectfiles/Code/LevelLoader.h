//
//  LevelLoader.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import <Foundation/Foundation.h>

@class LevelSpecification;

@interface LevelLoader : NSObject

+ (id) sharedLoader;

- (NSUInteger) numberOfLevels;
- (LevelSpecification*) levelSpecificationAtIndex: (NSUInteger) index;

@end
