//
//  HelloWorldLayer.m
//  founderStory
//
//  Created by yangjie on 6/26/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "MainScene.h"
#import "LoadingScene.h"

#pragma mark - HelloWorldLayer

@implementation MainScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		CGSize size = [[CCDirector sharedDirector] winSize];
		// 加载所需资源
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mainmenu_spritesheet_32_1.plist"];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mainmenu_spritesheet_32_2.plist"];
		
		// 添加背景
		CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"mainmenu_bg.png"];
		background.position = ccp(size.width * 0.5f, size.height * 0.5f);
		[self addChild:background];
		
		// 添加锁链及其移动效果
		CCMenuItemImage *loginButton = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"menu_startchain_0001.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"menu_startchain_0002.png"] block:^(id sender) {
			// 点击之后的代码
			[[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:LoadingSceneTypeMap]];
		}];
		CCMenu *menu = [CCMenu menuWithItems:loginButton, nil];
		menu.position = ccp(size.width * 0.5f, size.height * 0.5f + 100.0f);
		[self addChild:menu];
		CCMoveTo *buttonMove = [CCMoveTo actionWithDuration:0.5f position:ccp(size.width * 0.5f, size.height * 0.5f - 50.0f)];
		CCEaseBounceOut *bounceOut = [CCEaseBounceOut actionWithAction:buttonMove];
		[menu runAction:bounceOut];
		
		// 添加logo
		CCSprite *logo = [CCSprite spriteWithSpriteFrameName:@"logo.png"];
		logo.position =  ccp(size.width * 0.5f, size.height * 0.5f + logo.boundingBox.size.height * 0.5f);
		[self addChild:logo];
	}
	return self;
}

- (void) dealloc
{
	// 清除sprite帧缓存
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"mainmenu_spritesheet_32_1.plist"];
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"mainmenu_spritesheet_32_2.plist"];
	[super dealloc];
}

@end
