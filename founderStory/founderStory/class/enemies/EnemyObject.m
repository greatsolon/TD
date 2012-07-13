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
@synthesize runUpAnimate = m_runUpAnimate;
@synthesize runRightAnimate = m_runRightAnimate;
@synthesize runDownAnimate = m_runDownAnimate;
@synthesize runLeftAnimate = m_runLeftAnimate;
@synthesize fightAnimate = m_fightAnimate;
@synthesize constraintAnimate = m_constraintAnimate;
@synthesize deadAnimate = m_deadAnimate;

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
	self.runUpAnimate = nil;
	self.runRightAnimate = nil;
	self.runDownAnimate = nil;
	self.runLeftAnimate = nil;
	self.fightAnimate = nil;
	self.constraintAnimate = nil;
	self.deadAnimate = nil;
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
				m_enemyName = @"ogre";
			}
				break;
			default:
			{
				self.resources = [NSArray arrayWithObjects:@"enemies_goblins.plist", nil];
				m_enemyName = @"ogre";
			}
				break;
		}
		[self loadResource];
	}
	// 加载各种动画
	m_enemySprite = [CCSprite spriteWithSpriteFrameName:@"ogre_0001.png"];
	m_enemySprite.anchorPoint = ccp(0.5, 0);
	[self addChild:m_enemySprite];
}

- (void)playAnimationWithDirection:(ObjectAction)action
{
	if (m_action == action) return; // 如果已经在执行这个动画了，那么直接返回
	CCAnimate *animate = nil;
	m_action = action;
	NSString *animateFileName = [NSString stringWithFormat:@"%@_%@.png", m_enemyName, @"%04d"];
	switch (action) {
		case ObjectActionUp:
		{
			if (m_runUpAnimate == nil) {
				self.runUpAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:26 endNumber:50 andDuration:0.1f];
			}
			animate = m_runUpAnimate;
		}
			break;
		case ObjectActionRight:
		{
			if (m_runRightAnimate == nil) {
				self.runRightAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:2 endNumber:10 andDuration:0.1f];
			}
			animate = m_runRightAnimate;
			if (m_enemySprite.flipX) {
				m_enemySprite.flipX = NO;
			}
		}
			break;
		case ObjectActionDown:
		{
			if (m_runDownAnimate == nil) {
				self.runDownAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:53 endNumber:77 andDuration:0.1f];
			}
			animate = m_runDownAnimate;
		}
			break;
		case ObjectActionLeft:
		{
			if (m_runLeftAnimate == nil) {
				self.runLeftAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:2 endNumber:25 andDuration:0.1f];
			}
			animate = m_runLeftAnimate;
			if (!m_enemySprite.flipX) {
				m_enemySprite.flipX = YES;
			}
		}
			break;
		case ObjectActionFight:
		{
			if (m_fightAnimate == nil) {
				self.fightAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:78 endNumber:105 andDuration:0.1f];
			}
			animate = m_fightAnimate;
		}
			break;
		case ObjectActionConstraint:
		{
			if (m_constraintAnimate == nil) {
				self.constraintAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:107 endNumber:129 andDuration:0.1f];
			}
			animate = m_constraintAnimate;
		}
			break;
		case ObjectActionDead:
		{
			if (m_deadAnimate == nil) {
				self.deadAnimate = [AnimationHelper getAnimationForFrameName:animateFileName startNumber:130 endNumber:145 andDuration:0.1f];
			}
			animate = m_deadAnimate;
		}
			break;
		default:
			break;
	}
	[m_enemySprite stopAllActions];
	if (action != ObjectActionDead) {
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
		[m_enemySprite runAction:repeat];
	} else {
		[m_enemySprite runAction:animate];
	}
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
	
	if (m_pathIndex >= [self.wayPoint count]) {
		[self terminated];
		return;
	}
	NSString *wayPointString = [self.wayPoint objectAtIndex:m_pathIndex];
	if (wayPointString == nil) return;
	CGPoint point = CGPointFromString(wayPointString);
	if (m_lastPoint.x == 0 && m_lastPoint.y == 0) m_lastPoint = CGPointMake(point.x+1, point.y+1);
	++m_pathIndex;
	
	// 根据两点间距离以及speed计算当前duration
	CGFloat distance = ccpDistance(m_lastPoint, point);
	CGFloat duration = 1 / (50 / distance);
	//CCLOG(@"duration:%f - distance:%f", duration, distance);
	// 根据方向判断应该播放哪个动画
	CGPoint wapPointSub = ccpSub(point, m_lastPoint);
	if (fabs(wapPointSub.x) > fabs(wapPointSub.y)) {
		if (wapPointSub.x > 0) {
			[self playAnimationWithDirection:ObjectActionRight];
		} else if (wapPointSub.x < 0) {
			[self playAnimationWithDirection:ObjectActionLeft];
		}
	} else {
		if (wapPointSub.y > 0) {
			[self playAnimationWithDirection:ObjectActionUp];
		} else if (wapPointSub.y < 0) {
			[self playAnimationWithDirection:ObjectActionDown];
		}
	}
	
	CCMoveTo *actionMove = [CCMoveTo actionWithDuration:duration position:point];
	CCCallFuncN *actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(followPath)];
	[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	m_lastPoint = point;
}

- (void)terminated
{
	CCLOG(@"Enemy said:I'm release!");
//	[self stopAllActions];
//	[self removeFromParentAndCleanup:YES];
	// 目前先让他循环播放
	m_lastPoint = ccp(0, 0);
	m_pathIndex = 0;
	self.position = CGPointFromString([self.wayPoint objectAtIndex:0]);
	[self followPath];
}

@end
