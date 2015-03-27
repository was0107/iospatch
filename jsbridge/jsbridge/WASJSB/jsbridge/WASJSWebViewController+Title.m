//
//  WASJSWebViewController+Title.m
//  JSBridge
//
//  Created by boguang on 15/3/20.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSWebViewController+Title.h"

@implementation WASJSWebViewController (Title)

- (void) jsapi_setTitle:(NSDictionary *)parames {
    self.title = parames[@"title"];
}
@end
