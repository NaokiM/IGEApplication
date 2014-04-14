//
//  IGECameraManager.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECameraManager.hh"
#import "IGECamera.hh"

@interface IGECameraManager () {
	NSMutableArray* _cameraArray;
	unsigned long _currentID;
}

@end

@implementation IGECameraManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_cameraArray = [[NSMutableArray alloc] init];
	IGE_NULL_ASSERT(_cameraArray);

	return self;
}

- (void)dealloc
{
	[_cameraArray release];

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	// 実際に削除
	for (IGECamera* camera in [_cameraArray reverseObjectEnumerator]) {
		if (camera.willDelete) {
			[_cameraArray removeObject:camera];
		}
	}
	
	// updateの実行
	for (IGECamera* camera in _cameraArray) {
		if (camera.isPause) {
			continue;
		}
		
		[camera updateAtTime:time];
	}
}

- (void)addCamera:(IGECamera *)camera
{
	[_cameraArray addObject:camera];
	[camera release];	// 所有権をマネージャに任せるようにしています
}

- (void)removeCamera:(IGECamera*)camera
{
	camera.willDelete = YES;
}

- (void)removeCameraByID:(unsigned long)ID
{
	for (IGECamera* camera in _cameraArray) {
		if (camera.ID == ID) {
			camera.willDelete = YES;
			return;
		}
	}
}

- (void)removeAllCameras
{
	for (IGECamera* camera in _cameraArray) {
		camera.willDelete = YES;
	}
}

- (IGECamera*)findCameraByID:(unsigned long)ID
{
	for (IGECamera* camera in _cameraArray) {
		if (camera.ID == ID) {
			return camera;
		}
	}
	
	return nil;
}

- (void)changeCameraByID:(unsigned long)ID
{
	if (_currentID != ID) {
		_currentID = ID;
		_currentCamera = [self findCameraByID:_currentID];
	}
}

@end
