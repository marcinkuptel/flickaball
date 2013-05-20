//
//  LevelLoader.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import <Foundation/Foundation.h>

@interface LevelLoader : NSObject

@property (nonatomic, readonly) NSArray *levelPackSpecifications;

+ (id) sharedLoader;

@end
