//
//  IGEShader.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGEObject.hh"

#define IGE_BUFFER_OFFSET(i)		((char*)NULL + (i))

//! 頂点アトリビュート
static NS_ENUM(NSInteger, IGEVertexAttrib) {
	IGEVertexAttribPosition = 0,
	IGEVertexAttribNormal,
	IGEVertexAttribAmbientColor,
	IGEVertexAttribDiffuseColor,
	IGEVertexAttribTexCoord0,
	IGEVertexAttribTexCoord1,
	IGEVertexAttribMax
};

//! シェーダユニフォーム
static NS_ENUM(NSInteger, IGEShaderUniform) {
	IGEShaderUniformWorldMatrix = 0,
	IGEShaderUniformViewMatrix,
	IGEShaderUniformProjectionMatrix,
	IGEShaderUniformAmbientLightColor,
	IGEShaderUniformDiffuseLightColor,
	IGEShaderUniformDiffuseLightVector,
	IGEShaderUniformCameraPosition,
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
- (void)setUniformAmbientLightColor:(const GLKVector4)color;
- (void)setUniformDiffuseLightColor:(const GLKVector4)color;
- (void)setUniformDiffuseLightVector:(const GLKVector3)vector worldMatrix:(const GLKMatrix4)worldMatrix;
- (void)setUniformCameraPosition:(const GLKVector3)cameraPosition worldMatrix:(const GLKMatrix4)worldMatrix;

@end
