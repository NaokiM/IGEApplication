//
//  IGEUnitManager.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGEUnitManager.hh"
#import "IGEUnit.hh"
#import "IGECamera.hh"
#import "IGECameraManager.hh"
#import "IGELight.hh"
#import "IGELightManager.hh"
#import "IGEShader.hh"
#import "IGEShaderManager.hh"

@interface IGEUnitManager () {
	NSMutableArray* _unitArray;
}

@end

@implementation IGEUnitManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_unitArray = [[NSMutableArray alloc] init];
	IGE_NULL_ASSERT(_unitArray);

	return self;
}

- (void)dealloc
{
	[_unitArray release];

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	// 実際に削除
	for (IGEUnit* unit in [_unitArray reverseObjectEnumerator]) {
		if (unit.willDelete) {
			[_unitArray removeObject:unit];
		}
	}
	
	// updateの実行
	for (IGEUnit* unit in _unitArray) {
		if (unit.isPause) {
			continue;
		}
		
		[unit updateAtTime:time];
	}
}

- (void)render
{
	// renderの実行
	for (IGEUnit* unit in _unitArray) {
		if (unit.willDelete) {
			continue;
		}
		if (unit.isHide) {
			continue;
		}

		IGECameraManager* cameraManager = (IGECameraManager*)[IGECameraManager getInstance];
		[cameraManager changeCameraByID:unit.cameraID];
		IGECamera* camera = cameraManager.currentCamera;

		IGELightManager* lightManager = (IGELightManager*)[IGELightManager getInstance];
		[lightManager changeLightByID:unit.lightID];
		IGELight* light = lightManager.currentLight;
		
		IGEShaderManager* shaderManager = (IGEShaderManager*)[IGEShaderManager getInstance];
		[shaderManager changeShaderByID:unit.shaderID];
		IGEShader* shader = shaderManager.currentShader;

		[shader setUniformWorldMatrix:unit.worldMatrix];
		[shader setUniformViewMatrix:camera.viewMatrix];
		[shader setUniformProjectionMatrix:camera.projectionMatrix];
		[shader setUniformAmbientLightColor:light.ambientLightColor];
		[shader setUniformDiffuseLightColor:light.diffuseLightColor];
		[shader setUniformDiffuseLightVector:light.diffuseLightVector worldMatrix:unit.worldMatrix];
		[shader setUniformCameraPosition:camera.positon worldMatrix:unit.worldMatrix];

		[unit render];
	}
}

- (void)addUnit:(IGEUnit*)unit
{
	[_unitArray addObject:unit];
	[unit release];	// 所有権をマネージャに任せるようにしています
}

- (void)removeUnit:(IGEUnit*)unit
{
	unit.willDelete = YES;
}

- (void)removeUnitByID:(unsigned long)ID
{
	for (IGEUnit* unit in _unitArray) {
		if (unit.ID == ID) {
			unit.willDelete = YES;
			return;
		}
	}
}

- (void)removeAllUnits
{
	for (IGEUnit* unit in _unitArray) {
		unit.willDelete = YES;
	}
}

- (IGEUnit*)findUnitByID:(unsigned long)ID
{
	for (IGEUnit* unit in _unitArray) {
		if (unit.ID == ID) {
			return unit;
		}
	}
	
	return nil;
}

@end
