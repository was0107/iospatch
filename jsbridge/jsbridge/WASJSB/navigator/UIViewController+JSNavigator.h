//
//  UIViewController+JSNavigator.h
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JSNavigator)
@property (nonatomic, strong) NSDictionary *jsQuery;

- (void) b5mjsOpen:(NSString *)page;

- (void) b5mjsOpen:(NSString *)page withQuery:(NSDictionary *) parames;

- (void) b5mjsOpen:(NSString *)page withQuery:(NSDictionary *) parames modal:(BOOL) modal animated:(BOOL) animated;
@end
