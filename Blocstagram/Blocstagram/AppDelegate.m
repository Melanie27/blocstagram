//
//  AppDelegate.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/2/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "AppDelegate.h"
#import "ImagesTableViewController.h"
#import "LoginViewController.h"
#import "DataSource.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //manually create and assign a view controller as the app's root view controller because we deleted the main storyboard
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //create the data source (so it can receive access token notification)
    [DataSource sharedInstance];
    
    UINavigationController *navVC = [[UINavigationController alloc] init];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [navVC setViewControllers:@[loginVC] animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:LoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
       
        ImagesTableViewController *imagesVC = [[ImagesTableViewController alloc] init];
        [navVC setViewControllers:@[imagesVC] animated:YES];
        
    }];
    
    self.window.rootViewController = navVC;
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    //convenience method to bring the current window to the front
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
