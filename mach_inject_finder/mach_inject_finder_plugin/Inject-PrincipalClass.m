//
//  Inject-PrincipalClass.m
//  mach_inject_finder
//
//  Created by TanHao on 13-2-17.
//  Copyright (c) 2013年 http://www.tanhao.me. All rights reserved.
//

#import "Inject-PrincipalClass.h"

@implementation Inject_PrincipalClass

+ (id)enumView:(NSView *)aView
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *subViews = [aView subviews];
    for (NSView *subView in subViews)
    {
        id result = [self enumView:subView];
        if (result)
        {
            [array addObject:result];
        }
    }
    
    /*
    //图标视图模式下的View
    if ([aView isKindOfClass:NSClassFromString(@"TIconView")])
    {
        
    }
    */
    
    return [NSDictionary dictionaryWithObject:array forKey:NSStringFromClass(aView.class)];
}

+ (void)load
{
    NSArray *windows = [NSApp windows];
    if ([windows count] > 0)
    {
        for (NSWindow *aWindow in windows)
        {
            [aWindow setTitle:@"已经注入成功！"];
            //此为Finder的窗口
            if ([NSStringFromClass(aWindow.class) isEqualToString:@"TBrowserWindow"])
            {
                NSLog(@"视图的层级关系图:%@",[self enumView:aWindow.contentView]);
            }
        }
    }
}

@end
