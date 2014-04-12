//
//  IGEMath.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEMath.h"

float radianToDegree(float radian)
{
	return radian * 180.0f / M_PI;
}

float degreeToRadian(float degree)
{
	return degree * M_PI / 180.0f;
}

// IGEVector3

IGEVector3 IGEVector3Make(float x, float y, float z)
{
	IGEVector3 result;
	result.x = x;
	result.y = y;
	result.z = z;
	return result;
}

IGEVector3 IGEVector3Add(IGEVector3 a, IGEVector3 b)
{
	IGEVector3 result;
	result.x = a.x + b.x;
	result.y = a.y + b.y;
	result.z = a.z + b.z;
	return result;
}

IGEVector3 IGEVector3Sub(IGEVector3 a, IGEVector3 b)
{
	IGEVector3 result;
	result.x = a.x - b.x;
	result.y = a.y - b.y;
	result.z = a.z - b.z;
	return result;
}

float IGEVector3Length(IGEVector3 a)
{
	return sqrtf(a.x * a.x + a.y * a.y + a.z * a.z);
}

float IGEVector3LengthSq(IGEVector3 a)
{
	return a.x * a.x + a.y * a.y + a.z * a.z;
}

IGEVector3 IGEVector3Normalize(IGEVector3 a)
{
	float invertLength = 1.0f / IGEVector3Length(a);
	IGEVector3 result;
	result.x = a.x * invertLength;
	result.y = a.y * invertLength;
	result.z = a.z * invertLength;
	return result;
}

float IGEVector3Dot(IGEVector3 a, IGEVector3 b)
{
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

IGEVector3 IGEVector3Cross(IGEVector3 a, IGEVector3 b)
{
	IGEVector3 result;
	result.x = b.y * a.z - b.z * a.y;
	result.y = b.z * a.x - b.x * a.z;
	result.z = b.x * a.y - b.y * a.x;
	return result;
}

// IGEVector4

IGEVector4 IGEVector4Make(float x, float y, float z, float w)
{
	IGEVector4 result;
	result.x = x;
	result.y = y;
	result.z = z;
	result.w = w;
	return result;
}
