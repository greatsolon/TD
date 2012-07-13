//
//  EnemyObject.h
//  founderStory
//
//  Created by yangjie on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GodObject.h"
#import "cocos2d.h"

enum {
	EnemyTypeINVALID = 0,
	EnemyTypeGoblin,
	EnemyTypeOrc,
};
typedef NSUInteger EnemyType;

@interface EnemyObject : GodObject {
    
@private
	int						m_level;
	int						m_speed;
	int						m_attack;
	
	EnemyType				m_type;
	NSString *				m_enemyName;
	CCSprite *				m_enemySprite;
	
	int						m_pathIndex;
	NSArray	*				m_wayPoint;
	
	CGPoint					m_lastPoint;
	ObjectAction			m_action;
	
	CCAnimate *				m_runUpAnimate;
	CCAnimate *				m_runRightAnimate;
	CCAnimate *				m_runDownAnimate;
	CCAnimate *				m_runLeftAnimate;
	CCAnimate *				m_fightAnimate;
	CCAnimate *				m_constraintAnimate;
	CCAnimate *				m_deadAnimate;
}

@property (nonatomic, assign) EnemyType type;
@property (nonatomic, retain) NSArray *wayPoint;
@property (nonatomic, retain) CCAnimate *runUpAnimate;
@property (nonatomic, retain) CCAnimate *runRightAnimate;
@property (nonatomic, retain) CCAnimate *runDownAnimate;
@property (nonatomic, retain) CCAnimate *runLeftAnimate;
@property (nonatomic, retain) CCAnimate *fightAnimate;
@property (nonatomic, retain) CCAnimate *constraintAnimate;
@property (nonatomic, retain) CCAnimate *deadAnimate;

+ (EnemyObject *)initWithType:(EnemyType)type;

- (EnemyObject *)initWithType:(EnemyType)type;
// 初始化对象并加载资源
- (void)initializeObject;
// 创建敌人
- (void)constractionEnemies;
// 根据方向播放动画
- (void)playAnimationWithDirection:(ObjectAction)action;
// 设置waypoint并且开始寻路
- (void)startRunWithWayPoint:(NSArray *)wayPoint;
// 自动寻路函数
- (void)followPath;
// 销毁这个enemy对象
- (void)terminated;

@end
