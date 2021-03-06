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
    }
    return self;
}


- (NSArray*) levelSpecificationsWithLevelsFilename: (NSString*) levelsFilename
{
    NSParameterAssert(levelsFilename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: levelsFilename ofType: @"plist"];
    
    if (path) {
        NSArray *rawLevelSpecifications = [NSArray arrayWithContentsOfFile: path];
        
        if ([rawLevelSpecifications isKindOfClass: [NSArray class]] == NO) {
            [NSException raise: NSInvalidArgumentException
                        format: @"Level specifications file root object should be an array. It is %@", NSStringFromClass([rawLevelSpecifications class])];
        }
        
        LevelSpecification *levelSpecification = nil;
        NSMutableArray *levelSpecifications = [@[] mutableCopy];
        
        for (NSDictionary *rawLevelSpecification in rawLevelSpecifications) {
            levelSpecification = [[LevelSpecification alloc] initWithDictionary: rawLevelSpecification];
            [levelSpecifications addObject: levelSpecification];
        }
        return [NSArray arrayWithArray: levelSpecifications];
    }else{
        return nil;
    }
}


#pragma mark - Accessors

- (NSArray*) levelSpecifications
{
    if (_levelSpecifications == nil) {
        _levelSpecifications = [self levelSpecificationsWithLevelsFilename: self.levelsFilename];
    }
    return _levelSpecifications;
}

@end
