//
//  IGEFps.m
//
//  Created by Naoki.M on 2014/04/07.
//  Copyright (c) 2014年 Naoki.M. All rights reserved.
//

#import <mach/mach_time.h>
#import "IGEFps.h"

@interface IGEFps () {
	mach_timebase_info_data_t _timebaseInfo;
	uint64_t _start;
}

@end

@implementation IGEFps

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	mach_timebase_info(&_timebaseInfo);
	_start = mach_absolute_time();
	_fps = 0.0f;

	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)updateAtTime:(float)time
{
	uint64_t elapsed;
	elapsed = mach_absolute_time() - _start;

	uint64_t nsec = elapsed * _timebaseInfo.numer / _timebaseInfo.denom;
	float sec = (float)nsec / 1000.0f / 1000.0f;
	_fps = 1000.0f / sec;

	//NSLog(@"%3.1f¥n", _fps);
	
	_start = mach_absolute_time();
}

@end
