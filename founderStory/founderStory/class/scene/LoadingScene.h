//
//  LoadingScene.h
//  founderStory
//
//  Created by yangjie on 6/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum {
	LoadingSceneTypeINVALID = 0,
	LoadingSceneTypeMain,
	LoadingSceneTypeMap,
	LoadingSceneTypeGame,
};
typedef NSUInteger LoadingSceneType;


@interface LoadingScene : CCScene {
    LoadingSceneType				m_type;
}

+ (id)sceneWithTargetScene:(LoadingSceneType)type;

- (id)initWithTargetScene:(LoadingSceneType)type;

- (void)playLoadingAnimation;

@end
