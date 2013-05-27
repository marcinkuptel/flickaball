//
//  ObjectRepository.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import <Foundation/Foundation.h>

@class GameObject;

@interface ObjectRepository : NSObject

+ (id) sharedRepository;
- (NSDictionary*) gameObjectSpecificationWithID: (NSString*) objectID;

@end
