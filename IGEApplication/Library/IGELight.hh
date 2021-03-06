//
//  IGELight.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGEObject.hh"

//! シェーダ
@interface IGELight : IGEObject {
}

@property (assign, nonatomic) GLKVector4 ambientLightColor;
@property (assign, nonatomic) GLKVector4 diffuseLightColor;
@property (assign, nonatomic) GLKVector3 diffuseLightVector;

- (id)initWithName:(NSString*)LightName;

@end
