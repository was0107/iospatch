//
//  WASJSWebViewController+Ajax.m
//  JSBridge
//
//  Created by boguang on 15/3/20.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSWebViewController+Ajax.h"
#import <JSONModel/JSONHTTPClient.h>
#import "WASJSUtils.h"

@implementation WASJSWebViewController(Ajax)

- (void) jsapi_ajax:(NSDictionary *)parames {
    NSString *url = parames[@"url"];
    NSString *method = parames[@"method"]?:@"GET";
    [JSONHTTPClient JSONFromURLWithString:url method:method params:parames orBodyString:nil headers:parames[@"header"] completion:^(id json, JSONModelError *err) {
        if (!err) {
            [self _ajaxSucces:json parames:parames];
        } else {
            [self _ajaxFailWithCode:-1 message:err.localizedDescription parames:parames];
        }
    } ];
    
}

- (void) _ajaxSucces:(NSDictionary *) json parames:(NSDictionary *)parames {
    [self jsCallbackForId:parames[@"callbackId"] withRetValue:@{@"code":@"0", @"response": [WASJSUtils json2string:json] ?:@""}];
}

- (void) _ajaxFailWithCode:(NSInteger) code message:(NSString *) message parames:(NSDictionary *) parames {
    [self jsCallbackForId:parames[@"callbackId"] withRetValue:@{@"code":@(code), @"message":message ?:@""}];
}

@end
