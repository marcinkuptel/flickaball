//
//  LevelPackSpecification.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import "LevelPackSpecification.h"

NSString * const LPSNameKey = @"name";


@interface LevelPackSpecification ()

@property (nonatomic, copy) NSString *levelPackName;

@end


@implementation LevelPackSpecification

- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.levelPackName = dictionary[LPSNameKey];
    }
    return self;
}

@end
