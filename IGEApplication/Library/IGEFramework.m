//
//  IGEFramework.m
//
//  Created by Naoki.M on 2014/04/04.
//  Copyright (c) 2014年 Naoki.M. All rights reserved.
//

#import "sys/time.h"
#import "IGEFramework.h"
#import "IGETouchManager.h"
#import "IGECameraManager.h"
#import "IGELightManager.h"
#import "IGEShaderManager.h"
#import "IGERenderer.h"
#import "IGESceneManager.h"
#import "IGEUnitManager.h"
#import "IGEProfiler.h"

@implementation IGEFramework {	
	struct timeval _prevTime;
}

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	[IGETouchManager createInstance];
	[IGECameraManager createInstance];
	[IGELightManager createInstance];
	[IGEShaderManager createInstance];
	[IGERenderer createInstance];
	[IGESceneManager createInstance];
	[IGEUnitManager createInstance];
	[IGEProfiler createInstance];

	return self;
}

- (void)dealloc
{
	[IGEProfiler deleteInstance];
	[IGEUnitManager deleteInstance];
	[IGESceneManager deleteInstance];
	[IGERenderer deleteInstance];
	[IGEShaderManager deleteInstance];
	[IGELightManager deleteInstance];
	[IGECameraManager deleteInstance];
	[IGETouchManager deleteInstance];

    [super dealloc];
}

- (void)update
{
	// 前回からの経過時間を取得する
	struct timeval currentTime;
	gettimeofday(&currentTime, NULL);
	float time = (currentTime.tv_sec - _prevTime.tv_sec) + (float)(currentTime.tv_usec - _prevTime.tv_usec) / (1000*1000);
	_prevTime = currentTime;
	
	[[IGETouchManager getInstance ] updateAtTime:time];
	[[IGECameraManager getInstance] updateAtTime:time];
	[[IGELightManager getInstance] updateAtTime:time];
	[[IGEShaderManager getInstance] updateAtTime:time];
	[[IGESceneManager getInstance] updateAtTime:time];
	[[IGEUnitManager getInstance] updateAtTime:time];
	[[IGEProfiler getInstance] updateAtTime:time];
}

- (void)render
{
	[[IGERenderer getInstance] setupRender];
	[[IGEUnitManager getInstance] render];
	[[IGEProfiler getInstance] render];
}

@end
