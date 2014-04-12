//
//  IGEAmbientShader.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEAmbientShader.h"

@interface IGEAmbientShader () {
}

@end

@implementation IGEAmbientShader

- (void)bindAttributeLocations:(GLuint)program
{
    glBindAttribLocation(_program, IGEVertexAttribPosition, "position");
    glBindAttribLocation(_program, IGEVertexAttribAmbientColor, "ambientColor");
}

- (void)getUniformLocations:(GLuint)program
{
    _uniforms[IGEShaderUniformWorldMatrix] = glGetUniformLocation(_program, "worldMatrix");
    _uniforms[IGEShaderUniformViewMatrix] = glGetUniformLocation(_program, "viewMatrix");
    _uniforms[IGEShaderUniformProjectionMatrix] = glGetUniformLocation(_program, "projectionMatrix");
    _uniforms[IGEShaderUniformAmbientLightColor] = glGetUniformLocation(_program, "ambientLightColor");
}

@end
