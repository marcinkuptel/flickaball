//
//  LevelPackSpecification.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//
//

#import <Foundation/Foundation.h>

@interface LevelPackSpecification : NSObject

@property (nonatomic, copy, readonly) NSString *levelPackName;
@property (nonatomic, strong, readonly) NSArray *levelSpecifications;

- (id) initWithDictionary: (NSDictionary*) dictionary;

@end
