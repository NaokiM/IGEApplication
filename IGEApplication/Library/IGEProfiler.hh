//
//  IGEProfiler.hh
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGESingleton.hh"
#import "IGEFps.hh"

//! プロファイラ
@interface IGEProfiler : IGESingleton {
}

@property (strong, nonatomic) IGEFps* fps;

- (void)updateAtTime:(float)time;
- (void)render;

@end
