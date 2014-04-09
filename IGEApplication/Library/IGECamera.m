//
//  IGECamera.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECamera.h"

@interface IGECamera () {
}

@end

@implementation IGECamera

- (id)initWithName:(NSString*)cameraName
{
	self = [super init];
	if (!self) {
		return nil;
	}

	self.ID = cameraName.hash;
	
	_viewMatrix = GLKMatrix4Identity;
	_projectionMatrix = GLKMatrix4Identity;

	_isViewMatrixInvalid = YES;
	_isProjectionMatrixInvalid = YES;
	
	return self;
}

- (void)updateAtTime:(float)time
{
	if (_isViewMatrixInvalid) {
		_viewMatrix = GLKMatrix4MakeLookAt(
										   self.positon.x, self.positon.y, self.positon.z,
										   self.target.x, self.target.y, self.target.z,
										   self.upVector.x, self.upVector.y, self.upVector.z);
		_isViewMatrixInvalid = NO;
	}

	if (_isProjectionMatrixInvalid) {
		_projectionMatrix = GLKMatrix4MakePerspective(
													  self.fov,
													  self.aspect,
													  self.near,
													  self.far);
		_isProjectionMatrixInvalid = NO;
	}
}

- (void)setPositon:(GLKVector3)positon
{
	_positon = positon;
	_isViewMatrixInvalid = YES;
}

- (void)setTarget:(GLKVector3)target
{
	_target = target;
	_isViewMatrixInvalid = YES;
}

- (void)setUpVector:(GLKVector3)upVector
{
	_upVector = upVector;
	_isViewMatrixInvalid = YES;
}

- (void)setNear:(float)near
{
	_near = near;
	_isProjectionMatrixInvalid = YES;
}

- (void)setFar:(float)far
{
	_far = far;
	_isProjectionMatrixInvalid = YES;
}

- (void)setFov:(float)fov
{
	_fov = fov;
	_isProjectionMatrixInvalid = YES;
}

- (void)setAspect:(float)aspect
{
	_aspect = aspect;
	_isProjectionMatrixInvalid = YES;
}

@end
