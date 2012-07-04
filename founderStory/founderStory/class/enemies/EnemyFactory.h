//
//  EnemyFactory.h
//  founderStory
//
//  Created by yangjie on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "EnemyObject.h"

@interface EnemyFactory : CCNode {
    
}

+ (EnemyObject *)enemiesWithType:(EnemyType)type;

@end
