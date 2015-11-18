//
//  HomeViewController.m
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize slideshow,loginBtn,signUpBtn;



- (void)viewDidLoad {
    
   // self.title = NSLocalizedString(@"Home", nil);
    [super viewDidLoad];
    
    
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
    self.title = NSLocalizedString(@"Home", nil);
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor blackColor],NSForegroundColorAttributeName,
                                    [UIColor blackColor],NSBackgroundColorAttributeName,[UIFont fontWithName:@"Open Sans" size:20],NSFontAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    SWRevealViewController *revealController = [self revealViewController];
    // [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    
    // revealButtonItem.width=10;
    // [self.navigationItem.leftBarButtonItem setWidth:10];
    
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    // to add right bar buttons
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(search)];
    self.navigationItem.rightBarButtonItem = searchButtonItem;
    
    
    //To set the left BarButton background color
    self.navigationItem.leftBarButtonItem.tintColor = [ UIColor blackColor];
    // Do any additional setup after loading the view from its nib.
    

//   self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:96.0 green:3.0 blue:125.0 alpha:1.0]];
    //self.loginBtn.backgroundColor=[UIColor colorWithRed:96.0 green:3.0 blue:125.0 alpha:1.0];
    
    
        // KASlideshow
        slideshow.delegate = self;
        [slideshow setDelay:1]; // Delay between transitions
        [slideshow setTransitionDuration:.5]; // Transition duration
        [slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
        [slideshow setImagesContentMode:UIViewContentModeScaleToFill]; // Choose a content mode for images to display
       // [slideshow addImagesFromURLs:banImgArray];
        [slideshow addImagesFromResources:@[@"welcome_logo.png",@"welcome_logo.png",@"welcome_logo.png"]]; // Add images from resources
        [slideshow addGesture:KASlideShowGestureAll];
         [slideshow start]; // Gesture to go previous/next directly on the image
       // [Utils stopActivityIndicatorInView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)loginBtnClick:(id)sender {
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
    
}

- (IBAction)signUpBtnClick:(id)sender {
}

- (IBAction)fbBtnClick:(id)sender {
}

- (IBAction)gpBtnClick:(id)sender {
}

- (IBAction)continueAsGuestBtnClick:(id)sender {
}
@end
