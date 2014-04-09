//
//  LambertShader.vsh
//
//  Created by Naoki.M on 2013/09/04.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec4 ambientColor;
attribute vec4 diffuseColor;

uniform mat4 worldMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 projectionMatrix;
uniform vec4 ambientLightColor;
uniform vec4 diffuseLightColor;
uniform vec3 diffuseLightVector;

varying lowp vec4 colorVarying;

void main()
{
	// ライトベクトルは逆ワールド行列が掛けられているので、モデル空間のベクトルになっています
    float nDotVP = max(0.0, dot(normal, -diffuseLightVector));
	
    colorVarying =	(ambientColor * ambientColor.w) * (ambientLightColor * ambientLightColor.w) +
					(((diffuseColor * diffuseColor.w) + (diffuseLightColor * diffuseLightColor.w)) * nDotVP);

	gl_Position = projectionMatrix * viewMatrix * worldMatrix * position;
}
