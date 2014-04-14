//
//  IGEFramework.h
//
//  Created by Naoki.M on 2014/04/04.
//  Copyright (c) 2014年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGESingleton.hh"

//! フレームワーク
@interface IGEFramework : IGESingleton {
}

- (id)init;
- (void)dealloc;
- (void)update;
- (void)render;

@end
