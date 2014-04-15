//
//  IGEMath.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"

//! ラジアン→度変換
inline float radianToDegree(float radian) {
	return radian * 180.0f / M_PI;
}

//! 度→ラジアン変換
inline float degreeToRadian(float degree) {
	return degree * M_PI / 180.0f;
}

//! 2Dベクトル
class IGEVector2 {
public:
	union {
		struct {
			float x;
			float y;
		};
		float v[2];
	};
};

//! 3Dベクトル
class IGEVector3 {
public:
	union {
		struct {
			float x;
			float y;
			float z;
		};
		float v[3];
	};
};

//! 4Dベクトル
class IGEVector4 {
public:
	union {
		struct {
			float x;
			float y;
			float z;
			float w;
		};
		struct {
			float r;
			float g;
			float b;
			float a;
		};
		float v[4];
	};
};

//! 3x3行列
class IGEMatrix33 {
public:
	union {
		struct {
			float m00, m01, m02;
			float m10, m11, m12;
			float m20, m21, m22;
		};
		float m[3*3];
	};
};

//! 4x4行列
class IGEMatrix44 {
public:
	union {
		struct {
			float m00, m01, m02, m03;
			float m10, m11, m12, m13;
			float m20, m21, m22, m23;
			float m30, m31, m32, m33;
		};
		float m[4*4];
	};
};

#import "IGEVector.hh"
#import "IGEMatrix.hh"
