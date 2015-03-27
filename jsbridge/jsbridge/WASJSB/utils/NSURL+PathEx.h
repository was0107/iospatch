//
//  NSURL+PathEx.h
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(PathEx)

+(NSURL *) systemCachedURL;

+(NSURL *) systemTmpURL;

- (NSDictionary *)queryParams;
@end
