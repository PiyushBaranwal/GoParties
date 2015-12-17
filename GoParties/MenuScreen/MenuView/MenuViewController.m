//
//  MenuViewController.m
//  LinkIn
//
//  Created by Piyush Baranwal on 23/09/14.
//  Copyright (c) 2014 BlueApple. All rights reserved.
//

#import "MenuViewController.h"

#import "SWRevealViewController.h"


#import "HomeViewController.h"
#import "SearchPartiesViewController.h"
#import "PartiesNearYouViewController.h"
#import "TrendingPartiesViewController.h"
#import "SpecialDealsViewController.h"
#import "PartiesCalendarViewController.h"
#import "CreatePartiesViewController.h"
#import "InviteFriendsViewController.h"
#import "NotificationViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "UserProfileViewController.h"






@interface MenuViewController ()
{

 NSInteger _presentedRow;
    
}

@end

@implementation MenuViewController

@synthesize menuTableView = _rearTableView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
////    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
////    if (self) {
////        // Custom initialization
////    }
////    return self;
//    
//    
//    if ([[UIScreen mainScreen] bounds].size.height == 568.0f)
//    {
//        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//        
//    }
//    else
//    {
//        //iphone 3.5 inch screen
//        NSString *_nibBundleOrNil = (NSString *)(nibBundleOrNil != nil ? [nibNameOrNil stringByAppendingString:@"_iPhone4s"] : [NSStringFromClass([self class]) stringByAppendingString:@"_iPhone4s"]);
//        self = [super initWithNibName:_nibBundleOrNil bundle:nibBundleOrNil];
//    }
//    
//    if (self)
//    {
//        // Custom initialization
//    }
//    return self;
//    
//}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
        return self;
    
    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        if ([[UIScreen mainScreen] bounds].size.height == 568.0f)
//        {
//            //iphone 4.0 inch screen
//            self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//        }
//        else
//        {
//            //iphone 3.5 inch screen
//            NSString *_nibBundleOrNil = (NSString *)(nibBundleOrNil != nil ? [nibNameOrNil stringByAppendingString:@"_iPhone4s"] : [NSStringFromClass([self class]) stringByAppendingString:@"_iPhone4s"]);
//            self = [super initWithNibName:_nibBundleOrNil bundle:nibBundleOrNil];
//        }
//    }
//    else
//    {
//        //For iPad
//        NSString *_nibBundleOrNil = (NSString *)(nibBundleOrNil != nil ? [nibNameOrNil stringByAppendingString:@"_iPad"] : [NSStringFromClass([self class]) stringByAppendingString:@"_iPad"]);
//        self = [super initWithNibName:_nibBundleOrNil bundle:nibBundleOrNil];
//        
//        //To check which ipad according to the size.
//        if ([[UIScreen mainScreen] bounds].size.height == 1024.0f)
//        {
//            //ipad 7.9 inch screen(mini ipad)
//            // self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//            NSString *_nibBundleOrNil = (NSString *)(nibBundleOrNil != nil ? [nibNameOrNil stringByAppendingString:@"_iPad"] : [NSStringFromClass([self class]) stringByAppendingString:@"_iPad"]);
//            self = [super initWithNibName:_nibBundleOrNil bundle:nibBundleOrNil];
//            
//        }
//        else
//        {
//            //ipad 9.7s inch screen
//            NSString *_nibBundleOrNil = (NSString *)(nibBundleOrNil != nil ? [nibNameOrNil stringByAppendingString:@"_iPad"] : [NSStringFromClass([self class]) stringByAppendingString:@"_iPad"]);
//            self = [super initWithNibName:_nibBundleOrNil bundle:nibBundleOrNil];
//        }
//        
//        
//    }
//    
//    if (self)
//    {
//        // Custom initialization
//    }
//    return self;
    
    
    
}





