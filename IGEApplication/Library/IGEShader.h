//
//  IGEShader.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGEObject.h"

#define IGE_BUFFER_OFFSET(i)		((char*)NULL + (i))

//! 頂点アトリビュート
NS_ENUM(NSInteger, IGEVertexAttrib) {
	IGEVertexAttribPosition = 0,
	IGEVertexAttribNormal,
	IGEVertexAttribColor,
	IGEVertexAttribTexCoord0,
	IGEVertexAttribTexCoord1,
	IGEVertexAttribMax
};

//! シェーダユニフォーム
NS_ENUM(NSInteger, IGEShaderUniform) {
	IGEShaderUniformWorldMatrix = 0,
	IGEShaderUniformViewMatrix,
	IGEShaderUniformProjectionMatrix,
	IGEShaderUniformDiffuseLightColor,
	IGEShaderUniformDiffuseLightVector,
	IGEShaderUniformMax
};

//! シェーダ
@interface IGEShader : IGEObject {
	GLuint _program;
	GLint _uniforms[IGEShaderUniformMax];
}

- (id)initWithName:(NSString*)shaderName;
- (void)bindAttributeLocations:(GLuint)program;
- (void)getUniformLocations:(GLuint)program;
- (void)useProgram;
- (void)setUniformWorldMatrix:(const GLKMatrix4)matrix;
- (void)setUniformViewMatrix:(const GLKMatrix4)matrix;
- (void)setUniformProjectionMatrix:(const GLKMatrix4)matrix;
- (void)setUniformDiffuseLightColor:(const GLKVector4)color;
- (void)setUniformDiffuseLightVector:(const GLKVector3)vector worldMatrix:(const GLKMatrix4)worldMatrix;

@end