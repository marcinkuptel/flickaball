//
//  LevelLoader.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import "LevelLoader.h"
#import "LevelPackSpecification.h"

#define LEVEL_PACKS_FILENAME             @"LevelPacks"

@interface LevelLoader ()

@property (nonatomic, strong) NSString *levelPacksFilename;
@property (nonatomic, strong) NSArray *levelPackSpecifications;

@end

@implementation LevelLoader

+ (id) sharedLoader
{
    static LevelLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[LevelLoader alloc] initWithLevelPacksFilename: LEVEL_PACKS_FILENAME];
    });
    return loader;
}


- (id) initWithLevelPacksFilename: (NSString*) levelPacksFilename
{
    self = [super init];
    if (self) {
        self.levelPacksFilename = levelPacksFilename;
    }
    return self;
}

- (NSArray*) levelPackSpecificationsWithFilename: (NSString*) filename
{
    NSParameterAssert(filename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: filename ofType: @"plist"];
    
    if (path) {
        NSArray *rawSpecifications = [NSArray arrayWithContentsOfFile: path];
        
        if ([rawSpecifications isKindOfClass: [NSArray class]] == NO) {
            [NSException raise: NSInvalidArgumentException
                        format: @"Root object in the level pack file should be an array. It is %@", NSStringFromClass([rawSpecifications class])];
        }
        
        NSMutableArray *convertedSpecifications = [@[] mutableCopy];
        LevelPackSpecification *levelPackSpecification = nil;
        
        for (NSDictionary * rawSpecification in rawSpecifications) {
            
            levelPackSpecification = [[LevelPackSpecification alloc] initWithDictionary: rawSpecification];
            [convertedSpecifications addObject: levelPackSpecification];
        }
        return [NSArray arrayWithArray: convertedSpecifications];
    }else{
        return nil;
    }
}

#pragma mark - Accessors

- (NSArray*) levelPackSpecifications
{
    if (_levelPackSpecifications == nil) {
        _levelPackSpecifications = [self levelPackSpecificationsWithFilename: self.levelPacksFilename];
    }
    return _levelPackSpecifications;
}


@end
