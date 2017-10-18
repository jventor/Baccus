//
//  AppDelegate.m
//  Empty Application
//
//  Created by Jaime Ventor on 13/9/17.
//  Copyright © 2017 Jaime Ventor. All rights reserved.
//

#import "AppDelegate.h"
#import "JVWineModel.h"
#import "JVWineViewController.h"
#import "JVWebViewController.h"
#import "JVWineryModel.h"
#import "JVWineryTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    //creamos el modelo
    JVWineryModel *winery = [[JVWineryModel alloc] init];
    
    //creamos los controladores
    JVWineryTableViewController *wineryVC = [[JVWineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain];
    JVWineViewController *wineVC = [[JVWineViewController alloc] initWithModel:[winery redWineAtIndex:0]];
    
    //Creamos los navigation
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    UINavigationController *wineNav = [[UINavigationController alloc] initWithRootViewController:wineVC];
    
    
    //Creamos el splitviewcontroler
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    
    splitVC.viewControllers = @[wineryNav,wineNav];
    
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    self.window.rootViewController = splitVC;
    
    
    self.window.backgroundColor = [UIColor orangeColor ];
    //self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
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


@end
