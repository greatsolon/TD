//
//  MapUIController.m
//  founderStory
//
//  Created by yangjie on 7/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapUILayer.h"
#import "LoadingScene.h"

@implementation MapUILayer

- (id)init
{
	if ((self = [super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
		// 添加hud界面
		CCSprite *hud = [CCSprite spriteWithSpriteFrameName:@"hud_background.png"];
		hud.position = ccp(-size.width * 0.5f + hud.boundingBox.size.width * 0.5f + 50, size.height * 0.5f - hud.boundingBox.size.height * 0.5f - 20);
		[self addChild:hud];
		// 返回地图界面按钮
		CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"hud_buttons_0001.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"hud_buttons_0002.png"] block:^(id sender) {
			// 返回按钮点击事件
			[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:LoadingSceneTypeMap]];
		}];
		backButton.position = ccp(size.width * 0.5f - backButton.boundingBox.size.width * 0.5f, size.height * 0.5f - backButton.boundingBox.size.height * 0.5f);
		CCMenu *mainMenu = [CCMenu menuWithItems:backButton, nil];
		mainMenu.position = ccp(0, 0);
		[self addChild:mainMenu];
		
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

@end
