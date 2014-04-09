//
//  IGEShaderManager.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.h"
#import "IGESingleton.h"

@class IGEShader;

//! シェーダマネージャ
@interface IGEShaderManager : IGESingleton {
}

@property (assign, nonatomic) IGEShader* currentShader;

- (void)updateAtTime:(float)time;
- (void)addShader:(IGEShader*)shader;
- (void)removeShader:(IGEShader*)shader;
- (void)removeShaderByID:(unsigned long)ID;
- (void)removeAllShaders;
- (IGEShader*)findShaderByID:(unsigned long)ID;
- (void)changeShaderByID:(unsigned long)ID;

@end
