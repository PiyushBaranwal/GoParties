//
//  RegisterViewController.m
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "RegisterViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "Singleton.h"


#import "VerificationViewController.h"
#import "WebViewController.h"


#import "Utils.h"
#import "SVGeocoder.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "JSONRepresentation.h"
#import "NSObject+SBJSON.h"
#import "SBJsonWriter.h"
#import "Defines.h"



static NSString * const kClientId =@"586870525561-pds5h05mgck2gegqkd4av7kgs6tk6b0c.apps.googleusercontent.com"; //@"YOUR_CLIENT_ID";


@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
   // self.title = NSLocalizedString(@"Login", nil);
    //To set the left BarButton background color
    self.navigationItem.leftBarButtonItem.tintColor = [ UIColor whiteColor];
    //to hide the back button on navigation bar
    //[self.navigationItem setHidesBackButton:YES animated:YES];

    
    usertextField.delegate=self;
    passTextField.delegate=self;
    mobileTextFiled.delegate=self;
    typeTextField.delegate=self;
    
    
    typeArray=[[NSMutableArray alloc]initWithObjects:@"individual",@"party place",@"concert",@"dj", @"artist",@"band",nil];
    
    //to set teh background image
    typeBtn.backgroundColor=[UIColor clearColor];
    [typeBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    // Do any additional setup after loading the view from its nib.
    
    
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


//To remove virtual keyboard from screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.view endEditing:YES];
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame;
        frame.origin.y =0;
        [self.view setFrame:frame];
        [UIView commitAnimations];
        
        return NO;
    }
    
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==usertextField || textField==passTextField)
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
    else if(textField==mobileTextFiled || textField==typeTextField)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame; frame.origin.y = -150;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    else
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
}


- (IBAction)typeBtnClick:(id)sender {
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(66.0f, 315.0f, 230.0f, 150.0f)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];

}

- (IBAction)regBtnClick:(id)sender {
   
    
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:mobileTextFiled.text];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    if(((usertextField.text && usertextField.text.length>0)&&(passTextField.text && passTextField.text.length>0))&&(mobileTextFiled.text && mobileTextFiled.text.length>0)&&(typeTextField.text && typeTextField.text.length>0))
    {
        if (stringIsValid)
        {
            [self CallingWebServiceForRegister];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Title"
                                          message:@"Please enter correct mobile no"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           // to navigate on the verification view
                                           
                                       }];
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
 
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Title"
                                      message:@"Please fill all the provided fields"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       //Handel your yes please button action here
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                       // to navigate on the verification view
                                       
                                   }];
        
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
   
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


