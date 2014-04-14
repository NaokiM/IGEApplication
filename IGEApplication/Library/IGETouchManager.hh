//
//  IGETouchManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGESingleton.hh"

//! HIDマネージャ
@interface IGETouchManager : IGESingleton {
}

@property (assign, nonatomic) BOOL isSingleTap;
@property (assign, nonatomic) CGPoint tapPoint;

- (void)updateAtTime:(float)time;

@end
