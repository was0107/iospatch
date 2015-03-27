//
//  WASJSWebViewController.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSWebViewController.h"
#import "NSURL+PathEx.h"
#import "WASJSUtils.h"
#import "UIViewController+JSNavigator.h"
#import "WASJSPageManager.h"

@interface WASJSWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation WASJSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    for (UIView *view in [[self.webView.subviews firstObject] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self setupRefreshControl];
    if (self.page) {
        [self loadPage];
    }
}

- (void) setPage:(NSString *)page
{
    _page = page;
    if (self.isViewLoaded) {
        [self loadPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupRefreshControl {
    if (!self.refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
    }
    [self.refreshControl addTarget:self action:@selector(onRefreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];;
    [self.webView.scrollView addSubview:self.refreshControl];
}

- (void)onRefreshControlValueChanged:(UIRefreshControl *) control {
    NSString *ret = [self.webView stringByEvaluatingJavaScriptFromString:@"javascript:(function(){if(typeof (B5MApp.startRefresh) == 'function') {setTimeout(B5MApp.startRefresh,0); return 1;} else {window.location.reload();return 2;}})()"];
    if (2 == [ret intValue]) {
        [self endRefreshing];
    }
}
- (void) loadPage {
    NSURL *url = [[WASJSPageManager sharedInstance] URL4Page:self.page];
    if (!url) {
        url = [[WASJSPageManager sharedInstance] URL4Page:@"404"];
    }
    
    [self.webView stopLoading];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [self.webView loadRequest:request];
}

- (void) endRefreshing {
    [self.refreshControl endRefreshing];
}

- (void) jsapi_stopRefresh:(NSDictionary *)parames {
    [self endRefreshing];
}

- (NSString *) jsScheme {
    return @"js://";
}

- (NSString *) urlScheme {
    return @"b5mjs://";
}

- (NSString *) jsapiMethodPrefix {
    return @"jsapi_";
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"webview current url =  %@", urlString);

    if ([urlString hasPrefix:[self jsScheme]]) {
        [self handleMessage:[request.URL queryParams]];
        return NO;
    }
    if ([urlString hasPrefix:[self urlScheme]]) {
        NSDictionary *params = request.URL.queryParams;
        NSString *host = request.URL.host;
        NSString *path = request.URL.path;
        NSString *page = host;
        if (path) {
            page = [NSString stringWithFormat:@"%@%@",host,path];
        }
        [self b5mjsOpen:page withQuery:params];
        return NO;
    }
    return YES;
}

- (void) handleMessage:(NSDictionary *) params {
    SEL select = [self selectorForMethod:[params objectForKey:@"method"]];
    if (![self respondsToSelector:select]) {
        NSLog(@"can not handle message %@", params);
        return;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:select withObject:[WASJSUtils string2json:params[@"args"]]];
#pragma clang diagnostic pop
}

- (SEL) selectorForMethod:(NSString *) method {
    if ([method length] == 0) {
        return nil;
    }
    NSString *objMethod = [[[self jsapiMethodPrefix] stringByAppendingString:method] stringByAppendingString:@":"];
    return NSSelectorFromString(objMethod);
}

- (NSString *) stringFromDictionary:(NSDictionary *) dictionary {
    if (![NSJSONSerialization isValidJSONObject:dictionary]) return @"";
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


- (void) jsCallbackForId:(NSString *) callbackId withRetValue:(NSDictionary *) parames {
    NSString *jsString = [NSString stringWithFormat:@"window.B5MApp.callback(%@,%@);", callbackId, [WASJSUtils json2string:parames]];
    NSLog(@"jsString = %@", jsString);
    [self.webView performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:jsString afterDelay:0];
}
@end
