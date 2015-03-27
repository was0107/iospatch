//
//  WASJSUtils.h
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASJSUtils : NSObject

+ (NSString *) json2string:(NSDictionary *)dictionary;

+ (NSDictionary *) string2json:(NSString *) string;
@end
