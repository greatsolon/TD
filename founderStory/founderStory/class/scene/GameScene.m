//
//  GameScene.m
//  founderStory
//
//  Created by yangjie on 6/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "MapFactory.h"

@implementation GameScene

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
	if ((self = [super init])) {
		// 添加地图层
		MapLayer *map = [[MapFactory getInstance] mapWithFactoryType:MapType1];
		map.position = ccp(0, 0);
		[self addChild:map];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

@end
