//
//  ViewController.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "ViewController.h"
#import "WASJSWebViewController.h"

@interface ViewController ()
@property (nonatomic, strong) WASJSWebViewController *controller ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.controller = [[WASJSWebViewController alloc ] init];
    self.controller.view.frame = self.view.bounds;
    self.controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.controller.view];
    [self addChildViewController:self.controller];
    self.controller.page = @"home";

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Debug Config" style:UIBarButtonItemStylePlain target:self action:@selector(onLeftBarButtonItemClick)];
}

- (void)onLeftBarButtonItemClick
{
    ViewController *vc = [ViewController new];
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onEfteDebugLeftBarButtonItemClick)];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onEfteDebugLeftBarButtonItemClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
