//
//  IGEVector.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

// IGEVector3

inline IGEVector3 IGEVector3Make(float x, float y, float z) {
	IGEVector3 temp;
	temp.x = x;
	temp.y = y;
	temp.z = z;
	return temp;
}

inline IGEVector3 operator + (const IGEVector3& a) {
	return a;
}

inline IGEVector3 operator - (const IGEVector3& a) {
	IGEVector3 temp;
	temp.x = -a.x;
	temp.y = -a.y;
	temp.z = -a.z;
	return temp;
}

inline IGEVector3 operator + (const IGEVector3& a, const IGEVector3& b) {
	IGEVector3 temp;
	temp.x = a.x + b.x;
	temp.y = a.y + b.y;
	temp.z = a.z + b.z;
	return temp;
}

inline IGEVector3 operator - (const IGEVector3& a, const IGEVector3& b) {
	IGEVector3 temp;
	temp.x = a.x - b.x;
	temp.y = a.y - b.y;
	temp.z = a.z - b.z;
	return temp;
}

IGEVector3 operator * (IGEMatrix44 matrix, IGEVector3 vector);

inline float IGEVector3Length(const IGEVector3& a) {
	return sqrtf(a.x * a.x + a.y * a.y + a.z * a.z);
}

inline float IGEVector3LengthSq(const IGEVector3& a) {
	return a.x * a.x + a.y * a.y + a.z * a.z;
}

inline IGEVector3 IGEVector3Normalize(const IGEVector3& a) {
	float invertLength = 1.0f / IGEVector3Length(a);
	IGEVector3 temp;
	temp.x = a.x * invertLength;
	temp.y = a.y * invertLength;
	temp.z = a.z * invertLength;
	return temp;
}

inline float IGEVector3DotProduct(const IGEVector3& a, const IGEVector3& b) {
	return a.x * b.x + a.y * b.y + a.z * b.z;
}

inline IGEVector3 IGEVector3CrossProduct(const IGEVector3& a, const IGEVector3& b) {
	IGEVector3 temp;
	temp.x = a.y * b.z - a.z * b.y;
	temp.y = a.z * b.x - a.x * b.z;
	temp.z = a.x * b.y - a.y * b.x;
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

inline IGEVector4 operator + (const IGEVector4& a, const IGEVector4& b) {
	IGEVector4 temp;
	temp.x = a.x + b.x;
	temp.y = a.y + b.y;
	temp.z = a.z + b.z;
	temp.w = a.w + b.w;
	return temp;
}

inline IGEVector4 operator - (const IGEVector4& a, const IGEVector4& b) {
	IGEVector4 temp;
	temp.x = a.x - b.x;
	temp.y = a.y - b.y;
	temp.z = a.z - b.z;
	temp.w = a.w - b.w;
	return temp;
}
