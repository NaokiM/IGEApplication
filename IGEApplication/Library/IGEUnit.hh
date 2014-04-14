//
//  IGEUnit.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGEObject.hh"

//! ユニット
@interface IGEUnit : IGEObject {
}

@property (assign, nonatomic) BOOL isHide;
@property (assign, nonatomic) unsigned long cameraID;
@property (assign, nonatomic) unsigned long lightID;
@property (assign, nonatomic) unsigned long shaderID;
@property (assign, nonatomic) GLKMatrix4 worldMatrix;

- (void)render;

@end
