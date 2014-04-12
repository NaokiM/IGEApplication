//
//  IGEBootScene.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEBootScene.h"
#import "IGETestUnit.h"
#import "IGESphereUnit.h"

@interface IGEBootScene () {
	IGESphereUnit* _sphereUnit;
}

@end

@implementation IGEBootScene

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	_sphereUnit = [[IGESphereUnit alloc] init];
	[[IGEUnitManager getInstance] addUnit:_sphereUnit];

	return self;
}

- (void)dealloc
{
	[[IGEUnitManager getInstance] removeUnit:_sphereUnit];

    [super dealloc];
}

@end