- (IBAction)gpBtnClick:(id)sender {
    
    [Utils startActivityIndicatorInView:self.view withMessage:@"Loading..."];
    [[GIDSignIn sharedInstance]signIn];

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
        
        
        
        //googleId=[GIDSignIn sharedInstance].currentUser.profile.email;
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


- (IBAction)contAsGuestBtnClick:(id)sender {
    
    webURL=[mainDataDict valueForKey:@"url"];
    //////////////////////////////////
    // move to the web view for now.
    WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    objW.urlStr=@"http://team:goparties@dev.goparties.com/m-new/index.php";
    [self.navigationController pushViewController:objW animated:YES];
    //////////////////////////////////

    
//    MainViewController *objMain=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//    [self.navigationController pushViewController:objMain animated:YES];
}

//- (IBAction)haveAccBtnClick:(id)sender {
//}

- (IBAction)loginBtnClick:(id)sender {
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}


#pragma -mark
#pragma  mark Picker view DelegateMethods
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
   
        return typeArray.count;
   
    //    return adultArray.count;
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
            return typeArray[row];
   
    //    return adultArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
            //to set the text
        [typeTextField setText:[NSString stringWithFormat:@"  %@",[typeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        typeTextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    
    pickerView.hidden=YES;
    
    //    [salutationTextField setText:[NSString stringWithFormat:@"%@",[countryArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    //    salutationPickerView.hidden=YES;
}





-(void)CallingWebServiceForRegister
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
       
        //To get the userLat long from local database    ///  LinkInUSerCurLat
        NSUserDefaults *userDef=  [NSUserDefaults standardUserDefaults];
        double userLat=[[userDef objectForKey:@"UserCurLat"] doubleValue];
        double userLong=[[userDef objectForKey:@"UserCurLong"] doubleValue];
        NSLog(@"userLat=%f",userLat);
        NSLog(@"userLong=%f",userLong);
        
        
        NSString *post = [NSString stringWithFormat:@"email=%@&phone=%@&profile_type=%@&password=%@&latitude=%f&longitude=%f&access_token=%@",usertextField.text,mobileTextFiled.text,typeTextField.text,passTextField.text,userLat,userLong,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //[request setURL:[NSURL URLWithString:@"http://192.168.1.9/api.php/register"]];
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/register",BaseURL];
        NSLog(@"urlAsString=%@",urlAsString);
        [request setURL:[NSURL URLWithString:urlAsString]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        
        
       // NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        
        
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                                        options:kNilOptions
                                                                          error:nil];
        NSLog(@"jsonDict:%@",jsonDict);
        
        if ([[[jsonDict objectForKey:@"error"] valueForKey:@"code"] integerValue] == 107)
        {
            //Your account is not verified
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Title"
                                          message:[[jsonDict objectForKey:@"error"] valueForKey:@"message"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           // to navigate on the verification view
                                           
                                       }];
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
        else if ([[[jsonDict objectForKey:@"error"] valueForKey:@"code"] integerValue] == 109)
        {
            // Invalid OTP
            //Your account is not verified
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Title"
                                          message:[[jsonDict objectForKey:@"error"] valueForKey:@"message"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           // to navigate on the verification view
                                           
                                       }];
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];

        }

        else
        {
            VerificationViewController *objV=[[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];
            objV.mailId=usertextField.text;
            [self.navigationController pushViewController:objV animated:YES];
        
           // [self CallingWebServiceForResendOTP];
        }

        
        
    }
    else
    {
        //To show error no internet connection
        [Singleton connectionErrorMsg];
    }
    
}




-(void)CallingWebServiceForResendOTP
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        
        //To get the userLat long from local database    ///  LinkInUSerCurLat
        NSUserDefaults *userDef=  [NSUserDefaults standardUserDefaults];
        double userLat=[[userDef objectForKey:@"UserCurLat"] doubleValue];
        double userLong=[[userDef objectForKey:@"UserCurLong"] doubleValue];
        NSLog(@"userLat=%f",userLat);
        NSLog(@"userLong=%f",userLong);
        
        
        NSString *post = [NSString stringWithFormat:@"email=%@&access_token=%@",usertextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        //
        //[request setURL:[NSURL URLWithString:@"http://192.168.1.9/api.php/resendOtp"]];
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/resendOtp",BaseURL];
        [request setURL:[NSURL URLWithString:urlAsString]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        
        
        // NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        
        
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                                        options:kNilOptions
                                                                          error:nil];
        NSLog(@"jsonDict:%@",jsonDict);
        
        NSString *responseStr=[[jsonDict objectForKey:@"data"] valueForKey:@"message"];
        if ([responseStr isEqualToString:@"OTP sent"])
        {
            VerificationViewController *objV=[[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];
            objV.mailId=usertextField.text;
            [self.navigationController pushViewController:objV animated:YES];
            
        }
        
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
        
        [[NSUserDefaults standardUserDefaults] setObject:webURL forKey:@"webURL"];
        
        webURL=[mainDataDict valueForKey:@"url"];
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
        [[NSUserDefaults standardUserDefaults] setObject:webURL forKey:@"webURL"];
        
        webURL=[mainDataDict valueForKey:@"url"];
        //////////////////////////////////
        // move to the web view for now.
        WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        objW.urlStr=webURL;
         objW.gpId=userGPId;
        [self.navigationController pushViewController:objW animated:YES];
        //////////////////////////////////
        
        
//        MainViewController *objM=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//        objM.loggedIn=logged;
//        [self.navigationController pushViewController:objM animated:YES];
        
        [Utils stopActivityIndicatorInView:self.view];
        
    }
    
    
}




@end
