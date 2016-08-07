//
//  AppDelegate.m
//  mach_inject_finder
//
//  Created by TanHao on 13-2-17.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import "AppDelegate.h"
#import <mach_inject_bundle/mach_inject_bundle.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //com.teiron.pphelper.mac
    //获取finder的pid
    NSArray *finderApps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.teiron.pphelper.mac"];
    if ([finderApps count] == 0) return;
    NSRunningApplication *finderApplication = [finderApps objectAtIndex:0];
    pid_t process_id = [finderApplication processIdentifier];
    
    //开始注入
	NSString *injectedBundlePath = [[NSBundle mainBundle] pathForResource:@"mach_inject_finder_plugin"
																   ofType:@"bundle"];
	assert( injectedBundlePath );
	
	mach_error_t err = mach_inject_bundle_pid( [injectedBundlePath fileSystemRepresentation],
                                              process_id );
    assert(!err);
}

@end
