//
//  IGERenderer.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "AppDelegate.hh"
#import "ViewController.hh"
#import "IGERenderer.hh"

@interface IGERenderer () {
}

- (void)initializeOpenGL;
- (void)shutdownOpenGL;

@end

@implementation IGERenderer

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	AppDelegate* appDelegete = [[UIApplication sharedApplication] delegate];
	ViewController* viewController = (ViewController*)appDelegete.window.rootViewController;
	self.glkView = (GLKView*)viewController.view;

	[self createContext];

	return self;
}

- (void)dealloc
{
	[self deleteContext];

    [super dealloc];
}

- (void)createContext
{
    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2] autorelease];
	
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
	
	self.glkView.context = self.context;
    self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
	
	[self initializeOpenGL];
}

- (void)deleteContext
{
    [self shutdownOpenGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [_context release];
}

- (void)initializeOpenGL
{
    [EAGLContext setCurrentContext:self.context];

    glEnable(GL_DEPTH_TEST);
}

- (void)shutdownOpenGL
{
    [EAGLContext setCurrentContext:self.context];
}

- (void)setupRender
{
	glClearColor(0.3f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
}

@end
