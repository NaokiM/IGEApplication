//
//  IGESphereUnit.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "../Library/IGELineStream.hh"
#import "IGESphereUnit.hh"

struct VertexInfo {
	IGEVector3 position;
	IGEVector3 normal;
	IGEVector4 ambient;
	IGEVector4 diffuse;
};

@interface IGESphereUnit () {
	GLuint _vertexArray;
	GLuint _vertexBuffer;
	float _rotate;

	int _horizontalDiv;
	int _verticalDiv;
	float _halfSize;
	struct VertexInfo* _vertexData;

	IGELineStream* _lineStream;
}

@end

@implementation IGESphereUnit

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	self.cameraID = @"DefaultCamera".hash;
	self.lightID = @"DefaultLight".hash;
	self.shaderID = @"PhongShader".hash;

	_horizontalDiv = 20;
	_verticalDiv   = 20;
	_halfSize      =  1;
	
	IGEVector3* positionData = (IGEVector3*)malloc((_horizontalDiv+1) * (_verticalDiv+1) * sizeof(IGEVector3));

	// 座標情報を作成
	for (int vertical = 0; vertical <= _verticalDiv; ++vertical) {
		for (int horizontal = 0; horizontal <= _horizontalDiv; ++horizontal) {
			int index = vertical * (_horizontalDiv+1) + horizontal;

			float verticalPer = (float)vertical / (float)_verticalDiv;
			float horizontalPer  = (float)horizontal  / (float)_horizontalDiv;
			
			float r = _halfSize * sinf(M_PI * verticalPer);
			IGEVector3 position;
			position.x = r * cosf(M_PI*2 * horizontalPer);
			position.y = _halfSize * cosf(M_PI   * verticalPer);
			position.z = r * sinf(M_PI*2 * horizontalPer);

			positionData[index] = position;
		}
	}
	
	_vertexData = (struct VertexInfo*)malloc(_horizontalDiv * _verticalDiv * 3*2 * sizeof(struct VertexInfo));

	// 頂点情報を作成
	for (int vertical = 0; vertical < _verticalDiv; ++vertical) {
		for (int horizontal = 0; horizontal < _horizontalDiv; ++horizontal) {
			int indexVertex = (vertical * _horizontalDiv + horizontal) * 3*2;
			int indexPosition = vertical * (_horizontalDiv+1) + horizontal;
			
			_vertexData[indexVertex+0].position = positionData[indexPosition];
			_vertexData[indexVertex+1].position = positionData[indexPosition+(_horizontalDiv+1)+1];
			_vertexData[indexVertex+2].position = positionData[indexPosition+(_horizontalDiv+1)];

			IGEVector3 v0, v1;
			IGEVector3 normal;
			IGEVector4 ambient = IGEVector4Make(0, 0, 0, 1);
			IGEVector4 diffuse = IGEVector4Make(1, 1, 1, 1);

			v0 = _vertexData[indexVertex+1].position - _vertexData[indexVertex+0].position;
			v1 = _vertexData[indexVertex+2].position - _vertexData[indexVertex+0].position;

			if (IGEVector3LengthSq(v0) <= 0) {
				v0 = IGEVector3Make(0, 0, 1);
			}
			if (IGEVector3LengthSq(v1) <= 0) {
				v1 = IGEVector3Make(1, 0, 0);
			}
			
			normal = IGEVector3Normalize(IGEVector3CrossProduct(v0, v1));

			for (int i = 0; i < 3; ++i) {
				_vertexData[indexVertex+0+i].normal = normal;
				_vertexData[indexVertex+0+i].ambient = ambient;
				_vertexData[indexVertex+0+i].diffuse = diffuse;
			}
			
			_vertexData[indexVertex+3].position = positionData[indexPosition];
			_vertexData[indexVertex+4].position = positionData[indexPosition+1];
			_vertexData[indexVertex+5].position = positionData[indexPosition+(_horizontalDiv+1)+1];

			v0 = _vertexData[indexVertex+4].position - _vertexData[indexVertex+3].position;
			v1 = _vertexData[indexVertex+5].position - _vertexData[indexVertex+3].position;

			if (IGEVector3LengthSq(v0) <= 0) {
				v0 = IGEVector3Make(0, 0, 1);
			}
			if (IGEVector3LengthSq(v1) <= 0) {
				v1 = IGEVector3Make(1, 0, 0);
			}
			
			normal = IGEVector3Normalize(IGEVector3CrossProduct(v0, v1));
			
			for (int i = 0; i < 3; ++i) {
				_vertexData[indexVertex+3+i].normal = normal;
				_vertexData[indexVertex+3+i].ambient = ambient;
				_vertexData[indexVertex+3+i].diffuse = diffuse;
			}
		}
	}

	// 不要になった座標情報を削除
	free(positionData);
	
	glGenVertexArraysOES(1, &_vertexArray);
	glBindVertexArrayOES(_vertexArray);
	
	glGenBuffers(1, &_vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, _horizontalDiv * _verticalDiv * 3*2 * sizeof(struct VertexInfo), _vertexData, GL_STATIC_DRAW);
	
	glEnableVertexAttribArray(IGEVertexAttribPosition);
	glVertexAttribPointer(IGEVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 14*sizeof(float), IGE_BUFFER_OFFSET(0*sizeof(float)));
	glEnableVertexAttribArray(IGEVertexAttribNormal);
	glVertexAttribPointer(IGEVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 14*sizeof(float), IGE_BUFFER_OFFSET(3*sizeof(float)));
	glEnableVertexAttribArray(IGEVertexAttribAmbientColor);
	glVertexAttribPointer(IGEVertexAttribAmbientColor, 4, GL_FLOAT, GL_FALSE, 14*sizeof(float), IGE_BUFFER_OFFSET(6*sizeof(float)));
	glEnableVertexAttribArray(IGEVertexAttribDiffuseColor);
	glVertexAttribPointer(IGEVertexAttribDiffuseColor, 4, GL_FLOAT, GL_FALSE, 14*sizeof(float), IGE_BUFFER_OFFSET(10*sizeof(float)));
	
	glBindVertexArrayOES(0);

	_lineStream = [[IGELineStream alloc] initWithCapacity:_horizontalDiv * _verticalDiv * 3*2 * 2];
	IGE_NULL_ASSERT(_lineStream);
	
	return self;
}

