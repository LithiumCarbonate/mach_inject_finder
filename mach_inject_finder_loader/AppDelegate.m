//
//  AppDelegate.m
//  mach_inject_finder_loader
//
//  Created by TanHao on 13-2-17.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import "AppDelegate.h"
#import "STPrivilegedTask.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mach_inject_finder" ofType:@"app"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    path = [bundle executablePath];
    
    task = [[STPrivilegedTask alloc] initWithLaunchPath: path];
    [task launch];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkTask:) userInfo:nil repeats:YES];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSArray *applications = [NSRunningApplication runningApplicationsWithBundleIdentifier:bundle.bundleIdentifier];
        if ([applications count] > 0)
        {
            NSRunningApplication *app = [applications objectAtIndex:0];
            [app activateWithOptions:NSApplicationActivateAllWindows|NSApplicationActivateIgnoringOtherApps];
        }
    });
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    [task terminate];
    return NSTerminateNow;
}

- (void)checkTask:(id)sender
{
    if (!task.isRunning)
    {
        [NSApp terminate:nil];
    }
}

@end
