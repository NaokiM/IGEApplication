//
//  IGETouchManager.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "AppDelegate.hh"
#import "ViewController.hh"
#import "IGETouchManager.hh"

@interface IGETouchManager () {
	UIView* _view;
	UITapGestureRecognizer* _singleTapGestureRecognizer;
	BOOL _tempIsSingleTap;
	CGPoint _tempTapPoint;
}

- (void)singleTapGestureHandler:(UITapGestureRecognizer*)sender;

@end

@implementation IGETouchManager

- (id)init
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	AppDelegate* appDelegete = [[UIApplication sharedApplication] delegate];
	ViewController* viewController = (ViewController*)appDelegete.window.rootViewController;
	_view = viewController.view;

	_singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureHandler:)];
	_singleTapGestureRecognizer.numberOfTapsRequired = 1;
	[_view addGestureRecognizer:_singleTapGestureRecognizer];

	return self;
}

- (void)dealloc
{
	[_view removeGestureRecognizer:_singleTapGestureRecognizer];
	[_singleTapGestureRecognizer release];

	_view = nil;

    [super dealloc];
}

- (void)updateAtTime:(float)time
{
	_isSingleTap = _tempIsSingleTap;
	_tapPoint = _tempTapPoint;

	_tempIsSingleTap = NO;
	_tempTapPoint = CGPointMake(-1000.0f, -1000.0f);
}

- (void)singleTapGestureHandler:(UITapGestureRecognizer*)sender
{
	_tempTapPoint = [sender locationInView:sender.view];
	_tempIsSingleTap = YES;
}

@end
