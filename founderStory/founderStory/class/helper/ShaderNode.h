//
//  ShaderHelper.h
//  founderStory
//
//  Created by yangjie on 7/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface ShaderNode : CCNode {
    ccVertex2F			m_center;
	ccVertex2F			m_resolution;
	float				m_time;
	CGSize				m_shaderSize;
	// shader专用
	GLuint				uniformCenter, uniformResolution, uniformTime;
}

+ (id)shaderNodeWithVertex:(NSString*)vert fragment:(NSString*)frag size:(CGSize)size;

- (id)initWithVertex:(NSString*)vert fragment:(NSString*)frag size:(CGSize)size;

- (void)loadShaderVertex:(NSString*)vert fragment:(NSString*)frag;

@end
