//
//  EnemyObject.m
//  founderStory
//
//  Created by yangjie on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyObject.h"


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
	CCSprite *enemySprite = [CCSprite spriteWithSpriteFrameName:@"ogre_0003.png"];
	[self addChild:enemySprite];
}

- (void)startRunWithWayPoint:(NSArray *)wayPoint
{
	self.wayPoint = wayPoint;
	[self followPath];
}

- (void)followPath
{
	[self stopAllActions];
	
	if (m_pathIndex >= [self.wayPoint count]) return;
	NSString *wayPointString = [self.wayPoint objectAtIndex:m_pathIndex];
	if (wayPointString == nil) return;
	CGPoint point = CGPointFromString(wayPointString);
	if (m_pathIndex == 0) {
		self.position = point;
	}
	
	CCMoveTo *actionMove = [CCMoveTo actionWithDuration:m_speed position:point];
	CCCallFuncN *actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(followPath)];
	[self runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	++m_pathIndex;
}

@end
