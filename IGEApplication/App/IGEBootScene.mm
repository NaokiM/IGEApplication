//
//  IGEBootScene.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEBootScene.hh"
#import "IGETestUnit.hh"
#import "IGESphereUnit.hh"

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
