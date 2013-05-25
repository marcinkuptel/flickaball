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
    NSString *name = @"Level pack name";
    NSString *levelsFilename = @"LevelPack1";
    NSDictionary *dictionary = @{@"name":name, @"levelsFilename": levelsFilename};
    LevelPackSpecification *levelPackSpecification = [[LevelPackSpecification alloc] initWithDictionary: dictionary];
    
    STAssertTrue([levelPackSpecification.levelPackName isEqualToString: name], @"Level name not initialized correctly!");
}


- (void) testThatWrongLevelsFilenameDoesNotCrashTheApp
{
    NSString *name = @"Level name";
    NSString *levelsFilename = @"sfergergrt";
    NSDictionary *dictionary = @{@"name" : name, @"levelsFilename" : levelsFilename};
    LevelPackSpecification *levelPackSpecification = [[LevelPackSpecification alloc] initWithDictionary: dictionary];
    
    STAssertTrue(levelPackSpecification != nil, @"Level pack specification not created!");
}


- (void) testThatACorrectNumberOfLevelSpecificationsWasLoaded
{
    NSString *name = @"Level pack name";
    NSString *levelsFilename = @"LevelPack3";
    NSDictionary *dictionary = @{@"name":name, @"levelsFilename": levelsFilename};
    LevelPackSpecification *levelPackSpecification = [[LevelPackSpecification alloc] initWithDictionary: dictionary];
    
    STAssertTrue([levelPackSpecification.levelSpecifications count] == 5, @"Incorrect number of level specifications!");
}

@end
