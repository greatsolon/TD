//
//  MapScene.h
//  founderStory
//
//  Created by yangjie on 6/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMapScene : CCLayer {
    CCAnimation *				m_ship1;
	CCAnimation *				m_ship2;
}

+ (CCScene *)scene;

@end
