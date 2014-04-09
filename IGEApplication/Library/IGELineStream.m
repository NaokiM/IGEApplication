//
//  IGELineStream.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGELineStream.h"
#import "IGEShader.h"

@interface IGELineStream () {
	GLuint _vertexArray;
	GLuint _vertexBuffer;
	struct Vertex {
		float x, y, z;
		float r, g, b, a;
	};
	struct Vertex* _vertex;
	GLKVector4 _currentColor;
	int _capacity;
	int _size;
}

@end

@implementation IGELineStream

- (id)initWithCapacity:(int)capacity
{
	self = [super init];
	if (!self) {
		return nil;
	}

	_currentColor = GLKVector4Make(1, 1, 1, 1);
	_capacity = capacity * 2;
	_size = 0;

	_vertex = malloc(_capacity * sizeof(struct Vertex));
	IGE_NULL_ASSERT(_vertex);

	glGenVertexArraysOES(1, &_vertexArray);
	glBindVertexArrayOES(_vertexArray);
	
	glGenBuffers(1, &_vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, _capacity*sizeof(struct Vertex), _vertex, GL_DYNAMIC_DRAW);
	
	glEnableVertexAttribArray(IGEVertexAttribPosition);
	glVertexAttribPointer(IGEVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 7*sizeof(float), IGE_BUFFER_OFFSET(0));
	glEnableVertexAttribArray(IGEVertexAttribAmbientColor);
	glVertexAttribPointer(IGEVertexAttribAmbientColor, 4, GL_FLOAT, GL_FALSE, 7*sizeof(float), IGE_BUFFER_OFFSET(3*sizeof(float)));
	
	glBindVertexArrayOES(0);
	
	return self;
}

- (void)dealloc
{
	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteVertexArraysOES(1, &_vertexArray);

	free(_vertex);

    [super dealloc];
}

- (void)render
{
	if (_size > 0) {
		glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
		glBufferSubData(GL_ARRAY_BUFFER, 0, _size*sizeof(struct Vertex), _vertex);
	}

	glBindVertexArrayOES(_vertexArray);
    glDrawArrays(GL_LINES, 0, _size*7);

	_size = 0;
}

- (IGELineStream*)addPosition:(GLKVector3)position
{
	_vertex[_size].x = position.x;
	_vertex[_size].y = position.y;
	_vertex[_size].z = position.z;
	_vertex[_size].r = _currentColor.r;
	_vertex[_size].g = _currentColor.g;
	_vertex[_size].b = _currentColor.b;
	_vertex[_size].a = _currentColor.a;
	++_size;

	return self;
}

- (IGELineStream*)addColor:(GLKVector4)color
{
	_currentColor = color;
	
	return self;
}

@end
