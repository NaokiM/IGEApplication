//
//  IGELightManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGESingleton.h"

@class IGELight;

//! ライトマネージャ
@interface IGELightManager : IGESingleton {
}

@property (assign, nonatomic) IGELight* currentLight;

- (void)updateAtTime:(float)time;
- (void)addLight:(IGELight*)Light;
- (void)removeLight:(IGELight*)Light;
- (void)removeLightByID:(unsigned long)ID;
- (void)removeAllLights;
- (IGELight*)findLightByID:(unsigned long)ID;
- (void)changeLightByID:(unsigned long)ID;

@end
