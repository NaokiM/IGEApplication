//
//  IGEUnit.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEUnit.hh"

@interface IGEUnit () {
}

@end

@implementation IGEUnit

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}

	_worldMatrix = GLKMatrix4Identity;

	return self;
}

- (void)render
{
}

@end
