//
//  LevelSpecification.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import "LevelSpecification.h"

NSString * const LSLevelNameKey     = @"levelName";
NSString * const LSLevelFilenameKey = @"levelFile";

//Level file keys
NSString * const LSWorldObjectsKey = @"worldObjects";


@interface LevelSpecification ()

@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *levelFilename;
@property (nonatomic, strong) NSArray *worldObjects;

@end

@implementation LevelSpecification

- (id) initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self) {
        self.levelName = dictionary[LSLevelNameKey];
        self.levelFilename = dictionary[LSLevelFilenameKey];
    }
    return self;
}


- (void) loadLevelSpecificationFromFile: (NSString*) filename
{
    NSParameterAssert(filename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: filename
                                                     ofType: @"plist"];
    
    if (path) {
        NSDictionary *rootObject = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if (![rootObject isKindOfClass: [NSDictionary class]]) {
            [NSException raise: NSInvalidArgumentException
                        format: @"Level file root object is not a dictionary. It is %@", NSStringFromClass([rootObject class])];
        }
        
        self.worldObjects = rootObject[LSWorldObjectsKey];
    }
}


#pragma mark - Accessors

- (NSArray*) worldObjects
{
    if (_worldObjects == nil) {
        [self loadLevelSpecificationFromFile: self.levelFilename];
    }
    return _worldObjects;
}

@end
