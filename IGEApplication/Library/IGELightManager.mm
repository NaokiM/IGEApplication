//
//  IGELightManager.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGELightManager.hh"
#import "IGELight.hh"

@interface IGELightManager () {
	NSMutableArray* _LightArray;
	unsigned long _currentID;
}

@end

@implementation IGELightManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_LightArray = [[NSMutableArray alloc] init];
	IGE_NULL_ASSERT(_LightArray);

	return self;
}

- (void)dealloc
{
	[_LightArray release];

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	// 実際に削除
	for (IGELight* Light in [_LightArray reverseObjectEnumerator]) {
		if (Light.willDelete) {
			[_LightArray removeObject:Light];
		}
	}
}

- (void)addLight:(IGELight*)Light
{
	[_LightArray addObject:Light];
	[Light release];	// 所有権をマネージャに任せるようにしています
}

- (void)removeLight:(IGELight*)Light
{
	Light.willDelete = YES;
}

- (void)removeLightByID:(unsigned long)ID
{
	for (IGELight* Light in _LightArray) {
		if (Light.ID == ID) {
			Light.willDelete = YES;
			return;
		}
	}
}

- (void)removeAllLights
{
	for (IGELight* Light in _LightArray) {
		Light.willDelete = YES;
	}
}

- (IGELight*)findLightByID:(unsigned long)ID
{
	for (IGELight* Light in _LightArray) {
		if (Light.ID == ID) {
			return Light;
		}
	}
	
	return nil;
}

- (void)changeLightByID:(unsigned long)ID
{
	if (_currentID != ID) {
		_currentID = ID;
		_currentLight = [self findLightByID:_currentID];
	}
}

@end
