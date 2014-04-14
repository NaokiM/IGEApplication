//
//  IGEShader.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEShader.hh"

@interface IGEShader () {
}

- (BOOL)loadShaders:(NSString*)shaderName;
- (BOOL)compileShader:(GLuint*)shader type:(GLenum)type file:(NSString*)file;
- (BOOL)linkProgram:(GLuint)program;
- (BOOL)validateProgram:(GLuint)program;
- (void)printInfoOfProgram:(GLuint)program message:(NSString*)message;
- (void)printInfoOfShader:(GLuint)shader message:(NSString*)message;

@end

@implementation IGEShader

- (id)initWithName:(NSString*)shaderName
{
	self = [super init];
	if (!self) {
		return nil;
	}

	self.ID = shaderName.hash;

	IGE_VERIFY([self loadShaders:shaderName]);
	
	return self;
}

- (void)dealloc
{
	if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }

    [super dealloc];
}

- (BOOL)loadShaders:(NSString*)shaderName;
{
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    NSString* vertexShaderPath;
    vertexShaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"vsh"];
    GLuint vertexShader;
    if (![self compileShader:&vertexShader type:GL_VERTEX_SHADER file:vertexShaderPath]) {
        NSLog(@"Failed to compile vertex shader:%@", shaderName);
        return NO;
    }
    
    // Create and compile fragment shader.
    NSString* flagmentShaderPath;
    flagmentShaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"fsh"];
    GLuint flagmentShader;
    if (![self compileShader:&flagmentShader type:GL_FRAGMENT_SHADER file:flagmentShaderPath]) {
        NSLog(@"Failed to compile fragment shader:%@", shaderName);
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertexShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, flagmentShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
	[self bindAttributeLocations:_program];
	
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertexShader) {
            glDeleteShader(vertexShader);
            vertexShader = 0;
        }
        if (flagmentShader) {
            glDeleteShader(flagmentShader);
            flagmentShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }

	// clear uniforma locations.
	for (int i = 0; i < IGEShaderUniformMax; ++i) {
		_uniforms[i] = -1;
	}
	
    // Get uniform locations.
	[self getUniformLocations:_program];

    // Release vertex and fragment shaders.
    if (vertexShader) {
        glDetachShader(_program, vertexShader);
        glDeleteShader(vertexShader);
    }
    if (flagmentShader) {
        glDetachShader(_program, flagmentShader);
        glDeleteShader(flagmentShader);
    }
    
    return YES;
}

- (void)bindAttributeLocations:(GLuint)program
{
    glBindAttribLocation(_program, IGEVertexAttribPosition, "position");
    glBindAttribLocation(_program, IGEVertexAttribNormal, "normal");
    glBindAttribLocation(_program, IGEVertexAttribAmbientColor, "ambientColor");
}

- (void)getUniformLocations:(GLuint)program
{
    _uniforms[IGEShaderUniformWorldMatrix] = glGetUniformLocation(_program, "worldMatrix");
    _uniforms[IGEShaderUniformViewMatrix] = glGetUniformLocation(_program, "viewMatrix");
    _uniforms[IGEShaderUniformProjectionMatrix] = glGetUniformLocation(_program, "projectionMatrix");
    _uniforms[IGEShaderUniformAmbientLightColor] = glGetUniformLocation(_program, "ambientLightColor");
}

- (BOOL)compileShader:(GLuint*)shader type:(GLenum)type file:(NSString*)file
{
    const GLchar* source = (GLchar*)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
#if defined(DEBUG)
	[self printInfoOfShader:*shader message:@"Shader compile log"];
#endif
    
    GLint status;
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)program
{
    glLinkProgram(program);
#if defined(DEBUG)
	[self printInfoOfProgram:program message:@"Program link log"];
#endif
    
    GLint status;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)program
{
    glValidateProgram(program);
	[self printInfoOfProgram:program message:@"Program validate log"];

    GLint status;
    glGetProgramiv(program, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (void)printInfoOfProgram:(GLuint)program message:(NSString*)message
{
	GLint logLength;
	glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
	if (logLength > 0) {
		GLchar* buffer = (GLchar*)malloc(logLength);
		glGetProgramInfoLog(program, logLength, &logLength, buffer);
		NSLog(@"%@\n%s", message, buffer);
		free(buffer);
    }
}

- (void)printInfoOfShader:(GLuint)shader message:(NSString*)message
{
	GLint logLength;
	glGetProgramiv(shader, GL_INFO_LOG_LENGTH, &logLength);
	if (logLength > 0) {
		GLchar* buffer = (GLchar*)malloc(logLength);
		glGetShaderInfoLog(shader, logLength, &logLength, buffer);
		NSLog(@"%@\n%s", message, buffer);
		free(buffer);
    }
}

- (void)useProgram
{
	glUseProgram(_program);
}

- (void)setUniformWorldMatrix:(const GLKMatrix4)matrix
{
	if (_uniforms[IGEShaderUniformWorldMatrix] == -1) {
		return;
	}
    glUniformMatrix4fv(_uniforms[IGEShaderUniformWorldMatrix], 1, 0, matrix.m);
}

- (void)setUniformViewMatrix:(const GLKMatrix4)matrix
{
	if (_uniforms[IGEShaderUniformViewMatrix] == -1) {
		return;
	}
    glUniformMatrix4fv(_uniforms[IGEShaderUniformViewMatrix], 1, 0, matrix.m);
}

- (void)setUniformProjectionMatrix:(const GLKMatrix4)matrix
{
	if (_uniforms[IGEShaderUniformProjectionMatrix] == -1) {
		return;
	}
    glUniformMatrix4fv(_uniforms[IGEShaderUniformProjectionMatrix], 1, 0, matrix.m);
}

- (void)setUniformAmbientLightColor:(const GLKVector4)color
{
	if (_uniforms[IGEShaderUniformAmbientLightColor] == -1) {
		return;
	}
    glUniform4fv(_uniforms[IGEShaderUniformAmbientLightColor], 1, color.v);
}

- (void)setUniformDiffuseLightColor:(const GLKVector4)color
{
	if (_uniforms[IGEShaderUniformDiffuseLightColor] == -1) {
		return;
	}
    glUniform4fv(_uniforms[IGEShaderUniformDiffuseLightColor], 1, color.v);
}

- (void)setUniformDiffuseLightVector:(const GLKVector3)vector worldMatrix:(const GLKMatrix4)worldMatrix
{
	if (_uniforms[IGEShaderUniformDiffuseLightVector] == -1) {
		return;
	}
	// ライトベクトルに逆ワールド行列を掛けてモデル空間のベクトルにしてシェーダへ渡しています
	GLKVector3 temp = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(worldMatrix, NULL), GLKVector3Normalize(vector));
    glUniform3fv(_uniforms[IGEShaderUniformDiffuseLightVector], 1, temp.v);
}

- (void)setUniformCameraPosition:(const GLKVector3)cameraPosition worldMatrix:(const GLKMatrix4)worldMatrix
{
	if (_uniforms[IGEShaderUniformCameraPosition] == -1) {
		return;
	}
	// カメラ座標に逆ワールド行列を掛けてモデル空間の座標にしてシェーダへ渡しています
	GLKVector3 temp = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(worldMatrix, NULL), cameraPosition);
    glUniform3fv(_uniforms[IGEShaderUniformCameraPosition], 1, temp.v);
}

@end
