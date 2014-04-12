//
//  ViewController.m
//  IGEApplication
//
//  Created by Naoki.M on 2014/04/08.
//  Copyright (c) 2014年 Naoki.M. All rights reserved.
//

#import "ViewController.h"
#import "Library/IGEGlobal.h"
#import "App/IGEAmbientShader.h"
#import "App/IGELambertShader.h"
#import "App/IGEBootScene.h"

@interface ViewController () {
	IGEFramework* _framework;
}

@end

@implementation ViewController

- (void)dealloc
{
	[IGEFramework deleteInstance];
	
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[IGEFramework createInstance];
	
	// カメラの作成と追加
	IGECamera* camera = [[IGECamera alloc] initWithName:@"DefaultCamera"];
	camera.positon  = GLKVector3Make(  0,   0,  10);
	camera.target   = GLKVector3Make(  0,   0,   0);
	camera.upVector = GLKVector3Make(  0,   1,   0);
	camera.near =    0.1f;
	camera.far  = 1000.0f;
	camera.fov = degreeToRadian(35.0f);
	float width = self.view.bounds.size.width;
	float height = self.view.bounds.size.height;
	camera.aspect = width / height;
	IGE_NULL_ASSERT(camera);
	[[IGECameraManager getInstance] addCamera:camera];
	
	// ライトの作成と追加
	IGELight* light = [[IGELight alloc] initWithName:@"DefaultLight"];
	light.diffuseLightColor = GLKVector4Make(1, 0, 0, 1);
	light.diffuseLightVector = GLKVector3Make(0, 0, -1);
	IGE_NULL_ASSERT(light);
	[[IGELightManager getInstance] addLight:light];
	
	// シェーダの作成と追加
	IGEShader* shader;
	shader = [[IGEAmbientShader alloc] initWithName:@"AmbientShader"];
	IGE_NULL_ASSERT(shader);
	[[IGEShaderManager getInstance] addShader:shader];
	shader = [[IGELambertShader alloc] initWithName:@"LambertShader"];
	IGE_NULL_ASSERT(shader);
	[[IGEShaderManager getInstance] addShader:shader];
	
	// 起動シーンの作成と追加
	IGEScene* scene = [[IGEBootScene alloc] init];
	IGE_NULL_ASSERT(scene);
	[[IGESceneManager getInstance] changeScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        if ([EAGLContext currentContext] == [[IGERenderer getInstance] context]) {
            [EAGLContext setCurrentContext:nil];
        }
		[IGEFramework deleteInstance];
        self.view = nil;
    }
	
    // Dispose of any resources that can be recreated.
}

- (void)update
{
	[[IGEFramework getInstance] update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	[[IGEFramework getInstance] render];
}

@end
