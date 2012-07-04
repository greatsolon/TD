//
//  MapLayer.h
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "MapObject.h"

@interface MapLayer : CCLayer <MapObjectDelegate> {
@private
	MapObject *			m_map;
}

@property (nonatomic, readonly) MapObject *map;

- (void)createTowerObject;

- (void)startWave:(int)wave;

@end
