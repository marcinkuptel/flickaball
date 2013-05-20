//
//  LevelPackSpecification.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import "LevelPackSpecification.h"
#import "LevelSpecification.h"

NSString * const LPSNameKey          = @"name";
NSString * const LPSLevelsFilename   = @"levelsFilename";

@interface LevelPackSpecification ()

@property (nonatomic, copy) NSString *levelPackName;
@property (nonatomic, copy) NSString *levelsFilename;
@property (nonatomic, strong) NSArray *levelSpecifications;

@end


@implementation LevelPackSpecification

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.levelPackName = dictionary[LPSNameKey];
        self.levelsFilename = dictionary[LPSLevelsFilename];
        self.levelSpecifications = [self levelSpecificationsWithLevelsFilename: self.levelsFilename];
    }
    return self;
}


- (NSArray*) levelSpecificationsWithLevelsFilename: (NSString*) levelsFilename
{
    NSParameterAssert(levelsFilename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: levelsFilename ofType: @"plist"];
    NSArray *rawLevelSpecifications = [NSArray arrayWithContentsOfFile: path];
    LevelSpecification *levelSpecification = nil;
    NSMutableArray *levelSpecifications = [@[] mutableCopy];
    
    for (NSDictionary *rawLevelSpecification in rawLevelSpecifications) {
        levelSpecification = [[LevelSpecification alloc] initWithDictionary: rawLevelSpecification];
        [levelSpecifications addObject: levelSpecification];
    }
    return [NSArray arrayWithArray: levelSpecifications];
}

@end
