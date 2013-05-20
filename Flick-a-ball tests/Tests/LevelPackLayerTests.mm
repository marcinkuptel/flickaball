//
//  LevelPackLayerTests.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import "LevelPackLayerTests.h"
#import "LevelPackLayer.h"
#import "LevelPackSpecification.h"
#import "OCMock.h"


@implementation LevelPackLayerTests


- (void) setUp
{
    [super setUp];
    
    [CCDirector sharedDirector];
}


- (void) testThatLayerSpecificationNameIsUsed
{
    id specification = [OCMockObject mockForClass: [LevelPackSpecification class]];
    [[[specification stub] andReturn: @"LevelPackName"] levelPackName];
    [[specification expect] levelPackName];
    LevelPackLayer *levelPackLayer = [[LevelPackLayer alloc] initWithLevelPackSpecification: specification];
    [specification verify];
    
}

@end
