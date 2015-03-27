//
//  WASJSPageManager.h
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASJSPageManager : NSObject
@property (nonatomic, strong, readonly) NSDictionary *pageConfig;
+ (instancetype) sharedInstance;

- (NSURL *) URL4Page:(NSString *)page;

@end
