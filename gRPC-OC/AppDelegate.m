//
//  AppDelegate.m
//  gRPC-OC
//
//  Created by Johnhao on 2021/9/16.
//

#import "AppDelegate.h"
#import "HomeVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [[HomeVC alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
