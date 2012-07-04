//
//  MapObject.h
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GodObject.h"

enum {
	MapTypeINVALID = 0,
	MapType1,
	MapType2,
	MapType3,
	MapType4,
	MapType5,
};
typedef NSUInteger MapType;

@protocol MapObjectDelegate <NSObject>

@optional
- (void)dataDidLoadOver;

@end

@interface MapObject : GodObject {
@private
	id<MapObjectDelegate>		m_delegate;
	MapType						m_type;
	NSDictionary *				m_soundFile;
	
	int							m_coins;
	
	NSArray *					m_towerPosition;
    NSArray *					m_wayPoint;
	NSMutableArray *			m_waveInfo;
}

@property (nonatomic, assign) id<MapObjectDelegate> delegate;
@property (nonatomic, assign) MapType type;
@property (nonatomic, retain) NSArray *wayPoint;

// 重置地图数据
- (void)resetMap;
- (void)setBackgroundWithSprite:(CCSprite *)backgroundSprite;

@end
