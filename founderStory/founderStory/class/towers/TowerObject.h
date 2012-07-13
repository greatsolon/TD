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
	CCSprite *				m_ring; // 塔的选择环
	int						m_level; // 当前塔的等级
	
	CGFloat *				m_range; // 塔的攻击范围
	CCNode *				m_attackRangeCricle;
}
// 当前塔获得焦点事件
- (void)onFocus;
// 当前塔取消焦点事件
- (void)onBlur;
// 显示/隐藏当前塔的菜单
- (void)toggleMenu;
// 点击升级按钮
- (void)updateTower:(CCMenuItemImage *)item;

@end
