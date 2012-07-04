//
//  GodObject.m
//  founderStory
//
//  Created by yangjie on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GodObject.h"


@implementation GodObject
@synthesize resources = m_resources;

+ (id)objectWithResource:(NSArray *)resourceArray
{
	return [[[self alloc] initWithResource:resourceArray] autorelease];
}

- (id)initWithResource:(NSArray *)resourceArray
{
	if ((self = [super init])) {
		self.resources = resourceArray;
		[self loadResource];
		self.anchorPoint = ccp(0.5f, 0.5f);
	}
	return self;
}

- (id)init
{
	if ((self = [super init])) {
		self.anchorPoint = ccp(0.5f, 0.5f);
	}
	return self;
}

- (void)dealloc
{
	if (self.resources) {
		for (NSString *fileName in self.resources) {
			[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:fileName];
		}
		self.resources = nil;
	}
	[super dealloc];
}

- (void)loadResource
{
	if (self.resources) {
		for (NSString *fileName in self.resources) {
			[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:fileName];
		}
	}
}

@end