- (void)dealloc
{
	[_lineStream release];

	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteVertexArraysOES(1, &_vertexArray);
	
	free(_vertexData);
	
    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	GLKMatrix4 xTranslateMatrix;
	GLKMatrix4 xRotateMatrix;
	GLKMatrix4 yRotateMatrix;

	xTranslateMatrix = GLKMatrix4MakeTranslation(1, 0, 0);
	xRotateMatrix = GLKMatrix4MakeXRotation(degreeToRadian(_rotate));
	yRotateMatrix = GLKMatrix4MakeYRotation(degreeToRadian(_rotate));

	self.worldMatrix = GLKMatrix4Multiply(GLKMatrix4Multiply(xRotateMatrix, yRotateMatrix), xTranslateMatrix);
	self.worldMatrix = yRotateMatrix;

/*
	IGELight* light = [[IGELightManager getInstance] findLightByID:self.lightID];
	IGE_NULL_ASSERT(light);

	GLKVector3 vector;
	vector.x = sinf(degreeToRadian(_rotate));
	vector.y = 0.0f;
	vector.z = cosf(degreeToRadian(_rotate));
	light.diffuseLightVector = vector;
*/
	_rotate += 30 * time;
	if (_rotate > 360) {
		_rotate = 0;
	}
/*
	for (int i = 0; i < _horizontalDiv * _verticalDiv * 3 * 2; ++i) {
		int index = i;
		GLKVector3 v0, v1;
		v0.x = _vertexData[index].position.x;
		v0.y = _vertexData[index].position.y;
		v0.z = _vertexData[index].position.z;
		v1.x = _vertexData[index].position.x + _vertexData[index].normal.x * 0.1f;
		v1.y = _vertexData[index].position.y + _vertexData[index].normal.y * 0.1f;
		v1.z = _vertexData[index].position.z + _vertexData[index].normal.z * 0.1f;
		[[[_lineStream addColor:GLKVector4Make(1, 0, 0, 1)] addPosition:v0] addPosition:v1];
	}
*/
}

- (void)render
{
	glBindVertexArrayOES(_vertexArray);
    glDrawArrays(GL_TRIANGLES, 0, _horizontalDiv * _verticalDiv * 3*2);

	[_lineStream render];
}

@end
