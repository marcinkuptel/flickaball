//
//  LevelPackSpecificationTests.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import "LevelPackSpecificationTests.h"
#import "LevelPackSpecification.h"

@implementation LevelPackSpecificationTests

- (void) testThatLevelNameIsCorrectlyInitialized
{
    NSString *name = @"Level name";
    NSDictionary *dictionary = @{@"name":name};
    LevelPackSpecification *levelPackSpecification = [[LevelPackSpecification alloc] initWithDictionary: dictionary];
    STAssertTrue([levelPackSpecification.levelPackName isEqualToString: name], @"Level name not initialized correctly!");
}

@end
