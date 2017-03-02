//
//  AppDelegate.m
//  SampleSip
//
//  Created by Nagendar Reddy on 20/02/17.
//  Copyright © 2017 Nagendar Reddy. All rights reserved.
//

#import "AppDelegate.h"
#import "UCCallHandleManger.h"
#import "PhoneViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Set Navigation Bar Color
 //   [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(230/255.0) green:(88/255.0) blue:(83/255.0) alpha:1.0]];
    
    // Set Status Bar Style
  //  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    
    [[UCCallHandleManger shartedinstance] signOut];
   
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    if (userName != nil && password != nil) {
        if (![userName isEqualToString:@""] && ![password isEqualToString:@""]) {
            UConnectStatus status=[[UConnect getSharedInstance] configAPIKey:@"no" withServer:@"192.168.36.67" appName:@"nn"];
            
            if (status == UConnectStatus_OK) {
                UConnectStatus loginSuccess =[[UConnect getSharedInstance] login:userName withPassword:password];
                if(loginSuccess == UConnectStatus_Wrong_Credentails) {
                    
                }
                [[UConnect getSharedInstance] configPhoneDelegate:[UCCallHandleManger shartedinstance]];
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                PhoneViewController *phone = [mainStoryboard instantiateViewControllerWithIdentifier:@"phone"];
                self.window.rootViewController = phone;
            }
        }
    }
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