- (void)viewDidLoad
{
	[super viewDidLoad];
    
    //To disappear virual keyboard.
    [self.view endEditing:YES];
     self.navigationController.navigationBarHidden = YES;
    
    
    //To make circular userImage View.
    userImgView.layer.cornerRadius = userImgView.frame.size.width / 2;
   // userImgView.layer.borderWidth = 3.0f;
    userImgView.layer.borderColor=[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
    userImgView.clipsToBounds = YES;
   // userImgView.backgroundColor=[UIColor whiteColor];
    
    //For circular Profile ButtonImage.
    iconBtn.layer.cornerRadius = userImgView.frame.size.width / 2;
    //iconBtn.layer.borderWidth = 3.0f;
    iconBtn.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
    iconBtn.clipsToBounds = YES;
    
    
    // to set the name and card no of the user
//    nameLbl.text=@"";
//    cardLbl.text=@"";

   
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImgUrlStr]];
    
    //    // to change the imaged ata into string
    //    NSString *myString = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    if (imageData)
    {
       // userImgView.image = [UIImage imageWithData:imageData];
        userImgView.image = [UIImage imageWithData:imageData];
       // [iconBtn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        [iconBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        backImageView.clipsToBounds = YES;
        backImageView.image=[UIImage imageWithData:imageData];
        
    }
    else
    {
        
    }

    
    
    
      // We determine whether we have a grand parent SWRevealViewController, this means we are at least one level behind the hierarchy
    SWRevealViewController *parentRevealController = self.revealViewController;
    SWRevealViewController *grandParentRevealController = parentRevealController.revealViewController;
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:grandParentRevealController action:@selector(revealToggle:)];
    
    // if we have a reveal controller as a grand parent, this means we are are being added as a
    // child of a detail (child) reveal controller, so we add a gesture recognizer provided by our grand parent to our
    // navigation bar as well as a "reveal" button, we also set
    if ( grandParentRevealController )
    {
        // to present a title, we count the number of ancestor reveal controllers we have, this is of course
        // only a hack for demonstration purposes, on a real project you would have a model telling this.
        NSInteger level=0;
        UIViewController *controller = grandParentRevealController;
        while( nil != (controller = [controller revealViewController]) )
            level++;
        
        NSString *title = [NSString stringWithFormat:@"Detail Level %ld", level];
        
        [self.navigationController.navigationBar addGestureRecognizer:grandParentRevealController.panGestureRecognizer];
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        self.navigationItem.title = title;
    }
    
    // otherwise, we are in the top reveal controller, so we just add a title
    else
    {
        self.navigationItem.title = @"Menu";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SWRevealViewController *grandParentRevealController = self.revealViewController.revealViewController;
    grandParentRevealController.bounceBackOnOverdraw = YES;
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"SlideCustomCell";
    cell=(SlideCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor whiteColor];
    // to change the cell color on click.
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    //to change the textcolor on cell selection
    textLbl.highlightedTextColor = [UIColor colorWithRed:106.0f/255 green:27.0f/255 blue:154.0f/255 alpha:1.0];
    textLbl.font=[UIFont fontWithName:@"ClementePDag" size:14];//16


    if (indexPath.row==0)
    {
        
        //to change the logo image on cell selection
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_house.png"];
        textLbl.text = @"Home";
        logoImgView.image=[UIImage imageNamed:@"home_house.png"];
        indeImgView.hidden=YES;

    }
    if (indexPath.row==1)
    {
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_search_parties.png"];
        textLbl.text = @"Search Parties";
        logoImgView.image=[UIImage imageNamed:@"home_search_parties.png"];
        indeImgView.hidden=YES;

    }
    if (indexPath.row==2)
    {
    logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_parties_near_you.png"];
        textLbl.text = @"Parties Near You";
         logoImgView.image=[UIImage imageNamed:@"home_parties_near_you.png"];
        indeImgView.hidden=YES;
    }
    
    if (indexPath.row==3)
    {
    logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_trending_parties.png"];
       textLbl.text = @"Trending Parties";
        logoImgView.image=[UIImage imageNamed:@"home_trending_parties.png"];
        indeImgView.hidden=YES;
    }
    
    if (indexPath.row==4)
    {
       
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_special_deals.png"];
         textLbl.text = @"Special Deals";
        logoImgView.image=[UIImage imageNamed:@"home_special_deals.png"];
        indeImgView.hidden=YES;
    }
    if (indexPath.row==5)
    {
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_calendar.png"];
        textLbl.text = @"Parties Master Calendar";
         logoImgView.image=[UIImage imageNamed:@"home_calendar.png"];
        indeImgView.hidden=YES;

    }
    if (indexPath.row==6)
    {
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_create_parties.png"];
       textLbl.text = @"Create Parties";
         logoImgView.image=[UIImage imageNamed:@"home_create_parties.png"];
        indeImgView.hidden=YES;
    }
    if (indexPath.row==7)
    {
    logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_invite_friend.png"];
        textLbl.text = @"Invite Freinds to GoParties";
         logoImgView.image=[UIImage imageNamed:@"home_invite_friend.png"];
        indeImgView.hidden=YES;
    }
    if (indexPath.row==8)
    {
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_notification_frequency.png"];
        textLbl.text = @"Notification frequency";
        logoImgView.image=[UIImage imageNamed:@"home_notification_frequency.png"];
        indeImgView.hidden=YES;
    }
    
    
    if (indexPath.row==9)
    {
        
    logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_setting.png"];
       textLbl.text = @"Settings";
        logoImgView.image=[UIImage imageNamed:@"home_setting.png"];
        indeImgView.hidden=YES;

    }
    
    if (indexPath.row==10)
    {
       
        
        logoImgView.highlightedImage=[UIImage imageNamed:@"actve_home_logout.png"];
         textLbl.text = @"Logout";
        logoImgView.image=[UIImage imageNamed:@"home_logout.png"];
        indeImgView.hidden=YES;

        
    }
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
        // otherwise we'll create a new frontViewController and push it with animation
    UIViewController *newFrontController = nil;
    
    if (row==0)
    {
        HomeViewController *frontViewController = [[HomeViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        
    }
    else if(indexPath.row==1)
    {
//        BAAddProgramViewController *frontViewController = [[BAAddProgramViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        
        
        SearchPartiesViewController *frontViewController = [[SearchPartiesViewController alloc] init];
        frontViewController.clickedBtnTagValue=indexPath.row-1;
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];


    }
    else if(indexPath.row==2)
    {
//        PartiesNearYouViewController *frontViewController = [[PartiesNearYouViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        
        SearchPartiesViewController *frontViewController = [[SearchPartiesViewController alloc] init];
        frontViewController.clickedBtnTagValue=indexPath.row-1;
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    else if (indexPath.row==3)

    {
//        TrendingPartiesViewController *frontViewController = [[TrendingPartiesViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        
        SearchPartiesViewController *frontViewController = [[SearchPartiesViewController alloc] init];
        frontViewController.clickedBtnTagValue=indexPath.row-1;
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    else if (indexPath.row==4)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        SpecialDealsViewController *frontViewController = [[SpecialDealsViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    else if (indexPath.row==5)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        PartiesCalendarViewController *frontViewController = [[PartiesCalendarViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    else if (indexPath.row==6)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        CreatePartiesViewController *frontViewController = [[CreatePartiesViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    else if (indexPath.row==7)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        InviteFriendsViewController *frontViewController = [[InviteFriendsViewController alloc] init];
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    else if (indexPath.row==8)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
//        NotificationViewController *frontViewController = [[NotificationViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    else if (indexPath.row==9)
        
    {
        //        BAMyAccountViewController *frontViewController = [[BAMyAccountViewController alloc] init];
        //        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
//        SettingsViewController *frontViewController = [[SettingsViewController alloc] init];
//        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    

    else
    {
       // exit(0);
        
        LoginViewController *frontViewController = [[LoginViewController alloc] init];
        // to set the logged value as NO
        logged=0;
       // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userLoggedIn"];
        
       [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
        NSLog(@"logged value after logout=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userLoggedIn"]);
        newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    }
    
    [revealController pushFrontViewController:newFrontController animated:YES];
    
    _presentedRow = row;
    
}




//To add cell color when it is selected
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *selectedIndexPaths = [tableView indexPathsForSelectedRows];
//    NSLog(@"selectedIndexPaths=%@",selectedIndexPaths);
//    indexPathArray = [NSMutableArray array];
//    for (indexPath in selectedIndexPaths)
//    {
//        NSLog(@"indexPath=%@",indexPath);
//    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
//   // NSLog(@"indexPath.row in didhighlight=%ld",indexPath.row);
//    // Add your Colour.
//        SlideCustomCell *cell1 = (SlideCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//        [self setCellColor:[UIColor colorWithRed:106.0f/255.0f green:27.0f/255.0f blue:154.0f/255.0f alpha:1] ForCell:cell1];
//    //highlight colour
//   // [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//     NSLog(@"indexPath.row in didunhighlight=%ld",indexPath.row);
//    // Reset Colour.
//    SlideCustomCell *cell1 = (SlideCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [self setCellColor:[UIColor colorWithRed:106.0f/255.0f green:27.0f/255.0f blue:154.0f/255.0f alpha:1] ForCell:cell1];
//    //normal color
    
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell2
{
    cell2.contentView.backgroundColor = color;
    cell2.backgroundColor = color;
}





- (IBAction)iconBtnClick:(id)sender
{
     SWRevealViewController *revealController = self.revealViewController;
      UIViewController *newFrontController = nil;
    UserProfileViewController *frontViewController = [[UserProfileViewController alloc] init];
    newFrontController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    [revealController pushFrontViewController:newFrontController animated:YES];
}



@end
