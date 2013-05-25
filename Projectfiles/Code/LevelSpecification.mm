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


@interface LevelSpecification ()

@property (nonatomic, copy) NSString *levelName;
@property (nonatomic, copy) NSString *levelFilename;

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

@end
