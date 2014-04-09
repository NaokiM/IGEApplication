//
//  IGELineStream.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGEObject.h"

//! ラインストリーム
@interface IGELineStream : IGEObject {
}

- (id)initWithCapacity:(int)capacity;
- (void)render;

- (IGELineStream*)addPosition:(GLKVector3)position;
- (IGELineStream*)addColor:(GLKVector4)color;

@end
