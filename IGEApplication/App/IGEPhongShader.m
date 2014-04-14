//
//  IGEPhongShader.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEPhongShader.h"

@interface IGEPhongShader () {
}

@end

@implementation IGEPhongShader

- (void)bindAttributeLocations:(GLuint)program
{
    glBindAttribLocation(_program, IGEVertexAttribPosition, "position");
    glBindAttribLocation(_program, IGEVertexAttribNormal, "normal");
    glBindAttribLocation(_program, IGEVertexAttribAmbientColor, "ambientColor");
    glBindAttribLocation(_program, IGEVertexAttribDiffuseColor, "diffuseColor");
}

- (void)getUniformLocations:(GLuint)program
{
    _uniforms[IGEShaderUniformWorldMatrix] = glGetUniformLocation(_program, "worldMatrix");
    _uniforms[IGEShaderUniformViewMatrix] = glGetUniformLocation(_program, "viewMatrix");
    _uniforms[IGEShaderUniformProjectionMatrix] = glGetUniformLocation(_program, "projectionMatrix");
    _uniforms[IGEShaderUniformAmbientLightColor] = glGetUniformLocation(_program, "ambientLightColor");
    _uniforms[IGEShaderUniformDiffuseLightColor] = glGetUniformLocation(_program, "diffuseLightColor");
    _uniforms[IGEShaderUniformDiffuseLightVector] = glGetUniformLocation(_program, "diffuseLightVector");
    _uniforms[IGEShaderUniformCameraPosition] = glGetUniformLocation(_program, "cameraPosition");
}

@end
