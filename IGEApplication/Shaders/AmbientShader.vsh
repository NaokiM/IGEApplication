//
//  AmbientShader.vsh
//
//  Created by Naoki.M on 2013/09/04.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

attribute vec4 position;
attribute vec4 ambientColor;

uniform mat4 worldMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform vec4 ambientLightColor;

varying lowp vec4 colorVarying;

void main()
{
    colorVarying = (ambientColor * ambientColor.w) * (ambientLightColor * ambientLightColor.w);

	gl_Position = projectionMatrix * viewMatrix * worldMatrix * position;
}
