//
//  IGEFps.hh
//
//  Created by Naoki.M on 2014/04/07.
//  Copyright (c) 2014年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"

@interface IGEFps : NSObject {
}

@property (assign, nonatomic) float fps;

- (void)updateAtTime:(float)time;

@end
