//
//  AppDelegate.m
//  JSBridge
//
//  Created by boguang on 15/3/19.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

void  uncaughtExceptionHandler(NSException * exception) {
    NSLog(@"CRASH : %@", exception);
    NSLog(@"Stack Trace : %@", [exception callStackSymbols]);
}

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#ifdef DEBUG
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
#endif
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hybird"];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:@"Files"];
    NSLog(@"Source Path: %@\n Documents Path: %@ \n Folder Path: %@", sourcePath, documentsDirectory, folderPath);
    
    NSError *error;
    
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath
                                            toPath:documentsDirectory
                                             error:&error];
    
    if (error) {
        
        NSLog(@"Error description-%@ \n", [error localizedDescription]);
        NSLog(@"Error reason-%@", [error localizedFailureReason]);
    }
    
    
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *folder = [NSString stringWithFormat:@"%@/hybird/packages/",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
//    if (![fileManager fileExistsAtPath:folder]) {
//        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    
//    NSFileManager *manager = [NSFileManager defaultManager];
//    NSString *bundleConfig = [[NSBundle mainBundle] pathForResource:@"pages" ofType:@"json"];
//    NSString *path = folder;//[[NSString alloc] initWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
//    
//    NSError *eror = nil;
//    if ([manager isReadableFileAtPath:bundleConfig ]) {
//        BOOL FLAG = [manager copyItemAtURL:[NSURL fileURLWithPath:bundleConfig] toURL:[NSURL fileURLWithPath:path] error:&eror];
//        if (!FLAG && eror) {
//            NSLog(@"eror = %@", eror);
//        }
//    }
    
    
//    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hybird"];
//    
//    
//    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths1 objectAtIndex:0];
//    
//    NSError *error1;
//    NSArray *resContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:sourcePath error: &error1];
//    if (error1) {
//        NSLog(@"error1 : %@",error1);
//    }
//    [resContents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//     {
//         NSError* error;
//         if (![[NSFileManager defaultManager]
//               copyItemAtPath:[sourcePath stringByAppendingPathComponent:obj]
//               toPath:[documentsDirectory stringByAppendingPathComponent:obj]
//               error:&error])
//         NSLog(@"%@", [error localizedDescription]);
//     }];
    
    
   
    
    
    ViewController *vc = [ViewController new];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
