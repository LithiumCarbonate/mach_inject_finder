//
//  AppDelegate.h
//  mach_inject_finder_loader
//
//  Created by TanHao on 13-2-17.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class STPrivilegedTask;
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    STPrivilegedTask *task;
    NSTimer *timer;
}

@property (assign) IBOutlet NSWindow *window;

@end
