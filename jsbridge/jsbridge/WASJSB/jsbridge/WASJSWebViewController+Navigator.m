//
//  WASJSWebViewController+Navigator.m
//  JSBridge
//
//  Created by boguang on 15/3/20.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSWebViewController+Navigator.h"
#import "UIViewController+JSNavigator.h"

@implementation WASJSWebViewController (Navigator)

- (void) jsapi_actionOpen:(NSDictionary *)parames {
    NSString *page = parames[@"page"];
    BOOL modal = [parames[@"modal"] boolValue] ;
    BOOL animated = (parames[@"animated"] ? [parames[@"animated"] boolValue] : YES);
    [self b5mjsOpen:page withQuery:parames modal:modal animated:animated];
}

- (void) jsapi_actionBack:(NSDictionary *)parames {
    BOOL animated = (parames[@"animated"] ? [parames[@"animated"] boolValue] : YES);
    [self.navigationController popViewControllerAnimated:animated];
}

- (void) jsapi_actionDismiss:(NSDictionary *)parames {
    BOOL animated = (parames[@"animated"] ? [parames[@"animated"] boolValue] : YES);
    [self dismissViewControllerAnimated:animated completion:nil];
}

- (void) jsapi_actionGetQuery:(NSDictionary *)parames {
    [self jsCallbackForId:parames[@"callbackId"] withRetValue:self.jsQuery];
}

@end
