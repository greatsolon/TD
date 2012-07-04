//
//  AnimationHelper.m
//  founderStory
//
//  Created by yangjie on 6/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AnimationHelper.h"


@implementation AnimationHelper

+ (CCAnimate *)getAnimationForFrameName:(NSString *)fileName startNumber:(int)start endNumber:(int)end andDuration:(float)duration
{
	NSMutableArray *frames = [NSMutableArray array];
	CCSpriteFrame *spriteFrame = nil;
	for (int i = start; i < end; i++) {
		spriteFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:fileName, i]];
		if (spriteFrame) {
			[frames addObject:spriteFrame];
		}
	}
	CCAnimation *animation = [CCAnimation animationWithSpriteFrames:frames delay:duration];
	animation.restoreOriginalFrame = YES;
	return [CCAnimate actionWithAnimation:animation];
}

@end
