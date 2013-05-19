//
//  LevelLoader.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import "LevelLoader.h"
#import "LevelSpecification.h"

#define LEVELS_FILENAME             @"Levels"

@interface LevelLoader ()

@property (nonatomic, strong) NSString *levelsFilename;

@end

@implementation LevelLoader

+ (id) sharedLoader
{
    static LevelLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[LevelLoader alloc] initWithLevelsFilename: LEVELS_FILENAME];
    });
    return loader;
}


- (id) initWithLevelsFilename: (NSString*) levelsFilename
{
    self = [super init];
    if (self) {
        _levelsFilename = levelsFilename;
    }
    return self;
}

#pragma mark - Public methods

- (NSUInteger) numberOfLevels
{
    
}


- (LevelSpecification*) levelSpecificationAtIndex:(NSUInteger)index
{
    
}

@end
