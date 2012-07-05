//
//  MapScene.m
//  founderStory
//
//  Created by yangjie on 6/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMapScene.h"
#import "LoadingScene.h"
#import "AnimationHelper.h"

@implementation MainMapScene

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMapScene *layer = [MainMapScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
	if ((self = [super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
		// 加载所需资源
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"map_spritesheet_32_2.plist"];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"map_spritesheet_32.plist"];
		
		CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"MapBackground.png"];
		background.position = ccp(size.width * 0.5f, size.height * 0.5f);
		[self addChild:background];
		
		// 构建两艘小船在地图上跑 (暂时只放一艘，另一艘需要时间搞)
		CCSprite *ship1 = [CCSprite spriteWithSpriteFrameName:@"mapDeco_ship2_0016.png"];
		ship1.position = ccp(280.0f, 140.0f);
		CCAnimate *ship1AnimationAction = [AnimationHelper getAnimationForFrameName:@"mapDeco_ship2_%04d.png" startNumber:17 endNumber:91 andDuration:0.05f];
		CCMoveTo *ship1Move = [CCMoveTo actionWithDuration:2.0f position:ccp(340.0f, 120.0f)];
		CCMoveTo *ship1Reverse = [CCMoveTo actionWithDuration:0.0f position:ccp(280.0f, 140.0f)];
		CCFadeIn *fadeIn1 = [CCFadeIn actionWithDuration:0.3f];
		CCSpawn *spawnAction = [CCSpawn actions:ship1AnimationAction, ship1Move, nil];
		CCSequence *seqAction = [CCSequence actions:spawnAction, ship1Reverse, fadeIn1, nil];
		CCRepeatForever *repeatAnimation = [CCRepeatForever actionWithAction:seqAction];
		[ship1 runAction:repeatAnimation];
		[self addChild:ship1];
		
		CCSprite *ship2 = [CCSprite spriteWithSpriteFrameName:@"mapDeco_ship1_0016.png"];
		ship2.position = ccp(200.0f, 110.0f);
		CCAnimate *ship2AnimationAction = [AnimationHelper getAnimationForFrameName:@"mapDeco_ship1_%04d.png" startNumber:17 endNumber:91 andDuration:0.03f];
		CCMoveTo *ship2Move = [CCMoveTo actionWithDuration:1.0f position:ccp(196.0f, 108.0f)];
		CCMoveTo *ship2Reverse = [CCMoveTo actionWithDuration:0.0f position:ccp(140.0f, 60.0f)];
		CCMoveTo *ship2MoveBack = [CCMoveTo actionWithDuration:2.0f position:ccp(196.0f, 108.0f)];
		CCFadeOut *fadeOut2 = [CCFadeOut actionWithDuration:0.0f];
		CCFadeIn *fadeIn2 = [CCFadeIn actionWithDuration:0.6f];
		CCSpawn *spawnAction2 = [CCSpawn actions:ship2AnimationAction, ship2Move, nil];
		CCSequence *seqAction2 = [CCSequence actions:spawnAction2, ship2Reverse, fadeOut2, fadeIn2, ship2MoveBack, nil];
		CCRepeatForever *repeatAnimation2 = [CCRepeatForever actionWithAction:seqAction2];
		[ship2 runAction:repeatAnimation2];
		[self addChild:ship2];
		
		// 添加各种按钮
		CCMenuItemImage *flag1 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mapFlag_0110.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mapFlag_0033.png"] block:^(id sender) {
			// 点击了第一个按钮的事件, 开始游戏
			[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:LoadingSceneTypeGame]];
		}];
		flag1.tag = 1;
		flag1.position = ccp(-260.0f, -80.0f);
		
		CCMenuItemImage *backButton = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"mapButtonBack_0001.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"mapButtonBack_0002.png"] block:^(id sender) {
			// 返回按钮点击事件
			[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:LoadingSceneTypeMain]];
		}];
		backButton.position = ccp(size.width * 0.5f - backButton.boundingBox.size.width, size.height * 0.5f - backButton.boundingBox.size.height);
		CCMenu *mainMenu = [CCMenu menuWithItems:backButton, flag1, nil];
		mainMenu.position = ccp(size.width * 0.5f, size.height * 0.5f);
		[self addChild:mainMenu];
	}
	return self;
}

- (void)dealloc
{
	// 释放无用资源
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"map_spritesheet_32_2.plist"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"map_spritesheet_32.plist"];
	[super dealloc];
}

@end
