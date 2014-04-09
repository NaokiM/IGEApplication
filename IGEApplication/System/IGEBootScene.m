//
//  IGEBootScene.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEBootScene.h"
#import "IGETestUnit.h"

@interface IGEBootScene () {
	IGETestUnit* _testUnit;
}

@end

@implementation IGEBootScene

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	_testUnit = [[IGETestUnit alloc] init];
	[[IGEUnitManager getInstance] addUnit:_testUnit];

	return self;
}

- (void)dealloc
{
	[[IGEUnitManager getInstance] removeUnit:_testUnit];

    [super dealloc];
}

@end
