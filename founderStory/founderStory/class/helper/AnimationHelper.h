//
//  AnimationHelper.h
//  founderStory
//
//  Created by yangjie on 6/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface AnimationHelper : NSObject {
    
}

+ (CCAnimate *)getAnimationForFrameName:(NSString *)fileName startNumber:(int)start endNumber:(int)end andDuration:(float)duration;

@end
