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
	int				m_level;
	int				m_speed;
	int				m_attack;
	
	EnemyType		m_type;
	
	int				m_pathIndex;
	NSArray	*		m_wayPoint;
}

@property (nonatomic, assign) EnemyType type;
@property (nonatomic, retain) NSArray *wayPoint;

+ (EnemyObject *)initWithType:(EnemyType)type;

- (EnemyObject *)initWithType:(EnemyType)type;
// 初始化对象并加载资源
- (void)initializeObject;
// 创建敌人
- (void)constractionEnemies;
// 设置waypoint并且开始寻路
- (void)startRunWithWayPoint:(NSArray *)wayPoint;
// 自动寻路函数
- (void)followPath;
// 销毁这个enemy对象
- (void)terminated;

@end
