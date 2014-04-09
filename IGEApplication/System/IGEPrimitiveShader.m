//
//  IGEPrimitiveShader.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEPrimitiveShader.h"

@interface IGEPrimitiveShader () {
}

@end

@implementation IGEPrimitiveShader

- (void)bindAttributeLocations:(GLuint)program
{
    glBindAttribLocation(_program, IGEVertexAttribPosition, "position");
    glBindAttribLocation(_program, IGEVertexAttribNormal, "normal");
    glBindAttribLocation(_program, IGEVertexAttribColor, "color");
}

- (void)getUniformLocations:(GLuint)program
{
    _uniforms[IGEShaderUniformWorldMatrix] = glGetUniformLocation(_program, "worldMatrix");
    _uniforms[IGEShaderUniformViewMatrix] = glGetUniformLocation(_program, "viewMatrix");
    _uniforms[IGEShaderUniformProjectionMatrix] = glGetUniformLocation(_program, "projectionMatrix");
    _uniforms[IGEShaderUniformDiffuseLightColor] = glGetUniformLocation(_program, "diffuseLightColor");
    _uniforms[IGEShaderUniformDiffuseLightVector] = glGetUniformLocation(_program, "diffuseLightVector");
}

@end
