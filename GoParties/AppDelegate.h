//
//  AppDelegate.h
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SVGeocoder.h"
#import "MainViewController.h"
#import "WebViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate,CLLocationManagerDelegate>
{
     HomeViewController *objHome;
    MainViewController *objMain;
    WebViewController *objWeb;
    
    CLLocationManager *locManager;
    float curLat;
    float curLong;
    
    BOOL logged;

}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain)  UINavigationController *navigationController;
@property (strong,nonatomic) HomeViewController *objHome;
@property (strong,nonatomic)  MainViewController *objMain;
@property (strong,nonatomic)WebViewController *objWeb;


@property (strong, nonatomic) SWRevealViewController *viewController;


@end

