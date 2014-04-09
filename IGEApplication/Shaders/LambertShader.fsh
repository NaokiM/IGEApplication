//
//  LambertShader.fsh
//
//  Created by Naoki.M on 2013/09/04.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
