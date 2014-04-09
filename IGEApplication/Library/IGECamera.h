//
//  IGECamera.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGEObject.h"

//! カメラ
@interface IGECamera : IGEObject {
	BOOL _isViewMatrixInvalid;
	BOOL _isProjectionMatrixInvalid;
}

@property (assign, nonatomic) GLKMatrix4 viewMatrix;
@property (assign, nonatomic) GLKMatrix4 projectionMatrix;

@property (assign, nonatomic) GLKVector3 positon;
@property (assign, nonatomic) GLKVector3 target;
@property (assign, nonatomic) GLKVector3 upVector;

@property (assign, nonatomic) float near;
@property (assign, nonatomic) float far;
@property (assign, nonatomic) float fov;
@property (assign, nonatomic) float aspect;

- (id)initWithName:(NSString*)cameraName;

@end
