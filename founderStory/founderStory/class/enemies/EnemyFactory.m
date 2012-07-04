//
//  EnemyFactory.m
//  founderStory
//
//  Created by yangjie on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyFactory.h"


@implementation EnemyFactory

+ (EnemyObject *)enemiesWithType:(EnemyType)type
{
	EnemyObject *obj = [EnemyObject initWithType:type];
	return obj;
}

- (void)dealloc
{
	[super dealloc];
}

@end
