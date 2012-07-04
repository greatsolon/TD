//
//  TowerObject.h
//  founderStory
//
//  Created by yangjie on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GodObject.h"

@interface TowerObject : GodObject {
    
@private
	CCSprite *				m_ring;
	int						m_level;
}
// 显示/隐藏购买环
- (void)toggleRing;
// 点击升级按钮
- (void)updateTower:(CCMenuItemImage *)item;

@end
