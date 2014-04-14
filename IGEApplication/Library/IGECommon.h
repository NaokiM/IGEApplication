//
//  IGECommon.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>
#import "IGEMath.h"

#ifdef IGE_DEBUG
#define IGE_ASSERT(exp)				NSAssert((exp), @"")
#define IGE_NULL_ASSERT(exp)		NSAssert((exp), @"")
#define IGE_ASSERT_MSG(exp, msg)	NSAssert((exp), msg)
#define IGE_FATAL_ERROR(msg)		NSAssert(0, msg)
#define IGE_VERIFY(exp)				IGE_ASSERT(exp)
#define IGE_RETAIN_PRINT(obj, msg)	NSLog(@"%s retainCount:%lu\n", msg, (unsigned long)[obj retainCount])
#else
#define IGE_ASSERT(exp)
#define IGE_NULL_ASSERT(exp)
#define IGE_ASSERT_MSG(exp)
#define IGE_FATAL_ERROR(exp)
#define IGE_VERIFY(exp)				exp
#define IGE_RETAIN_PRINT(obj)
#endif
