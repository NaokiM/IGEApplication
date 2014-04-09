//
//  IGESceneManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGESingleton.h"

@class IGEScene;

//! シーンマネージャ
@interface IGESceneManager : IGESingleton {
}

@property (assign, nonatomic) IGEScene* currentScene;

- (void)updateAtTime:(float)time;
- (void)changeScene:(IGEScene*)scene;
- (void)removeScene;

@end
