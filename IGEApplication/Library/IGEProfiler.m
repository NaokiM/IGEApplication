//
//  IGEProfiler.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEProfiler.h"

@interface IGEProfiler () {
}

@end

@implementation IGEProfiler

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	_fps = [[IGEFps alloc] init];
	IGE_NULL_ASSERT(_fps);

	return self;
}

- (void)dealloc
{
	[_fps release];

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	[self.fps updateAtTime:time];
}

- (void)render
{
}

@end
