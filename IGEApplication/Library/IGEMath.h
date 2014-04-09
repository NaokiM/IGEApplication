//
//  IGEMath.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"

//! ラジアン→度変換
float radianToDegree(float radian);

//! 度→ラジアン変換
float degreeToRadian(float degree);

//! 2Dベクトル
union _IGEVector2 {
	struct {
		float x;
		float y;
	};
	float v[2];
};
typedef union _IGEVector2 IGEVector2;

//! 3Dベクトル
union _IGEVector3 {
	struct {
		float x;
		float y;
		float z;
	};
	float v[3];
};
typedef union _IGEVector3 IGEVector3;

//! 4Dベクトル
union _IGEVector4 {
	struct {
		float x;
		float y;
		float z;
		float w;
	};
	float v[4];
};
typedef union _IGEVector4 IGEVector4;

//! 3x3行列
union _IGEMatrix33 {
	struct {
		float m00, m01, m02;
		float m10, m11, m12;
		float m20, m21, m22;
	};
	float m[3*3];
};
typedef union _IGEMatrix33 IGEMatrix33;

//! 4x4行列
union _IGEMatrix44 {
	struct {
		float m00, m01, m02, m03;
		float m10, m11, m12, m13;
		float m20, m21, m22, m23;
		float m30, m31, m32, m33;
	};
	float m[4*4];
};
typedef union _IGEMatrix44 IGEMatrix44;
