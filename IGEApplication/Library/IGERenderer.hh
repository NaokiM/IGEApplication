//
//  IGERenderer.h
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGECommon.hh"
#import "IGESingleton.hh"

//! レンダラ
@interface IGERenderer : IGESingleton {
}

@property (strong, nonatomic) GLKView* glkView;
@property (strong, nonatomic) EAGLContext* context;

- (void)createContext;
- (void)deleteContext;
- (void)setupRender;

@end
