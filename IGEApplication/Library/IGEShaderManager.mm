//
//  IGEShaderManager.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEShaderManager.hh"
#import "IGEShader.hh"

@interface IGEShaderManager () {
	NSMutableArray* _shaderArray;
	unsigned long _currentID;
}

@end

@implementation IGEShaderManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_shaderArray = [[NSMutableArray alloc] init];
	IGE_NULL_ASSERT(_shaderArray);

	return self;
}

- (void)dealloc
{
	[_shaderArray release];

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	// 実際に削除
	for (IGEShader* shader in [_shaderArray reverseObjectEnumerator]) {
		if (shader.willDelete) {
			[_shaderArray removeObject:shader];
		}
	}
}

- (void)addShader:(IGEShader*)shader
{
	[_shaderArray addObject:shader];
	[shader release];	// 所有権をマネージャに任せるようにしています
}

- (void)removeShader:(IGEShader*)shader
{
	shader.willDelete = YES;
}

- (void)removeShaderByID:(unsigned long)ID
{
	for (IGEShader* shader in _shaderArray) {
		if (shader.ID == ID) {
			shader.willDelete = YES;
			return;
		}
	}
}

- (void)removeAllShaders
{
	for (IGEShader* shader in _shaderArray) {
		shader.willDelete = YES;
	}
}

- (IGEShader*)findShaderByID:(unsigned long)ID
{
	for (IGEShader* shader in _shaderArray) {
		if (shader.ID == ID) {
			return shader;
		}
	}
	
	return nil;
}

- (void)changeShaderByID:(unsigned long)ID
{
	if (_currentID != ID) {
		_currentID = ID;
		_currentShader = [self findShaderByID:_currentID];

		// 変更後のシェーダを有効にする
		if (_currentShader) {
			[_currentShader useProgram];
		}
	}
}

- (void)setUniformWorldMatrix:(const GLKMatrix4)matrix
{
	if (_currentShader) {
		[_currentShader setUniformWorldMatrix:matrix];
	}
}

- (void)setUniformViewMatrix:(const GLKMatrix4)matrix
{
	if (_currentShader) {
		[_currentShader setUniformViewMatrix:matrix];
	}
}

- (void)setUniformProjectionMatrix:(const GLKMatrix4)matrix
{
	if (_currentShader) {
		[_currentShader setUniformProjectionMatrix:matrix];
	}
}

@end
