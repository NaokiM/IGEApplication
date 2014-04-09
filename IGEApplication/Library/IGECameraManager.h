//
//  IGECameraManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGESingleton.h"

@class IGECamera;

//! カメラマネージャ
@interface IGECameraManager : IGESingleton {
}

@property (assign, nonatomic) IGECamera* currentCamera;

- (void)updateAtTime:(float)time;
- (void)addCamera:(IGECamera*)camera;
- (void)removeCamera:(IGECamera*)camera;
- (void)removeCameraByID:(unsigned long)ID;
- (void)removeAllCameras;
- (IGECamera*)findCameraByID:(unsigned long)ID;
- (void)changeCameraByID:(unsigned long)ID;

@end
