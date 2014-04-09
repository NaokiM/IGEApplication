//
//  IGETestUnit.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGETestUnit.h"

@interface IGETestUnit () {
	GLuint _vertexArray;
	GLuint _vertexBuffer;
	float _rotate;
}

@end

@implementation IGETestUnit

GLfloat gCubeVertexData[360] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
     0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f, -0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f, -0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f,  0.5f,        1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    
     0.5f,  0.5f, -0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f, -0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f,  0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f,  0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f, -0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,        0.0f, 1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    
    -0.5f,  0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,       -1.0f, 0.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    
    -0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,        0.0f, -1.0f, 0.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    
     0.5f,  0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f, -0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f,  0.5f,        0.0f, 0.0f, 1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    
     0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
     0.5f,  0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f,
    -0.5f,  0.5f, -0.5f,        0.0f, 0.0f, -1.0f,         0.5f, 0.5f, 1.0f, 1.0f
};

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	self.cameraID = @"DefaultCamera".hash;
	self.lightID = @"DefaultLight".hash;
	self.shaderID = @"AmbientShader".hash;
	
	glGenVertexArraysOES(1, &_vertexArray);
	glBindVertexArrayOES(_vertexArray);
	
	glGenBuffers(1, &_vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
	
	glEnableVertexAttribArray(IGEVertexAttribPosition);
	glVertexAttribPointer(IGEVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 10*sizeof(float), IGE_BUFFER_OFFSET(0*sizeof(float)));
	glEnableVertexAttribArray(IGEVertexAttribNormal);
	glVertexAttribPointer(IGEVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 10*sizeof(float), IGE_BUFFER_OFFSET(3*sizeof(float)));
	glEnableVertexAttribArray(IGEVertexAttribAmbientColor);
	glVertexAttribPointer(IGEVertexAttribAmbientColor, 4, GL_FLOAT, GL_FALSE, 10*sizeof(float), IGE_BUFFER_OFFSET(6*sizeof(float)));
	
	glBindVertexArrayOES(0);
	
	return self;
}

- (void)dealloc
{
	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteVertexArraysOES(1, &_vertexArray);
	
    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	IGECamera* camera = [[IGECameraManager getInstance] findCameraByID:self.cameraID];
	IGE_NULL_ASSERT(camera);
	
	GLKVector3 position;
	position.x = sinf(degreeToRadian(_rotate)) * 10.0f;
	position.y = 0.0f;
	position.z = cosf(degreeToRadian(_rotate)) * 10.0f;
//	camera.positon = position;

	GLKMatrix4 xTranslateMatrix;
	GLKMatrix4 xRotateMatrix;
	GLKMatrix4 yRotateMatrix;

	xTranslateMatrix = GLKMatrix4MakeTranslation(1, 0, 0);
	xRotateMatrix = GLKMatrix4MakeXRotation(degreeToRadian(_rotate));
	yRotateMatrix = GLKMatrix4MakeYRotation(degreeToRadian(_rotate));

//	self.worldMatrix = GLKMatrix4Multiply(GLKMatrix4Multiply(xRotateMatrix, yRotateMatrix), xTranslateMatrix);
//	self.worldMatrix = yRotateMatrix;

	IGELight* light = [[IGELightManager getInstance] findLightByID:self.lightID];
	IGE_NULL_ASSERT(light);

	GLKVector3 vector;
	vector.x = sinf(degreeToRadian(_rotate));
	vector.y = 0.0f;
	vector.z = cosf(degreeToRadian(_rotate));
	light.diffuseLightVector = vector;

	_rotate += 200 * time;
	if (_rotate > 360) {
		_rotate = 0;
	}
}

- (void)render
{
	glBindVertexArrayOES(_vertexArray);
    glDrawArrays(GL_TRIANGLES, 0, 36);
}

@end
