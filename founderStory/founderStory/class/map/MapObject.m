//
//  MapObject.m
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapObject.h"

@implementation MapObject
@synthesize delegate = m_delegate;
@synthesize type = m_type;
@synthesize wayPoint = m_wayPoint;
@synthesize towerPosition = m_towerPosition;

- (id)init
{
	if ((self = [super init])) {
		
	}
	return self;
}

- (void)dealloc
{
	self.wayPoint = nil;
	self.towerPosition = nil;
	[super dealloc];
}

#pragma mark - control logic function

- (void)loadResource
{
	[super loadResource];
	if (self.resources) {
		// 资源加载结束回调函数
		[self setBackgroundWithSprite:[CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"Stage_%d.png", self.type]]];
	}
	if (self.delegate && [self.delegate respondsToSelector:@selector(dataDidLoadOver)]) {
		[self.delegate dataDidLoadOver];
	}
}

- (void)setBackgroundWithSprite:(CCSprite *)backgroundSprite
{
	CGSize size = [[CCDirector sharedDirector] winSize];
	// 添加背景图
	backgroundSprite.position = ccp(size.width * 0.5f, size.height * 0.5f);
	[self addChild:backgroundSprite z:1];
}

- (void)resetMap
{
	
}

@end
