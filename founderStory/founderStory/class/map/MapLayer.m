//
//  MapLayer.m
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"
#import "MapUILayer.h"
#import "ShaderNode.h"
#import "TowerObject.h"
#import "EnemyFactory.h"

@implementation MapLayer
@synthesize map = m_map;

- (id)init
{
	if ((self = [super init])) {
		// 加载所需资源
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ingame_gui.plist"];
		CGSize size = [[CCDirector sharedDirector] winSize];
		// 初始化地图对象
		m_map = [MapObject node];
		m_map.delegate = self;
		[self addChild:m_map];
		// 添加游戏逻辑层
		[self createTowerObject];
		// 添加控制层
		MapUILayer *controller = [MapUILayer node];
		controller.position = ccp(size.width * 0.5f, size.height * 0.5f);
		[self addChild:controller z:999];
		
		// 心跳shader
		ShaderNode *sn = [ShaderNode shaderNodeWithVertex:@"Heart.vsh" fragment:@"Heart.fsh" size:CGSizeMake(50, 50)];
		sn.position = ccp(40, size.height - 20);
		[self addChild:sn z:10];
		
		[self setIsTouchEnabled:YES];
	}
	return self;
}

- (void)dealloc
{
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"ingame_gui.plist"];
	[super dealloc];
}

#pragma mark - constraction function

- (void)loadResources
{
	[super load];
}

- (void)createTowerObject
{
	TowerObject *towerObject = [TowerObject node];
	towerObject.position = ccp(400, 340);
	NSAssert( towerObject.parent == nil, @"child already added. It can't be added again");
	[self addChild:towerObject z:999];
}

#pragma mark - war function

- (void)startWave:(int)wave
{
	EnemyObject *factory = [EnemyFactory enemiesWithType:EnemyTypeOrc];
	[self addChild:factory];
	
	[factory startRunWithWayPoint:m_map.wayPoint];
}

#pragma mark - MapObjectDelegate function

- (void)dataDidLoadOver
{
	[self startWave:1];
}

#pragma mark - touch function

- (void)registerWithTouchDispatcher {
	//重设点击吸收状态，设置优先级比ccmenuitem高（kCCMenuTouchPriority）
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-129 swallowsTouches:NO];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSArray *allTouches = [[event allTouches] allObjects];
	if ([allTouches count] == 1) {
//		UITouch *touchs = [allTouches objectAtIndex:0];
//		CGPoint touchLocation = [touchs locationInView:[touchs view]];
		//touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
		CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
		CCLOG(@"touch begin!!!%f -- %f", touchLocation.x, touchLocation.y);
		return YES;
	}
	return NO;
}

@end
