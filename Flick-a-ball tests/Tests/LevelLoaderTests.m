//
//  LevelLoaderTests.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import "LevelLoaderTests.h"
#import "LevelLoader.h"

@implementation LevelLoaderTests

- (void) setUp
{
    [super setUp];
}

- (void) tearDown
{
    [super tearDown];
}


- (void) testLoadingLevelPackSpecifications
{
    NSArray *specifications = [[LevelLoader sharedLoader] levelPackSpecifications];
    STAssertTrue(specifications.count == 3, @"Wrong level pack specifications count!");
}

@end
