//
//  MapFactory.m
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapFactory.h"

@implementation MapFactory
static MapFactory *instance = nil;

+ (MapFactory *)getInstance
{
	@synchronized(self) {
		if (instance == nil) {
			instance = [[MapFactory alloc] init];
		}
	}
	return instance;
}

- (void)dealloc
{
	if (instance) {
		[instance release];
		instance = nil;
	}
	[super dealloc];
}

- (MapLayer *)mapWithFactoryType:(MapType)type
{
	MapLayer *map = [MapLayer node];
	NSArray *resources = nil;
	NSArray *wayPoint = nil;
	switch (type) {
		case MapType1:
		{
			// 加载所需资源
			resources = [NSArray arrayWithObjects:@"sprite_level1_2.plist", @"sprite_level1.plist", nil];
			// 加载路点数据
			wayPoint = [NSArray arrayWithObjects:@"{1024,320}", @"{948,320}", @"{858,320}", @"{782,290}", @"{736,236}", @"{664,212}", @"{588,226}", @"{528,232}", @"{430,224}", @"{354,236}", @"{282,296}", @"{282,384}", @"{330,426}", @"{412,454}", @"{462,490}", @"{490,564}", @"{482,654}", @"{488,734}", @"{484,780}", nil];
		}
			break;
		case MapType2:
		{
			// 加载所需资源
			resources = [NSArray arrayWithObjects:@"sprite_level2_2.plist", @"sprite_level2.plist", nil];
			// 加载路点数据
			wayPoint = [NSArray arrayWithObjects:@"{948,320}", @"{858,320}", @"{782,290}", @"{736,236}", @"{664,212}", @"{588,226}", @"{528,232}", @"{430,224}", @"{354,236}", @"{282,296}", @"{282,384}", @"{330,426}", @"{412,454}", @"{462,490}", @"{490,564}", @"{482,654}", @"{488,734}", @"{484,780}", nil];
		}
			break;
		default:
			break;
	}
	map.map.resources = resources;
	map.map.wayPoint = wayPoint;
	map.map.type = type;
	[map.map loadResource];
	return map;
}


@end
