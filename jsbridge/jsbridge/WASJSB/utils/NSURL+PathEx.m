//
//  NSURL+PathEx.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "NSURL+PathEx.h"

@implementation NSURL(PathEx)

+(NSURL *) systemCachedURL {
    
    NSFileManager *manage = [NSFileManager defaultManager];
    NSArray *documentArrays = [manage URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSURL *outURL = [documentArrays lastObject];
    return outURL;
}

+(NSURL *) systemTmpURL {
    NSString *tmpPath = NSTemporaryDirectory();
    NSURL *outURL = nil;
    if (tmpPath) {
        outURL = [NSURL URLWithString:tmpPath];
    }
    return outURL;
}

- (NSDictionary *)queryParams {
    if (!self.query) {
        return nil;
    }
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSArray *pairs = [self.query componentsSeparatedByString:@"&"];
    for (NSString *kv in pairs) {
        NSArray *compare = [kv componentsSeparatedByString:@"="];
        if ([compare count] <= 1) {
            continue;
        }
        NSString *key = [[compare objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [[compare objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dictionary setValue:value forKey:key];
    }
//    NSLog(@"dictionary = %@", dictionary);
    return dictionary;
}

@end
