//
//  ModalViewController.m
//  JSBridge
//
//  Created by boguang on 15/3/23.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "ModalViewController.h"
#import "WASJSUtils.h"
#import "UIViewController+JSNavigator.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"test1, click to dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 300, 300, 100)];
    textView.text = [NSString stringWithFormat:@"query: %@", [WASJSUtils json2string:self.jsQuery]];
    [self.view addSubview:textView];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
