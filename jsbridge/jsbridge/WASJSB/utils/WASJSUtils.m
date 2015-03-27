//
//  WASJSUtils.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSUtils.h"

@implementation WASJSUtils

+ (NSString *) json2string:(NSDictionary *)dictionary {
    @try {
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            return nil;
        }
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    @catch(NSException *exception) {
        return nil;
    }
}

+ (NSDictionary *) string2json:(NSString *) string {
    if (0 == [string length]) {
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (!error) {
        return dictionary;
    }
    return nil;
}
@end
