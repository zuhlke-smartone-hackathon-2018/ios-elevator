//
//  AppDelegate.m
//  SmartoneHackElevator
//
//  Created by Brian Chung on 20/10/2018.
//  Copyright © 2018 Brian Chung. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) ViewController *rootViewController;
@property (nonatomic, assign) Boolean recognizeLiftPush;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                            UIUserNotificationTypeSound |
                                            UIUserNotificationTypeAlert |
                                            UIUserNotificationTypeBadge categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    self.recognizeLiftPush = true;
    self.rootViewController = (ViewController *)self.window.rootViewController;
    
    /*
    NSMutableDictionary *apsInfo = [[NSMutableDictionary alloc] init];
    [apsInfo setObject:@true forKey:@"elevator"];
    [apsInfo setObject:@true forKey:@"aircon"];
    
    
    NSMutableDictionary *dummyInfo = [[NSMutableDictionary alloc] init];
    [dummyInfo setObject:apsInfo forKey:@"apsInfo"];
    [dummyInfo setObject:apsInfo forKey:@"aps"];
    self.rootViewController = (ViewController *)self.window.rootViewController;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        //Run UI Updates
        NSDictionary *fakePushData = [self generateDummyPushData];
        [self updateImage:fakePushData];
    });*/
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) application:(UIApplication *) application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken {
    SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:HUBLISTENACCESS
                                                             notificationHubPath:HUBNAME];
    
    [hub registerNativeWithDeviceToken:deviceToken tags:nil completion:^(NSError* error) {
        if (error != nil) {
            NSLog(@"Error registering for notifications: %@", error);
        } else {
            NSLog(@"registering for notifications successfully");
        }
    }];
}

-(void)MessageBox:(NSString *) title message:(NSString *)messageText {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:messageText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
    // "{\"aps\":{ \"elevator\": true, \"aircon\": true }}"
    // [self MessageBox:@"Notification" message:[[userInfo objectForKey:@"aps"] valueForKey:@"alert"]];
    [self updateImage:userInfo];
}

- (void)updateImage:(NSDictionary *)userInfo {
    NSString *airImageName = @"air";
    NSString *liftImageName = @"lift";
    if (self.recognizeLiftPush) {
        NSNumber* isElevator = (NSNumber *)[[userInfo objectForKey:@"aps"] objectForKey:@"elevator"];
        if ([isElevator integerValue] == 1) {
            [self.rootViewController updateImage:liftImageName];
        }
    } else {
        NSNumber* isAircon = (NSNumber *)[[userInfo objectForKey:@"aps"] objectForKey:@"aircon"];
        if ([isAircon integerValue] == 1) {
            [self.rootViewController updateImage:airImageName];
        }
    }
}

- (NSDictionary *)generateDummyPushData {
    NSMutableDictionary *apsInfo = [[NSMutableDictionary alloc] init];
    [apsInfo setObject:@1 forKey:@"elevator"];
    [apsInfo setObject:@1 forKey:@"aircon"];
    
    NSMutableDictionary *dummyInfo = [[NSMutableDictionary alloc] init];
    [dummyInfo setObject:apsInfo forKey:@"aps"];
    return dummyInfo;
}

@end
