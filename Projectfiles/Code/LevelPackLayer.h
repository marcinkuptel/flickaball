//
//  LevelPackLayer.h
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 20/05/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

@class LevelPackSpecification;
@protocol LevelPackLayerDelegate;

@interface LevelPackLayer : CCLayer<CCTouchOneByOneDelegate>

@property (nonatomic, weak) id<LevelPackLayerDelegate> delegate;
@property (nonatomic, assign) NSUInteger index;

- (id) initWithLevelPackSpecification: (LevelPackSpecification*) levelPackSpecification;

@end


@protocol LevelPackLayerDelegate <NSObject>

@optional

- (void) didSelectLevelPackLayer: (LevelPackLayer*) layer;

@end
