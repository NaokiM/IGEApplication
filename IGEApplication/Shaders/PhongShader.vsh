//
//  PhongShader.vsh
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
uniform vec4 ambientLightColor;
uniform vec4 diffuseLightColor;
uniform vec3 diffuseLightVector;
uniform vec3 cameraPosition;

varying lowp vec4 colorVarying;

void main()
{
    colorVarying = (ambientColor * ambientColor.w) * (ambientLightColor * ambientLightColor.w);
	
	// ライトベクトルは逆ワールド行列が掛けられているので、モデル空間のベクトルになっています
    float nDotVP = max(0.0, dot(normal, -diffuseLightVector));
	colorVarying = colorVarying + (((diffuseColor * diffuseColor.w) + (diffuseLightColor * diffuseLightColor.w)) * nDotVP);

	vec3 cameraVector;
	cameraVector.x = cameraPosition.x - position.x;
	cameraVector.y = cameraPosition.y - position.y;
	cameraVector.z = cameraPosition.z - position.z;
	cameraVector = normalize(cameraVector);
	vec3 lightVector = normalize(-diffuseLightVector);
	nDotVP = 2.0 * dot(normal, cameraVector);
	vec3 reflectVector = -cameraVector + nDotVP * normal;
	float reflectPower = 10.0;
	
	colorVarying = colorVarying + pow(max(0.0, dot(lightVector, reflectVector)), reflectPower);

	gl_Position = projectionMatrix * viewMatrix * worldMatrix * position;
}
