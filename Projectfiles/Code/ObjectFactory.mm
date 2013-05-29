//
//  ObjectConstructor.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import "ObjectFactory.h"
#import "ObjectRepository.h"
#import "GameObject.h"


NSString * const OFShapeKey         = @"shape";
NSString * const OFParametersKey    = @"parameters";

@interface ObjectFactory ()

@property (nonatomic, strong) ObjectRepository *objectRepository;
@property (nonatomic, strong) NSMutableDictionary *registeredClasses;

@end

@implementation ObjectFactory

+ (id) sharedFactory
{
    static ObjectFactory *objectFactory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objectFactory = [[ObjectFactory alloc] initWithObjectRepository: [ObjectRepository sharedRepository]];
    });
    return objectFactory;
}

- (id) initWithObjectRepository:(ObjectRepository *)objectRepository
{
    self = [super init];
    if (self) {
        self.objectRepository = objectRepository;
        self.registeredClasses = [@{} mutableCopy];
    }
    return self;
}


#pragma mark - Public methods

- (void) registerClass: (Class) objectClass forObjectID: (NSString*) objectID
{
    Class existingClass = self.registeredClasses[objectID];
    if (existingClass) {
        DLog(@"Class is already registered!");
        return;
    }
    
    self.registeredClasses[objectID] = objectClass;
}


- (GameObject*) constructGameObjectWithID: (NSString*) objectID world: (b2World*) world
{
    Class objectClass = self.registeredClasses[objectID];
    NSAssert1(objectClass, @"Class for ID %@ is not registered", objectID);
    
    NSDictionary *objectSpecification = [self.objectRepository gameObjectSpecificationWithID: objectID];
    NSAssert(objectSpecification, @"Object specification not available");
    
    if ([objectClass respondsToSelector: @selector(objectWithShape:world:parameters:)]) {
        GameObject *gameObject = [objectClass objectWithShape: objectSpecification[OFShapeKey]
                                                        world: world
                                                   parameters: objectSpecification[OFParametersKey]];
        return gameObject;
    }else{
        return nil;
    }
}

@end
