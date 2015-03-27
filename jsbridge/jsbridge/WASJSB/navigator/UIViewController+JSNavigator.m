//
//  UIViewController+JSNavigator.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "UIViewController+JSNavigator.h"
#import <objc/runtime.h>
#import "WASJSPageManager.h"
#import "WASJSWebViewController.h"

static const char * jsqueryTag = "jsqueryTag";

@implementation UIViewController(JSNavigator)

- (void) setJsQuery:(NSDictionary *)jsQuery1 {
    objc_setAssociatedObject(self, jsqueryTag, jsQuery1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *) jsQuery {
    return objc_getAssociatedObject(self, jsqueryTag);
}

- (void) b5mjsOpen:(NSString *)page {
    [self b5mjsOpen:page  withQuery:nil];
}

- (void) b5mjsOpen:(NSString *)page withQuery:(NSDictionary *) parames {
    [self b5mjsOpen:page  withQuery:parames modal:NO animated:YES];
}

- (void) b5mjsOpen:(NSString *)page withQuery:(NSDictionary *) parames modal:(BOOL) modal animated:(BOOL) animated {
    UIViewController *controller = [self viewControllerForPage:page];
    if (!controller) {
        return;
    }
    controller.jsQuery = parames;
    if (modal) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:animated completion:nil];

    } else {
        [self.navigationController pushViewController:controller animated:animated];
    }
}


- (UIViewController *) viewControllerForPage:(NSString *)page {
    NSDictionary *dictionary = [WASJSPageManager sharedInstance].pageConfig[page];
    if (dictionary[@"class"]) {
        Class clz = NSClassFromString(dictionary[@"class"]);
        if (clz) {
            UIViewController *controller = [clz new];
            if ([controller respondsToSelector:@selector(setJsQuery:)]) {
                return controller;
            }
            else {
                NSLog(@"error: page %@ class %@ not UIViewController+JSNavigator",page,clz);
            }
        }
    }
    
    WASJSWebViewController *controller = [WASJSWebViewController new];
    controller.page = page;
    return controller;
}
@end
