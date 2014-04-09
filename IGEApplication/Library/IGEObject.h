//
//  IGEObject.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"

//! オブジェクト
@interface IGEObject : NSObject {
}

@property (assign, nonatomic) unsigned long ID;
@property (assign, nonatomic) BOOL willDelete;
@property (assign, nonatomic) BOOL isPause;

- (void)updateAtTime:(float)time;

@end
