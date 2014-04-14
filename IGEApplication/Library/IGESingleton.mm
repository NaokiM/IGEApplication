//
//  IGESingleton.mm
//
//  Created by Naoki.M on 2013/09/02.
//  Copyright (c) 2013年 Naoki.M. All rights reserved.
//

#import "IGESingleton.hh"

@interface IGESingleton () {
}

@end

@implementation IGESingleton

static NSMutableDictionary* _instances;

+ (id)createInstance
{
    __block IGESingleton* instance;
    @synchronized(self) {
        if ([_instances objectForKey:NSStringFromClass(self)] == nil) {
            instance = [[self alloc] init];
        }
    }
    instance = [_instances objectForKey:NSStringFromClass(self)];
    return instance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    @synchronized(self) {
        if ([_instances objectForKey:NSStringFromClass(self)] == nil) {
            id instance = [super allocWithZone:zone];
            if (_instances == nil) {
                _instances = [[NSMutableDictionary alloc] initWithCapacity:0];
            }
            [_instances setObject:instance forKey:NSStringFromClass(self)];
            return instance;
        }
    }
    return nil;
}

+ (void)deleteInstance
{
    @synchronized(self) {
		if (self) {
			id instance = [_instances objectForKey:NSStringFromClass(self)];
			if (instance) {
				[_instances removeObjectForKey:NSStringFromClass(self)];
			}
		}
	}
}

+ (id)getInstance
{
	return [_instances objectForKey:NSStringFromClass(self)];
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain
{
	return self;
}

- (NSUInteger)retainCount
{
	return UINT_MAX;  // 解放できないオブジェクトであることを示す
}

- (oneway void)release
{
	@synchronized(self) {
		[super release];
	}
}

- (id)autorelease
{
	return self;
}

@end
