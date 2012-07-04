//
//  MapFactory.h
//  founderStory
//
//  Created by yangjie on 6/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapLayer.h"

@interface MapFactory : NSObject {
    
}

+ (MapFactory *)getInstance;
// 根据工厂类型创建地图
- (MapLayer *)mapWithFactoryType:(MapType)type;

@end
