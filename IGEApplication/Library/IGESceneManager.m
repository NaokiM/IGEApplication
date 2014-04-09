//
//  IGESceneManager.m
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGESceneManager.h"
#import "IGEScene.h"

@interface IGESceneManager () {
	IGEScene* _newScene;
	BOOL _sceneChanged;
}

@end

@implementation IGESceneManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_currentScene = nil;
	_newScene = nil;
	_sceneChanged = NO;

	return self;
}

- (void)dealloc
{
	if (_currentScene != nil) {
		[_currentScene release];
		_currentScene = nil;
	}
	if (_newScene != nil) {
		[_newScene release];
		_newScene = nil;
	}

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	// シーンの変更
	//! @note ここで変更している理由は、どのタイミングから呼ばれても、必ずupdate→renderの順になるようにしたいため
	if (_sceneChanged == YES) {
		if (_newScene != nil) {
			// [_newScene retain]; //! @note retainをしないのは所有権を移したいため
		}
		if (_currentScene != nil) {
			[_currentScene release];
		}

		_currentScene = _newScene;
		_newScene = nil;
		_sceneChanged = NO;
	}
	
	if (_currentScene != nil) {
		[_currentScene updateAtTime:time];
	}
}

- (void)changeScene:(IGEScene *)scene
{
	_newScene = scene;
	_sceneChanged = YES;
}

- (void)removeScene
{
	if (_currentScene != nil) {
		[_currentScene release];
		_currentScene = nil;
	}
}

@end
