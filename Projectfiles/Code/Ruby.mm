//
//  Ruby.m
//  Flick-a-ball
//
//  Created by Marcin Kuptel on 02/06/13.
//
//

#import "Ruby.h"

@implementation Ruby

+ (void) load
{
    [[ObjectFactory sharedFactory] registerClass: self
                                     forObjectID: FBRubyObjectIdentifier];
}


+ (GameObject*) objectWithShape: (NSString *)shapeName
                          world: (b2World *)world
                     parameters: (NSDictionary *)parameters
{
    Ruby *ruby = [[Ruby alloc] initWithShape: shapeName
                                     inWorld: world];
    return ruby;
}


#pragma mark - Contacts

- (void) beginContactWithBall: (Contact*) contact
{
    CCParticleSystemQuad *startburst = [CCParticleSystemQuad particleWithFile: @"StarBurst.plist"];
    startburst.autoRemoveOnFinish = YES;
    startburst.position = self.boundingBoxCenter;
    [self.parent addChild: startburst];
    
    [self.gameObjectRemover markObjectForRemoval: self];
}


@end
