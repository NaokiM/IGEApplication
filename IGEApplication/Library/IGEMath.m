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
