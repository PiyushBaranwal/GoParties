//
//  AppDelegate.m
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>



@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize objHome,navigationController,objMain,objWeb;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //return YES;
    
//    ///to get the current lat and long
//    locManager = [[CLLocationManager alloc] init];
//    locManager.delegate=self;
//    locManager.desiredAccuracy=kCLLocationAccuracyBest;
//    locManager.distanceFilter=kCLDistanceFilterNone;
//    // [locManager requestWhenInUseAuthorization];
//    // [locManager startMonitoringSignificantLocationChanges];
//    [locManager startUpdatingLocation];
    
    logged=[[NSUserDefaults standardUserDefaults] boolForKey:@"userLoggedIn"];
    //direct lands on main page as user is alreday logged in
    if (logged==NO)
    {
        self.objHome = [[HomeViewController alloc] init];
        MenuViewController *rearViewController = [[MenuViewController alloc] init];
        
        //To set teh navigation bar color - .106,27,154
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:106.0/255 green:27.0/255 blue:154.0/255 alpha:1.00]];
        //to set teh navigation bar color
        // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:self.objHome];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        revealController.delegate = self;
        self.navigationController.navigationBarHidden = NO;
        
        self.viewController = revealController;
        
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];

    }
    else
    {
        NSString *webURL=[[NSUserDefaults standardUserDefaults] valueForKey:@"webURL"];
        self.objWeb=[[WebViewController alloc]init];
        self.objWeb.urlStr=webURL;
        MenuViewController *rearViewController = [[MenuViewController alloc] init];
        
        //To set teh navigation bar color - .106,27,154
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:106.0/255 green:27.0/255 blue:154.0/255 alpha:1.00]];
        //to set teh navigation bar color
        // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:self.objWeb];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        revealController.delegate = self;
        self.navigationController.navigationBarHidden = NO;
        
        self.viewController = revealController;
        
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];

    }
    
    
    
    
//    self.objHome = [[HomeViewController alloc] init];
//    MenuViewController *rearViewController = [[MenuViewController alloc] init];
//    
//    //To set teh navigation bar color - .106,27,154
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:106.0/255 green:27.0/255 blue:154.0/255 alpha:1.00]];
//    //to set teh navigation bar color
//    // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    
//    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:self.objHome];
//    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
//    
//    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
//    revealController.delegate = self;
//    self.navigationController.navigationBarHidden = NO;
//    
//    self.viewController = revealController;
//    
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];

    
    //revealController.bounceBackOnOverdraw=NO;
    //revealController.stableDragOnOverdraw=YES;
    
    
    
    //for facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
    
//     self.objHome = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] ;
//     self.navigationController =[[UINavigationController alloc] initWithRootViewController:self.objHome];
//        self.window.rootViewController = self.navigationController;
//        [self.window makeKeyAndVisible];
//        return YES;

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
    
     [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation
//            ];
    return ([[FBSDKApplicationDelegate sharedInstance] application:application
                                                           openURL:url
                                                 sourceApplication:sourceApplication
                                                        annotation:annotation]||[[GIDSignIn sharedInstance] handleURL:url
                                                                                                    sourceApplication:sourceApplication
                                                                                                           annotation:annotation] );
}

#pragma mark- delegate method of CLLOcationManager

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}



- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    curLat=newLocation.coordinate.latitude;
    curLong=newLocation.coordinate.longitude;
    
    
    NSLog(@"curLatStr=%f and curLongStr=%f",curLat,curLong);
    
    
    //to save the curlat and long in localdatabase
    //To save profile image in the app locally.
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.4f", curLat] forKey:@"UserCurLat"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.4f", curLong] forKey:@"UserCurLong"];
    
    
    
    
    //To get the Location Name from Lat And Long
    
    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(curLat, curLong)
                    completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                        // NSLog(@"placemarks = %@", placemarks);
                        NSMutableArray *subAdministrativeArea=[placemarks valueForKey:@"formattedAddress"];
                        
                        // NSLog(@"formattedAddress=%@",subAdministrativeArea);
                        NSString *locationStr=[subAdministrativeArea objectAtIndex:6];
                        NSLog(@"locStr=%@",locationStr);
                        //To save teh current loction in local database
                        // [[NSUserDefaults standardUserDefaults] setObject:locationStr forKey:@"LinkdeInUserLocationName"];
                        
                        
                    }];
    
    /*
     formattedAddress=(
     "E-66, E Block, Sector 6, Noida, Uttar Pradesh 110096, India",
     "E Block, Sector 6, Noida, Uttar Pradesh 110096, India",
     "Sector 6, Noida, Uttar Pradesh, India",
     "110096, India",
     "Noida, Uttar Pradesh, India",
     "Gautam Buddh Nagar, Uttar Pradesh, India",
     "Uttar Pradesh, India",
     India
     )
     
     */
    
    
    
    
    //To stop updating location
    [locManager stopUpdatingLocation];
}


@end
