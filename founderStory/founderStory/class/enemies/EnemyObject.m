//
//  EnemyObject.m
//  founderStory
//
//  Created by yangjie on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyObject.h"
#import "AnimationHelper.h"

@implementation EnemyObject
@synthesize type = m_type;
@synthesize wayPoint = m_wayPoint;

+ (EnemyObject *)initWithType:(EnemyType)type
{
	return [[[self alloc] initWithType:type] autorelease];
}

- (EnemyObject *)initWithType:(EnemyType)type
{
	if ((self = [super init])) {
		[self initializeObject];
		m_type = type;
		[self constractionEnemies];
	}
	return self;
}

- (id)init
{
	if ((self = [super init])) {
		[self initializeObject];
	}
	self.wayPoint = nil;
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark - private function

- (void)initializeObject
{
	// 初始化基础数据
	m_level = 1;
	m_speed = 1;
	m_attack = 1;
}

- (void)constractionEnemies
{
	// 根据敌人类型加载必要的资源
	if (m_type > 0) {
		switch (m_type) {
			case EnemyTypeGoblin:
			case EnemyTypeOrc:
			{
				self.resources = [NSArray arrayWithObjects:@"enemies_goblins.plist", nil];
			}
				break;
			default:
			{
				self.resources = [NSArray arrayWithObjects:@"enemies_goblins.plist", nil];
			}
				break;
		}
		[self loadResource];
	}
	// 加载各种动画
	m_enemySprite = [CCSprite spriteWithSpriteFrameName:@"ogre_0001.png"];
	m_enemySprite.anchorPoint = ccp(0.5, 0);
	[self addChild:m_enemySprite];
	[self playAnimationWithDirection:ObjectActionDown];
}

- (void)playAnimationWithDirection:(ObjectAction)action
{
	CCAnimate *animate = nil;
	m_action = action;
	switch (action) {
		case ObjectActionUp:
		{
			if (m_upAnimate == nil) {
				m_upAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:26 endNumber:50 andDuration:0.1f];
			}
			animate = m_upAnimate;
		}
			break;
		case ObjectActionRight:
		{
			if (m_rightAnimate == nil) {
				m_rightAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:2 endNumber:10 andDuration:0.1f];
			}
			animate = m_rightAnimate;
			if (m_flip.x < 0) {
				m_enemySprite.flipX = YES;
				m_flip.x *= -1; 
			}
		}
			break;
		case ObjectActionDown:
		{
			if (m_downAnimate == nil) {
				m_downAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:53 endNumber:77 andDuration:0.1f];
			}
			animate = m_downAnimate;
		}
			break;
		case ObjectActionLeft:
		{
			if (m_leftAnimate == nil) {
				m_leftAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:2 endNumber:25 andDuration:0.1f];
			}
			animate = m_leftAnimate;
			if (m_flip.x >= 0) {
				m_enemySprite.flipX = YES;
				m_flip.x *= -1; 
			}
		}
			break;
		case ObjectActionFight:
		{
			if (m_downAnimate == nil) {
				m_downAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:78 endNumber:105 andDuration:0.1f];
			}
			animate = m_downAnimate;
		}
			break;
		case ObjectActionConstraint:
		{
			if (m_downAnimate == nil) {
				m_downAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:107 endNumber:129 andDuration:0.1f];
			}
			animate = m_downAnimate;
		}
			break;
		case ObjectActionDead:
		{
			if (m_downAnimate == nil) {
				m_downAnimate = [AnimationHelper getAnimationForFrameName:@"ogre_%04d.png" startNumber:130 endNumber:145 andDuration:0.1f];
			}
			animate = m_downAnimate;
		}
			break;
		default:
			break;
	}
	[m_enemySprite stopAllActions];
	CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
	[m_enemySprite runAction:repeat];
}

- (void)startRunWithWayPoint:(NSArray *)wayPoint
{
	self.wayPoint = wayPoint;
	self.position = CGPointFromString([wayPoint objectAtIndex:0]);
	[self followPath];
}

- (void)followPath
{
	[self stopAllActions];
	
	if (m_pathIndex >= [self.wayPoint count]) return;
	NSString *wayPointString = [self.wayPoint objectAtIndex:m_pathIndex];
	if (wayPointString == nil) return;
	CGPoint point = CGPointFromString(wayPointString);
	if (m_lastPoint.x == 0 && m_lastPoint.y == 0) m_lastPoint = CGPointMake(point.x+1, point.y+1);
	++m_pathIndex;
	
	// 根据两点间距离以及speed计算当前duration
	CGFloat distance = ccpDistance(m_lastPoint, point);
	CGFloat duration = 1 / (50 / distance);
	//CCLOG(@"duration:%f - distance:%f", duration, distance);
	
	CCMoveTo *actionMove = [CCMoveTo actionWithDuration:duration position:point];
	CCCallFuncN *actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(followPath)];
	[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	m_lastPoint = point;
}

@end
