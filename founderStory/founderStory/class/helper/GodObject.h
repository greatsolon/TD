//
//  GodObject.h
//  founderStory
//
//  Created by yangjie on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

enum {
	ObjectActionINVALID = 0,
	ObjectActionUp,
	ObjectActionRight,
	ObjectActionDown,
	ObjectActionLeft,
	ObjectActionFight,
	ObjectActionConstraint,
	ObjectActionDead,
};
typedef NSUInteger ObjectAction;

@interface GodObject : CCNode {

@private
	NSArray *			m_resources;
}

@property (nonatomic, retain) NSArray *resources;

+ (id)objectWithResource:(NSArray *)resourceArray;

- (id)initWithResource:(NSArray *)resourceArray;

- (void)loadResource;

@end
