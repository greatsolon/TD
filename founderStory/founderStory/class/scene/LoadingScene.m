//
//  LoadingScene.m
//  founderStory
//
//  Created by yangjie on 6/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"
#import "MainScene.h"
#import "MapScene.h"
#import "GameScene.h"

@implementation LoadingScene

+ (id)sceneWithTargetScene:(LoadingSceneType)type
{
	return [[[self alloc] initWithTargetScene:type] autorelease];
}

- (id)initWithTargetScene:(LoadingSceneType)type
{
	if ((self = [super init])) {
		m_type = type;
		[self playLoadingAnimation];
	}
	return self;
}

- (void)playLoadingAnimation
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	// 构建左右侧的门
	CCSprite *leftDoor = [CCSprite spriteWithSpriteFrameName:@"transitionDoor.png"];
	int halfDoorWidth = leftDoor.boundingBox.size.width * 0.5f;
	int halfWindowHeight = winSize.height * 0.5f;
	CCSprite *leftLoading = [CCSprite spriteWithSpriteFrameName:@"transitionLoading_left.png"];
	leftLoading.position = ccp(leftDoor.boundingBox.size.width - leftLoading.boundingBox.size.width * 0.5f, halfWindowHeight);
	[leftDoor addChild:leftLoading];
	CCSprite *rightDoor = [CCSprite spriteWithSpriteFrameName:@"transitionDoor.png"];
	rightDoor.flipX = YES; // 因为左右侧门是同一个精灵，提前翻转x，以防忘记
	CCSprite *rightLoading = [CCSprite spriteWithSpriteFrameName:@"transitionLoading_right.png"];
	rightLoading.position = ccp(rightLoading.boundingBox.size.width * 0.5f, halfWindowHeight);
	[rightDoor addChild:rightLoading];
	leftDoor.position = ccp(-halfDoorWidth, halfWindowHeight);
	rightDoor.position = ccp(winSize.width + halfDoorWidth, halfWindowHeight);
	[self addChild:leftDoor];
	[self addChild:rightDoor];
	
	// 开始播放关门动画
	CCMoveTo *leftMove = [CCMoveTo actionWithDuration:0.3f position:ccp(halfDoorWidth, halfWindowHeight)];
	CCMoveTo *rightMove = [CCMoveTo actionWithDuration:0.3f position:ccp(winSize.width - halfDoorWidth, halfWindowHeight)];
	[leftDoor runAction:leftMove];
	[rightDoor runAction:rightMove];
	
	[self performSelector:@selector(replaceToScene) withObject:nil afterDelay:1.0f];
}

- (void)replaceToScene
{
	// 加载目标scene
	CCScene *scene = nil;
	switch (m_type) {
		case LoadingSceneTypeMain:
		{
			scene = [MainScene scene];
		}
			break;
		case LoadingSceneTypeMap:
		{
			scene = [MapScene scene];
		}
			break;	
		case LoadingSceneTypeGame:
		{
			scene = [GameScene scene];
		}
			break;
		default:
		{
			scene = [MainScene scene];
		}
			break;
	}
	[[CCDirector sharedDirector] replaceScene:scene];
}

@end
