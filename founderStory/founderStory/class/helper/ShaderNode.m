//
//  ShaderHelper.m
//  founderStory
//
//  Created by yangjie on 7/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "ShaderNode.h"

@implementation ShaderNode

+ (id)shaderNodeWithVertex:(NSString*)vert fragment:(NSString*)frag size:(CGSize)size
{
	return [[[ShaderNode alloc] initWithVertex:vert fragment:frag size:size] autorelease];
}

- (id)initWithVertex:(NSString*)vert fragment:(NSString*)frag size:(CGSize)size
{
	if((self = [super init])) {
		m_shaderSize = size;
		[self loadShaderVertex:vert fragment:frag];
		
		m_time = 0;
		m_resolution = (ccVertex2F) {size.width, size.height};
		
		[self scheduleUpdate];
		
		[self setContentSize:CGSizeMake(size.width, size.height)];
		[self setAnchorPoint:ccp(0.5f, 0.5f)];
	}
	
	return self;
}

- (void)loadShaderVertex:(NSString*)vert fragment:(NSString*)frag
{
	CCGLProgram *shader = [[CCGLProgram alloc] initWithVertexShaderFilename:vert
													 fragmentShaderFilename:frag];
	
	[shader addAttribute:@"aVertex" index:kCCVertexAttrib_Position];
	
	[shader link];
	
	[shader updateUniforms];
	
	uniformCenter = glGetUniformLocation( shader->program_, "center");
	uniformResolution = glGetUniformLocation( shader->program_, "resolution");
	uniformTime = glGetUniformLocation( shader->program_, "time");
	
	self.shaderProgram = shader;
	
	[shader release];
}

- (void)update:(ccTime)dt
{
	m_time += dt;
}

- (void)setPosition:(CGPoint)newPosition
{
	[super setPosition:newPosition];
	m_center = (ccVertex2F) { position_.x * CC_CONTENT_SCALE_FACTOR(), position_.y * CC_CONTENT_SCALE_FACTOR() };
}

- (void)draw
{
	CC_NODE_DRAW_SETUP();
	float w = m_shaderSize.width, h = m_shaderSize.height;
	GLfloat vertices[12] = {0,0, w,0, w,h, 0,0, 0,h, w,h};
	glClearColor(0, 0, 0, 0);
	//
	// Uniforms
	//
	[shaderProgram_ setUniformLocation:uniformCenter withF1:m_center.x f2:m_center.y];
	[shaderProgram_ setUniformLocation:uniformResolution withF1:m_resolution.x f2:m_resolution.y];
	
	// time changes all the time, so it is Ok to call OpenGL directly, and not the "cached" version
	glUniform1f(uniformTime, m_time);
	//[shaderProgram_ setUniformLocation:uniformTime with1f:m_time];
	
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	glVertexAttribPointer(kCCVertexAttrib_Position, 2, GL_FLOAT, GL_FALSE, 0, vertices);
	
	glDrawArrays(GL_TRIANGLES, 0, 6);
	
	CC_INCREMENT_GL_DRAWS(1);
}

@end
