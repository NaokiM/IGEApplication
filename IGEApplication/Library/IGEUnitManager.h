//
//  IGEUnitManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGESingleton.h"

@class IGEUnit;

//! ユニットマネージャ
@interface IGEUnitManager : IGESingleton {
}

- (void)updateAtTime:(float)time;
- (void)render;
- (void)addUnit:(IGEUnit*)unit;
- (void)removeUnit:(IGEUnit*)unit;
- (void)removeUnitByID:(unsigned long)ID;
- (void)removeAllUnits;
- (IGEUnit*)findUnitByID:(unsigned long)ID;

@end
