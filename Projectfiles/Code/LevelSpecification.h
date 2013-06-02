//
//  LevelSpecification.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 19/05/13.
//
//

#import <Foundation/Foundation.h>

@interface LevelSpecification : NSObject

@property (nonatomic, strong, readonly) NSArray *worldObjects;
@property (nonatomic, strong, readonly) NSDictionary *ballParameters;

- (id) initWithDictionary: (NSDictionary*) dictionary;

@end
