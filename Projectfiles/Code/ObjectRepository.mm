//
//  ObjectRepository.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import "ObjectRepository.h"

#define GAME_OBJECTS_FILENAME       @"GameObjects"

@interface ObjectRepository()

@property (nonatomic, strong) NSDictionary *gameObjects;

@end


@implementation ObjectRepository

+ (id) sharedRepository
{
    static ObjectRepository *repository;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        repository = [[ObjectRepository alloc] initWithGameObjectsFile: GAME_OBJECTS_FILENAME];
    });
    return repository;
}


- (id) initWithGameObjectsFile: (NSString*) gameObjectsFilename
{
    self = [super init];
    if (self) {
        self.gameObjects = [self loadGameObjectSpecificationsWithFilename: gameObjectsFilename];
    }
    return self;
}


- (NSDictionary*) loadGameObjectSpecificationsWithFilename: (NSString*) filename
{
    NSParameterAssert(filename);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: filename ofType: @"plist"];
    
    if (path) {
        
        NSDictionary *rootObject = [NSDictionary dictionaryWithContentsOfFile: path];
        
        if (![rootObject isKindOfClass: [NSDictionary class]]) {
            [NSException raise: NSInvalidArgumentException
                        format: @"Root object is not a dictionary. It is %@", NSStringFromClass([rootObject class])];
        }
        
        return rootObject;
    
    }else{
        return nil;
    }
}


#pragma mark - Public methods

- (NSDictionary*) gameObjectSpecificationWithID: (NSString*) objectID
{
    NSParameterAssert(objectID);
    
    NSDictionary *objectSpecification = self.gameObjects[objectID];
    return objectSpecification;
}

@end
