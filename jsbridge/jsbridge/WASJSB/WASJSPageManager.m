//
//  WASJSPageManager.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSPageManager.h"
#import "WASJSUtils.h"

@implementation WASJSPageManager

+ (instancetype) sharedInstance {
    static WASJSPageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[WASJSPageManager alloc] init];
        }
    });
    return manager;
}

- (id) init {
    self = [super init];
    if (self) {
        _pageConfig = [self loadBundlePageConfig];
    }
    return self;
}

- (NSDictionary *) loadBundlePageConfig {

    NSString *bundleConfig = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"json"];
    NSError *error = nil;
    NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:bundleConfig] encoding:NSUTF8StringEncoding error:&error];
    if (!error) {
        return [WASJSUtils string2json:content];
    }
    return nil;
}

- (NSURL *) URL4Page:(NSString *)page {
    
    //TODO DEBUG PATH SET HERE
    
    
    NSDictionary *dictionary = [self.pageConfig objectForKey:page];
    if (dictionary && [dictionary objectForKey:@"url"]) {
        return [NSURL URLWithString:[dictionary objectForKey:@"url"]];
    }
    else {
    
        //TODO LOAD FROM DOWNLOAD PATH
        
        
        
        //LOAD FROM BUNDLE
        NSString *path = [[NSBundle mainBundle] pathForResource:page ofType:@"html"];
        if (path) {
            return [NSURL URLWithString:path];
        }
    }
    return nil;
}
@end
