//
//  TowerObject.m
//  founderStory
//
//  Created by yangjie on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TowerObject.h"


@implementation TowerObject

- (id)init
{
	if ((self = [super init])) {
		// 加载资源
		self.resources = [NSArray arrayWithObjects:@"towers.plist", @"gui_menu_sprite_3.plist", nil];
		[self loadResource];
		
		// 初始化一些变量
		m_level = 0;
		// 创建攻击范围sprite
		m_attackRangeCricle = [CCNode node];
		CCSprite *rangeCricle = [CCSprite spriteWithSpriteFrameName:@"range_circle.png"];
		rangeCricle.scaleY = 0.5f;
		[m_attackRangeCricle addChild:rangeCricle];
		
		CCLOG(@"cricle:%f", rangeCricle.boundingBox.size.width);
		
		CCSprite *rallyCricle = [CCSprite spriteWithSpriteFrameName:@"rally_circle.png"];
		rallyCricle.scaleY = 0.5f;
		[m_attackRangeCricle addChild:rallyCricle];
		
		m_attackRangeCricle.scale = 1.2f;
		[self addChild:m_attackRangeCricle];
		// 创建一个塔地基对象
		//CCSprite *foundationSpr = ;
		CCMenuItemImage *foundation = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"build_terrain_0001.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"build_terrain_0002.png"] block:^(id sender) {
			//TODO 
			[self toggleMenu];
		}];
		CCMenu *towers = [CCMenu menuWithItems:foundation, nil];
		towers.position = ccp(0, 0);
		NSAssert( towers.parent == nil, @"child already added. It can't be added again");
		[self addChild:towers];
		// add ring
		m_ring = [CCSprite spriteWithSpriteFrameName:@"gui_ring.png"];
		m_ring.visible = NO;
		// add ring item
		CCMenuItemImage *ringItem1 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0001.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0001.png"] target:self selector:@selector(updateTower:)];
		ringItem1.tag = 10;
		ringItem1.position = ccp(-50, 50);
		
		CCMenuItemImage *ringItem2 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0002.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0002.png"] target:self selector:@selector(updateTower:)];
		ringItem2.tag = 11;
		ringItem2.position = ccp(50, 50);
		
		CCMenuItemImage *ringItem3 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0003.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0003.png"] target:self selector:@selector(updateTower:)];
		ringItem3.tag = 12;
		ringItem3.position = ccp(50, -50);
		
		CCMenuItemImage *ringItem4 = [CCMenuItemImage itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0004.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"portraits_towers_0004.png"] target:self selector:@selector(updateTower:)];
		ringItem4.tag = 13;
		ringItem4.position = ccp(-50, -50);
		
		CCMenu *ringMenu = [CCMenu menuWithItems:ringItem1, ringItem2, ringItem3, ringItem4, nil];
		ringMenu.position = ccp(m_ring.position.x + m_ring.contentSize.width * 0.5f, m_ring.position.y + m_ring.contentSize.height * 0.5f);
		[m_ring addChild:ringMenu];
		[self addChild:m_ring];
	}
	return self;
}

- (void)dealloc
{
	
	[super dealloc];
}

#pragma mark - game logic function

- (void)toggleMenu
{
	if (m_ring.visible) {
		[self onBlur];
		return;
	}
	[self onFocus];
}

- (void)onFocus
{
	m_ring.visible = YES;
}

- (void)onBlur
{
	m_ring.visible = NO;
}

- (void)updateTower:(CCMenuItemImage *)item
{
	
}

@end
