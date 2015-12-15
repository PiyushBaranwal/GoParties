//
//  HomeViewController.m
//  GoParties
//
//  Created by GoParties on 16/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "RegisterViewController.h"

#import "Singleton.h"
#import "Utils.h"
#import "SVGeocoder.h"
#import "WebViewController.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "JSONRepresentation.h"
#import "NSObject+SBJSON.h"
#import "SBJsonWriter.h"

#import "Defines.h"


static NSString * const kClientId =@"586870525561-pds5h05mgck2gegqkd4av7kgs6tk6b0c.apps.googleusercontent.com"; //@"YOUR_CLIENT_ID";




@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize slideshow,loginBtn,signUpBtn;



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    //to hide the back button on navigation bar
    //[self.navigationItem setHidesBackButton:YES animated:YES];

    
    // for google
    
    [GIDSignIn sharedInstance].clientID = kClientId;
    
    [GIDSignInButton class];
    [[GIDSignIn sharedInstance]signOut];
    
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = (id)self;
    signIn.uiDelegate = (id)self;
    
    [GIDSignIn sharedInstance].allowsSignInWithWebView = YES;
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userLoggedIn"])
    {
       logged=[[NSUserDefaults standardUserDefaults] boolForKey:@"userLoggedIn"];
        //direct lands on main page as user is alreday logged in
        if (logged==NO)
        {
            
            
            
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
        else
        {
            
            
            webURL=[[NSUserDefaults standardUserDefaults] valueForKey:@"webURL"];
            
            //webURL=[mainDataDict valueForKey:@"url"];
            NSLog(@"webURL=%@",webURL);
            //////////////////////////////////
            // move to the web view for now.
            WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
            objW.urlStr=webURL;
            //objW.fbId=userFBId;
            [self.navigationController pushViewController:objW animated:YES];
            //////////////////////////////////
 
            
            
//        logged=[[NSUserDefaults standardUserDefaults] objectForKey:@"userLoggedIn"];
//        MainViewController *objM=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//        objM.loggedIn=logged;
//        [self.navigationController pushViewController:objM animated:YES];
        }
    }
    else
    {
        //To change the navigation title bar color
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
        //    // To add the functionality of left menu bar button
        
        self.title = NSLocalizedString(@"Home", nil);
//        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        [UIColor whiteColor],NSForegroundColorAttributeName,
//                                        [UIColor whiteColor],NSBackgroundColorAttributeName,[UIFont fontWithName:@"Open Sans" size:20],NSFontAttributeName,nil];
//        self.navigationController.navigationBar.titleTextAttributes = textAttributes;
//        
//        SWRevealViewController *revealController = [self revealViewController];
//        // [revealController panGestureRecognizer];
//        [revealController tapGestureRecognizer];
//        
//        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Toggle_main.png"]
//                                                                             style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
//        
//        
//        // revealButtonItem.width=10;
//        // [self.navigationItem.leftBarButtonItem setWidth:10];
//        
//        
//        self.navigationItem.leftBarButtonItem = revealButtonItem;
//        //To set the left BarButton background color
//        self.navigationItem.leftBarButtonItem.tintColor = [ UIColor whiteColor];
//        
//        // to add right bar buttons
//        [self AddRightBarButtonItems];
    
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
        
        
        //[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)AddRightBarButtonItems
{
    //To add searchButton on the right navbar
    UIButton *Button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
    [Button1 setImage:[UIImage imageNamed:@"search-icon_main.png"] forState:UIControlStateNormal];
    [Button1 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchButton= [[UIBarButtonItem alloc]initWithCustomView:Button1];
    
    
    UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
    [Button setImage:[UIImage imageNamed:@"Notification_Bell_main.png"] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(bell) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bellButton= [[UIBarButtonItem alloc]initWithCustomView:Button];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:searchButton, bellButton, nil]];

}

-(void)search
{
    
}

-(void)bell
{
    
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
    
    RegisterViewController *objLog=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

- (IBAction)fbBtnClick:(id)sender {
    
    FBSDKLoginManager *login=[[FBSDKLoginManager alloc]init];
    [login logOut];   //ESSENTIAL LINE OF CODE
    
    [login logInWithReadPermissions:@[@"email",@"public_profile"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result25, NSError *error)
     {
         NSLog(@"result %@", result25);
         if (error)
         {
             // dispatch_async(dispatch_get_main_queue(), ^{
             
             NSLog(@"find error %@",error.localizedDescription);
             
             // });
         }
         else if (result25.isCancelled)
         {
             // dispatch_async(dispatch_get_main_queue(), ^{
             
             [Utils stopActivityIndicatorInView:self.view];
             
             NSLog(@"facebook login canceled");
             
             // });
         }
         else
         {
             if ([result25.grantedPermissions containsObject:@"email"])
             {
                 
                 FBSDKProfile *profile=[FBSDKProfile currentProfile];
                 
                 
                 if ([FBSDKAccessToken currentAccessToken])
                 {
                     NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
                     
                     facebookToken=[[FBSDKAccessToken currentAccessToken]tokenString];
                     
                     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                     [parameters setValue:@"id, name, email, picture, first_name, last_name, gender, verified, locale" forKey:@"fields"];
                     
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                      {
                          if (!error)
                          {
                              NSLog(@"Fetched user:%@", result);
                              
                              
                              
                              facebookId=[result valueForKey:@"email"];
                              userFacebookMailId=[result valueForKey:@"email"];
                              userFacebookId=[result valueForKey:@"id"];
                              userFacebookName=[result valueForKey:@"name"];
                              NSMutableDictionary *rootDict=[result objectForKey:@"picture"];
                              NSMutableDictionary *dataDict=[rootDict objectForKey:@"data"];
                              userFacebookPic=[dataDict objectForKey:@"url"];
                              
                              // to save the user data locally
                              [[NSUserDefaults standardUserDefaults] setObject:userFacebookMailId forKey:@"userFacebookMailId"];
                              [[NSUserDefaults standardUserDefaults] setObject:userFacebookId forKey:@"userFacebookId"];
                              [[NSUserDefaults standardUserDefaults] setObject:userFacebookName forKey:@"userFacebookName"];
                              [[NSUserDefaults standardUserDefaults] setObject:userFacebookPic forKey:@"userFacebookPic"];
                              
                              NSLog(@"Facebook User Email:%@", userFacebookMailId);
                              NSLog(@"Facebook User ID:%@", userFacebookId);
                              NSLog(@"Facebook User Name:%@", userFacebookName);
                              NSLog(@"Facebook User Pic Url:%@", userFacebookPic);
                              
                              [self CallingWebServiceForFacebook];
                              // NSLog(@"Facebook User Email:%@", facebookId);
                              
                              
                              // [self checkEmailFacebookId];
                          }
                      }];
                 }
                 NSLog(@"Result1233 %@",profile);
             }
         }
     }];

}

- (IBAction)gpBtnClick:(id)sender {
    
    [Utils startActivityIndicatorInView:self.view withMessage:@"Loading..."];
    [[GIDSignIn sharedInstance]signIn];
}

- (IBAction)continueAsGuestBtnClick:(id)sender {
    
//    logged=YES;
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
    
//    webURL=[mainDataDict valueForKey:@"url"];
//    //////////////////////////////////
//    // move to the web view for now.
//    WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
//    objW.urlStr=@"http://team:goparties@dev.goparties.com/m-new/index.php";
//    [self.navigationController pushViewController:objW animated:YES];
//    //////////////////////////////////

    
    MainViewController *objLog=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

-(void)CallingWebServiceForGoogle
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/socialmediaregistration?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&google_id=%@&email=%@&name=%@&profile_pic=%@&profile_type=",BaseURL,userGoogleId,userGoogleMailId,userGoogleName,userGooglePic];
        NSLog(@"%@", urlAsString);
        NSURL *url = [NSURL URLWithString:[urlAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn)
        {
            
            // webData=[NSMutableData data];
            webData=[[NSMutableData alloc]init];
            
        }
        
    }
    
    else
        
    {
        //To show error no internet connection
        [Singleton connectionErrorMsg];
        
    }
    
}


#pragma mark- Delegate methods og Google
//- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
//                   error:(NSError *)error
//{
//    if (error)
//    {
//
//    }
//    else
//    {
//
//    }
//}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if (error) {
        
        return;
    }
    if ([GIDSignIn sharedInstance].currentUser.authentication == nil ||! user)
    {
        
    }
    else
    {
        NSLog(@"nnnn %@ and %@, %@",[GIDSignIn sharedInstance].currentUser.profile.email,[GIDSignIn sharedInstance].currentUser.profile.name,[GIDSignIn sharedInstance].currentUser.authentication.accessToken
              );
        
        
        
       // googleId=[GIDSignIn sharedInstance].currentUser.profile.email;
        googleId=[GIDSignIn sharedInstance].currentUser.userID;
        userGoogleMailId=[GIDSignIn sharedInstance].currentUser.profile.email;
        googleToken=[GIDSignIn sharedInstance].currentUser.authentication.accessToken;
        userGoogleName=[GIDSignIn sharedInstance].currentUser.profile.name;
        
        
        [[NSUserDefaults standardUserDefaults] setObject:googleId forKey:@"userGoogleId"];
        [[NSUserDefaults standardUserDefaults] setObject:userGoogleMailId forKey:@"userGoogleMailId"];
        [[NSUserDefaults standardUserDefaults] setObject:userGoogleName forKey:@"userGoogleName"];
        
        
        [self CallingWebServiceForGoogle];
    }
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error
{
    //dismissHUD(self.navigationController.view);
}


-(void)CallingWebServiceForFacebook

{
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        // http://192.168.1.29/loyalty/service_center2/loyaltyprogramlisting
        
        // http://192.168.1.14/api.php/socialmediaregistration?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a?facebook_id=&email=&name=&profile_pic=&profile_type=
        
        
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/socialmediaregistration?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&facebook_id=%@&email=%@&name=%@&profile_pic=%@&profile_type=",BaseURL,userFacebookId,userFacebookMailId,userFacebookName,userFacebookPic];
        NSLog(@"%@", urlAsString);
        NSURL *url = [NSURL URLWithString:[urlAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn)
        {
            
            // webData=[NSMutableData data];
            webData=[[NSMutableData alloc]init];
            
        }
        
    }
    
    else
        
    {
        //To show error no internet connection
        [Singleton connectionErrorMsg];
        
    }
}


#pragma -Mark
#pragma -mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"String is=%@",returnString);
    if (webData != nil)
    {
        [webData appendData:data];
    }
    else
    {
        webData = [[NSMutableData alloc] initWithData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    json1 = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingMutableContainers  error:&error];
    
    NSLog(@"json1=%@",json1);
    
    NSMutableDictionary *rootDict=[NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingMutableContainers  error:&error];
    
    
    // parsing for facebook user detail
    mainDataDict=[rootDict objectForKey:@"data"];
    NSLog(@"mainDataDict=%@",mainDataDict);
    userDict=[mainDataDict objectForKey:@"user"];
    NSLog(@"userDict=%@",userDict);
    
    userAddress=[userDict valueForKey:@"address"];
    userCityId=[userDict valueForKey:@"city_id"];
    userContactEmail=[userDict valueForKey:@"contact_email"];
    userContactPerson=[userDict valueForKey:@"contact_person"];
    userContactPhone=[userDict valueForKey:@"contact_phone"];
    userCoverImg=[userDict valueForKey:@"cover"];
    userCreatedAt=[userDict valueForKey:@"created_at"];
    userDeleatedAt=[userDict valueForKey:@"deleted_at"];
    userEmail=[userDict valueForKey:@"email"];
    userFBId=[userDict valueForKey:@"facebook_id"];
    userFBPageId=[userDict valueForKey:@"facebook_page_id"];
    userFollowdataArray=[userDict valueForKey:@"followData"];
    userGPId=[userDict valueForKey:@"google_id"];
    userId=[userDict valueForKey:@"id"];
    userIsActive=[userDict valueForKey:@"is_active"];
    userLat1=[userDict valueForKey:@"latitude"];
    userLong1=[userDict valueForKey:@"longitude"];
    userPartyData=[userDict valueForKey:@"myPartyData"];
    name=[userDict valueForKey:@"name"];
    userOTP=[userDict valueForKey:@"otp"];
    userPassword=[userDict valueForKey:@"password"];
    userPhone=[userDict valueForKey:@"phone"];
    userProfilePic=[userDict valueForKey:@"profile_pic"];
    userProfileType=[userDict valueForKey:@"profile_type"];
    userRating=[userDict valueForKey:@"rating"];
    userReportCount=[userDict valueForKey:@"report_count"];
    userName=[userDict valueForKey:@"username"];
    userValidEmail=[userDict valueForKey:@"valid_email"];
    userValidPhone=[userDict valueForKey:@"valid_phone"];
    userWebSite=[userDict valueForKey:@"website"];
    
    // to save the data in locallly in the app.
    [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
    [[NSUserDefaults standardUserDefaults] setObject:userCityId forKey:@"userCityId"];
    [[NSUserDefaults standardUserDefaults] setObject:userContactEmail forKey:@"userContactEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:userContactPerson forKey:@"userContactPerson"];
    [[NSUserDefaults standardUserDefaults] setObject:userContactPhone forKey:@"userContactPhone"];
    [[NSUserDefaults standardUserDefaults] setObject:userCoverImg forKey:@"userCoverImg"];
    [[NSUserDefaults standardUserDefaults] setObject:userCreatedAt forKey:@"userCreatedAt"];
    [[NSUserDefaults standardUserDefaults] setObject:userDeleatedAt forKey:@"userDeleatedAt"];
    [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:@"userEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:userFBId forKey:@"userFBId"];
    [[NSUserDefaults standardUserDefaults] setObject:userFBPageId forKey:@"userFBPageId"];
    // for array
    [[NSUserDefaults standardUserDefaults] setObject:userFollowdataArray forKey:@"userFollowdataArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:userGPId forKey:@"userGPId"];
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:userIsActive] forKey:@"userIsActive"];
    [[NSUserDefaults standardUserDefaults] setObject:userLat1 forKey:@"userLat1"];
    [[NSUserDefaults standardUserDefaults] setObject:userLong1 forKey:@"userLong1"];
    // for array
    [[NSUserDefaults standardUserDefaults] setObject:userPartyData forKey:@"userPartyData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:userOTP forKey:@"userOTP"];
    [[NSUserDefaults standardUserDefaults] setObject:userPassword forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] setObject:userProfilePic forKey:@"userProfilePic"];
    [[NSUserDefaults standardUserDefaults] setObject:userProfileType forKey:@"userProfileType"];
    [[NSUserDefaults standardUserDefaults] setObject:userRating forKey:@"userRating"];
    [[NSUserDefaults standardUserDefaults] setObject:userReportCount forKey:@"userReportCount"];
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:userValidEmail forKey:@"userValidEmail"];
    [[NSUserDefaults standardUserDefaults] setObject:userValidPhone forKey:@"userValidPhone"];
    [[NSUserDefaults standardUserDefaults] setObject:userWebSite forKey:@"userWebSite"];

    if (userFacebookId)
    {
                logged=YES;
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
        
        
        webURL=[mainDataDict valueForKey:@"url"];
        NSLog(@"webURL=%@",webURL);
        //////////////////////////////////
        // move to the web view for now.
        WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        objW.urlStr=webURL;
        objW.fbId=userFBId;
        [self.navigationController pushViewController:objW animated:YES];
        //////////////////////////////////

        
//        MainViewController *objM=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//        objM.loggedIn=logged;
//        [self.navigationController pushViewController:objM animated:YES];
        
        [Utils stopActivityIndicatorInView:self.view];
        
    }
    else
    {
                logged=YES;
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
        
        
        webURL=[mainDataDict valueForKey:@"url"];
        NSLog(@"webURL=%@",webURL);
        //////////////////////////////////
        // move to the web view for now.
        WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        objW.urlStr=webURL;
        objW.gpId=userGPId;
        [self.navigationController pushViewController:objW animated:YES];
        //////////////////////////////////
  
    }

    
}





@end
