//
//  RSAppDelegate.m
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSAppDelegate.h"

#import "RSArticle.h"

#import "RSReadingBoard.h"

@implementation RSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RSReadingBoard *board = [RSReadingBoard board];
    RSArticle *article = [RSArticle new];
    article.image = [UIImage imageNamed:@"image"];
    article.title = @"MH370: Angry families march on Malaysian Embassy in Beijing";
    article.source = @"By Sophie Brown, CNN";
    article.date = @"March 25, 2014 -- Updated 1129 GMT (1929 HKT)";
    article.body = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] URLForResource:@"Body" withExtension:@"txt"] path] encoding:NSUTF8StringEncoding error:nil];
    article.color = [UIColor blackColor];
    article.clips = @[[UIImage imageNamed:@"clip0"],
                      [UIImage imageNamed:@"clip1"],
                      [UIImage imageNamed:@"clip2"]];
    board.article = article;
    [(UINavigationController *)self.window.rootViewController setViewControllers:@[board]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
