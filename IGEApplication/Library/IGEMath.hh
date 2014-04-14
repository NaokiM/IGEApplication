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

// IGEVector3

inline IGEVector3 IGEVector3Make(float x, float y, float z) {
	IGEVector3 temp;
	temp.x = x;
	temp.y = y;
	temp.z = z;
	return temp;
}

inline inline IGEVector3 operator + (IGEVector3 a, IGEVector3 b) {
	IGEVector3 temp;
	temp.x = a.x + b.x;
	temp.y = a.y + b.y;
	temp.z = a.z + b.z;
	return temp;
}

inline inline IGEVector3 operator - (IGEVector3 a, IGEVector3 b) {
	IGEVector3 temp;
	temp.x = a.x - b.x;
	temp.y = a.y - b.y;
	temp.z = a.z - b.z;
	return temp;
}

inline float IGEVector3Length(IGEVector3 a) {
	return sqrtf(a.x * a.x + a.y * a.y + a.z * a.z);
}

inline float IGEVector3LengthSq(IGEVector3 a) {
	return a.x * a.x + a.y * a.y + a.z * a.z;
}

inline IGEVector3 IGEVector3Normalize(IGEVector3 a) {
	float invertLength = 1.0f / IGEVector3Length(a);
	IGEVector3 temp;
	temp.x = a.x * invertLength;
	temp.y = a.y * invertLength;
	temp.z = a.z * invertLength;
	return temp;
}

inline float IGEVector3Dot(IGEVector3 a, IGEVector3 b) {
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

inline IGEVector3 IGEVector3Cross(IGEVector3 a, IGEVector3 b) {
	IGEVector3 temp;
	temp.x = b.y * a.z - b.z * a.y;
	temp.y = b.z * a.x - b.x * a.z;
	temp.z = b.x * a.y - b.y * a.x;
	return temp;
}

// IGEVector4

inline IGEVector4 IGEVector4Make(float x, float y, float z, float w) {
	IGEVector4 temp;
	temp.x = x;
	temp.y = y;
	temp.z = z;
	temp.w = w;
	return temp;
}

inline inline IGEVector4 operator + (IGEVector4 a, IGEVector4 b) {
	IGEVector4 temp;
	temp.x = a.x + b.x;
	temp.y = a.y + b.y;
	temp.z = a.z + b.z;
	temp.w = a.w + b.w;
	return temp;
}

inline inline IGEVector4 operator - (IGEVector4 a, IGEVector4 b) {
	IGEVector4 temp;
	temp.x = a.x - b.x;
	temp.y = a.y - b.y;
	temp.z = a.z - b.z;
	temp.w = a.w - b.w;
	return temp;
}
