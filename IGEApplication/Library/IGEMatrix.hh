//
//  IGEMatrix.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

// IGEMatrix33

inline IGEMatrix33 IGEMatrix33Identity() {
	static IGEMatrix33 sIdentityMatrix = {
		1.0f, 0.0f, 0.0f,
		0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 1.0f
	};
	return sIdentityMatrix;
}

inline IGEMatrix33 IGEMatrix33Invert(IGEMatrix33 matrix, bool* isInvertible)
{
	//! @todo とりあえずGLKitのものを使用
	GLKMatrix3 glkTemp;
	memcpy(glkTemp.m, matrix.m, 3*3*sizeof(float));
	GLKMatrix3Invert(glkTemp, isInvertible);
	IGEMatrix33 temp;
	memcpy(temp.m, glkTemp.m, 3*3*sizeof(float));
	return temp;
}

// IGEMatrix44

inline IGEMatrix44 IGEMatrix44Identity() {
	static IGEMatrix44 sIdentityMatrix = {
		1.0f, 0.0f, 0.0f, 0.0f,
		0.0f, 1.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f
	};
	return sIdentityMatrix;
}

inline IGEMatrix44 IGEMatrix44Invert(IGEMatrix44 matrix, bool* isInvertible)
{
	//! @todo とりあえずGLKitのものを使用
	GLKMatrix4 glkTemp;
	memcpy(glkTemp.m, matrix.m, 4*4*sizeof(float));
	GLKMatrix4Invert(glkTemp, isInvertible);
	IGEMatrix44 temp;
	memcpy(temp.m, glkTemp.m, 4*4*sizeof(float));
	return temp;
}

inline IGEMatrix44 IGEMatrix4MakeTranslation(float tx, float ty, float tz)
{
    IGEMatrix44 temp = IGEMatrix44Identity();
    temp.m[12] = tx;
    temp.m[13] = ty;
    temp.m[14] = tz;
    return temp;
}

inline IGEMatrix44 IGEMatrix4MakeScale(float sx, float sy, float sz)
{
    IGEMatrix44 temp = IGEMatrix44Identity();
    temp.m[0] = sx;
    temp.m[5] = sy;
    temp.m[10] = sz;
    return temp;
}

inline IGEMatrix44 IGEMatrix4MakeRotation(float radians, float x, float y, float z)
{
    IGEVector3 v = IGEVector3Normalize(IGEVector3Make(x, y, z));
    float cos = cosf(radians);
    float cosp = 1.0f - cos;
    float sin = sinf(radians);
    
    IGEMatrix44 temp = {
		cos + cosp * v.v[0] * v.v[0],
		cosp * v.v[0] * v.v[1] + v.v[2] * sin,
		cosp * v.v[0] * v.v[2] - v.v[1] * sin,
		0.0f,
		cosp * v.v[0] * v.v[1] - v.v[2] * sin,
		cos + cosp * v.v[1] * v.v[1],
		cosp * v.v[1] * v.v[2] + v.v[0] * sin,
		0.0f,
		cosp * v.v[0] * v.v[2] + v.v[1] * sin,
		cosp * v.v[1] * v.v[2] - v.v[0] * sin,
		cos + cosp * v.v[2] * v.v[2],
		0.0f,
		0.0f,
		0.0f,
		0.0f,
		1.0f };
	
    return temp;
}

inline IGEMatrix44 IGEMatrix4MakeXRotation(float radians)
{
    float cos = cosf(radians);
    float sin = sinf(radians);
    
    IGEMatrix44 temp = {
		1.0f, 0.0f, 0.0f, 0.0f,
		0.0f, cos, sin, 0.0f,
		0.0f, -sin, cos, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f };
    
    return temp;
}

inline IGEMatrix44 IGEMatrix4MakeYRotation(float radians)
{
    float cos = cosf(radians);
    float sin = sinf(radians);
    
    IGEMatrix44 temp = {
		cos, 0.0f, -sin, 0.0f,
		0.0f, 1.0f, 0.0f, 0.0f,
		sin, 0.0f, cos, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f };
    
    return temp;
}

inline IGEMatrix44 IGEMatrix4MakeZRotation(float radians)
{
    float cos = cosf(radians);
    float sin = sinf(radians);
    
    IGEMatrix44 temp = {
		cos, sin, 0.0f, 0.0f,
		-sin, cos, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f, 0.0f,
		0.0f, 0.0f, 0.0f, 1.0f };
    
    return temp;
}

inline IGEMatrix44 IGEMatrix44MakeLookAt(float positionX, float positionY, float positionZ, float targetX, float targetY, float targetZ, float upVectorX, float upVectorY, float upVectorZ) {
    IGEVector3 position = { positionX, positionY, positionZ };
    IGEVector3 target = { targetX, targetY, targetZ };
    IGEVector3 upVector = { upVectorX, upVectorY, upVectorZ };
    IGEVector3 targetToPositionVector = IGEVector3Normalize(position-target);
    IGEVector3 rightVector = IGEVector3Normalize(IGEVector3CrossProduct(upVector, targetToPositionVector));
    IGEVector3 newUpVector = IGEVector3CrossProduct(targetToPositionVector, rightVector);
    
    IGEMatrix44 temp = {
		rightVector.v[0], newUpVector.v[0], targetToPositionVector.v[0], 0.0f,
		rightVector.v[1], newUpVector.v[1], targetToPositionVector.v[1], 0.0f,
		rightVector.v[2], newUpVector.v[2], targetToPositionVector.v[2], 0.0f,
		IGEVector3DotProduct(-rightVector, position), IGEVector3DotProduct(-newUpVector, position), IGEVector3DotProduct(-targetToPositionVector, position), 1.0f
	};

    return temp;
}

inline IGEMatrix44 IGEMatrix44MakePerspective(float fovyRadians, float aspect, float nearZ, float farZ) {
    float cotan = 1.0f / tanf(fovyRadians / 2.0f);
    
    IGEMatrix44 temp = {
		cotan / aspect, 0.0f, 0.0f, 0.0f,
		0.0f, cotan, 0.0f, 0.0f,
		0.0f, 0.0f, (farZ + nearZ) / (nearZ - farZ), -1.0f,
		0.0f, 0.0f, (2.0f * farZ * nearZ) / (nearZ - farZ), 0.0f
	};

    return temp;
}

