//
//  WASJSWebViewController.h
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WASJSWebViewController : UIViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *page;

- (void) jsCallbackForId:(NSString *) callback withRetValue:(NSDictionary *) parames;

@end
