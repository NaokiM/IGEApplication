//
//  IGELight.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGELight.hh"

@interface IGELight () {
}

@end

@implementation IGELight

- (id)initWithName:(NSString*)LightName
{
	self = [super init];
	if (!self) {
		return nil;
	}

	self.ID = LightName.hash;
	_ambientLightColor = GLKVector4Make(1, 1, 1, 1);
	_diffuseLightColor = GLKVector4Make(1, 1, 1, 1);
	_diffuseLightVector = GLKVector3Make(0, 0, 1);

	return self;
}

@end
