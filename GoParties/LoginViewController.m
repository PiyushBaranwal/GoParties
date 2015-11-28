//
//  LoginViewController.m
//  GoParties
//
//  Created by GoParties on 18/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "RegisterViewController.h"
#import "FogetPassViewController.h"

#import "Singleton.h"
//#import "Utils.h"
#import "SVGeocoder.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
    self.title = NSLocalizedString(@"Login", nil);
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,[UIFont fontWithName:@"Open Sans" size:20],NSFontAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    SWRevealViewController *revealController = [self revealViewController];
    // [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Toggle_main.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    
    // revealButtonItem.width=10;
    // [self.navigationItem.leftBarButtonItem setWidth:10];
    
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    //To set the left BarButton background color
    self.navigationItem.leftBarButtonItem.tintColor = [ UIColor whiteColor];
    
    
    // to set the delegates of textfields
    nameTextField.delegate=self;
    passTextField.delegate=self;
    // Do any additional setup after loading the view from its nib.
    
    //to get the current lat and long
//    self.locManager = [[CLLocationManager alloc] init];
//    self.locManager.delegate = self;
//    self.locManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;//kCLLocationAccuracyHundredMeters; // 100 m
//    //To start updating location.
//    [self.locManager startUpdatingLocation];
    
//    if ([self.locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [self.locManager requestWhenInUseAuthorization];
//    }
//    [self.locManager startUpdatingLocation];
    
    
    
//    locManager = [[CLLocationManager alloc] init];
//    locManager.delegate=self;
//    locManager.desiredAccuracy=kCLLocationAccuracyBest;
//    locManager.distanceFilter=kCLDistanceFilterNone;
//   // [locManager requestWhenInUseAuthorization];
//   // [locManager startMonitoringSignificantLocationChanges];
//    [locManager startUpdatingLocation];
    
    
    
    
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
    
//    MainViewController *objLog=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//    [self.navigationController pushViewController:objLog animated:YES];
    
    if(nameTextField.text.length==0)
    {
        NSLog(@"Please fill the fields");
    }
    else
    {
    
    [self CallingWebServiceForLogin];
    }
}

- (IBAction)fbBtnClick:(id)sender {
}

- (IBAction)gpBtnClick:(id)sender {
}

- (IBAction)feelForgetBtnClick:(id)sender {
    FogetPassViewController *objReg=[[FogetPassViewController alloc]initWithNibName:@"FogetPassViewController" bundle:nil];
    [self.navigationController pushViewController:objReg animated:YES];
}

//- (IBAction)regBtnClick:(id)sender {
//    
//    RegisterViewController *objReg=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
//    [self.navigationController pushViewController:objReg animated:YES];
//}

- (IBAction)signupBtnClick:(id)sender
{
    RegisterViewController *objReg=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:objReg animated:YES];
}



//To remove virtual keyboard from screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    
    if (textField==nameTextField || textField==passTextField)
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
    else if(textField==nameTextField || textField==passTextField)
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




//Webservice for LoyaltyProgram Listing
-(void)CallingWebServiceForLogin
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
        
        
        NSString *post = [NSString stringWithFormat:@"username=%@&phone=%@&email=%@&password=%@&latitude=%f&longitude=%f",@"GP",@"1234567891",nameTextField.text,passTextField.text,userLat,userLong ];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://api.startup-designer.com/login"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        
        NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);

        if ([requestReply isEqualToString:@"[\"Success\"]"])
        {
//            [Utils showAlertView:nil message:@"Thank you for taking the time to fill out this form, we will get in touch with you shortly." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok"];
//            
//            
//            submitBtn.enabled=YES;
//            salutationTextField.text=@"";
//            fNameTextField.text=@"";
//            lNameTextField.text=@"";
//            cityTextField.text=@"";
//            countryNameTextField.text=@"";
//            emailNameTextField.text=@"";
//            mobNameTextField.text=@"";
//            [queryNameTextView setText:@""];
//            
//            
//            salutationTextField.text=@"Select";
//            countryNameTextField.text=@"Select";
            
            
            
            
        }
        
        else
            
        {
//            [Utils showAlertView:nil message:@"Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok"];
        }

        
        
        
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
//        if (conn)
//        {
//            // webData=[NSMutableData data];
//            webData=[[NSMutableData alloc]init];
//        }
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
    
    
    
    
    //    ba.name=[json1 valueForKey:@"name"];
    //    ba.logo=[json1 valueForKey:@"logo"];
    //    NSLog(@"ba.name=%@",ba.name);
    //    NSLog(@" ba.logo=%@", ba.logo);
    
//    nidArray=[json1 valueForKey:@"Nid"];
//    nameArray=[json1 valueForKey:@"name"];
//    logoArray=[json1 valueForKey:@"logo"];
//    colorArray=[json1 valueForKey:@"color"];
//    categoryArray=[json1 valueForKey:@"category"];
//    backImgArray=[json1 valueForKey:@"Background image"];
//    categoryIdArray=[json1 valueForKey:@"category id"];
//    
//    
//    
//    
//    rooDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:[json1 valueForKey:@"Nid"],@"Nid",[json1 valueForKey:@"name"],@"name",[json1 valueForKey:@"logo"],@"logo",[json1 valueForKey:@"color"],@"color",[json1 valueForKey:@"category"],@"category",[json1 valueForKey:@"Background image"],@"Background image",[json1 valueForKey:@"category id"],@"category id" ,nil];
//    
//    
//    NSLog(@"rooDict=%@",rooDict);
//    
//    
//    
//    
//    
//    
//    // to get unique object from teh array
//    //    NSSet *catIdSet=[NSSet setWithArray:categoryIdArray];
//    //    NSArray *locCatIdArray=[catIdSet allObjects];
//    
//    //To get the unique object from array
//    categorySet = [NSSet setWithArray:categoryArray];
//    NSLog(@"categorySet=%@",categorySet);
//    
//    
//    
//    NSArray *locCatarray=[categorySet allObjects];
//    NSLog(@"locCatarray=%@",locCatarray);
//    
//    
//    
//    
//    
//    
//    
//    //    //To create category dictionary.
//    //    NSMutableDictionary *catDict=[NSMutableDictionary dictionaryWithObjects:locCatarray forKeys:locCatIdArray];
//    //    NSLog(@"catDict=%@",catDict);
//    
//    
//    //    //To create dictionary
//    //    nameCatDict = [NSMutableDictionary dictionaryWithObjects:nameArray forKeys:categoryArray];
//    //    NSLog(@"nameCatDict=%@", nameCatDict);
//    
//    // to save the below type data
//    // 2 holds a,b,c
//    //3 holds d,e,f
//    // NSDictionary *mapping = @{@"2": @[@"a", @"b", @"c"]};
//    //    NSDictionary *locDict=@{nidArray:@[nameArray,logoArray,backImgArray]};
//    //    NSLog(@"locDict=%@",locDict);
//    
//    //    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//    //                          @"logo", logoArray, @"name", nameArray, nil];
//    //    NSLog(@"dict=%@",dict);
//    
//    nameLogoDict=[NSMutableDictionary dictionaryWithObjects:nameArray forKeys:logoArray];
//    NSLog(@"nameLogoDict=%@",nameLogoDict);
//    
//    
//    
//    
//    NSLog(@"nidArray=%@",nidArray);
//    NSLog(@"nameArray=%@",nameArray);
//    NSLog(@"logoArray=%@",logoArray);
//    NSLog(@"colorArray=%@",colorArray);
//    NSLog(@"categoryArray=%@",categoryArray);
//    NSLog(@"backImgArray=%@",backImgArray);
//    NSLog(@"categoryIdArray=%@",categoryIdArray);
//    
//    //    NSMutableDictionary *finalDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:nameArray,logoArray,colorArray,categoryArray,categoryIdArray,backImgArray, nil];
//    //
//    //    NSLog(@"finalDict=%@",finalDict);
//    
//    
//    
//    
//    //for descending order
//    NSSortDescriptor *sorter = [[NSSortDescriptor alloc]
//                                initWithKey:@"name"
//                                ascending:NO
//                                selector:@selector(localizedCaseInsensitiveCompare:)];
//    NSArray *sortDescriptors = [NSArray arrayWithObject: sorter];
//    [json1 sortUsingDescriptors:sortDescriptors];
//    NSLog(@"after sorting json1=%@",json1);
//    
//    
//    descNameArray=[json1 valueForKey:@"name"];
//    descLogoArray=[json1 valueForKey:@"logo"];
//    NSLog(@"descNameArray=%@",descNameArray);
//    NSLog(@"descLogoArray=%@",descLogoArray);
//    
//    
//    //    //To add the new program here
//    //    [nameArray addObject:[NSString stringWithFormat:@"%@",addedProgCardname]];
//    //     NSLog(@"After Adding new Program, nameArray=%@",nameArray);
//    
//    
//    [programTableView reloadData];
//    [Utils stopActivityIndicatorInView:self.view];
    
    
}


//#pragma mark- delegate method of CLLOcationManager
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}
//
//
//
//
//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    curLat=newLocation.coordinate.latitude;
//    curLong=newLocation.coordinate.longitude;
//    
//    
//    NSLog(@"curLatStr=%f and curLongStr=%f",curLat,curLong);
//    
//    
//    //to save the curlat and long in localdatabase
//    //To save profile image in the app locally.
////    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.4f", curLat] forKey:@"LinkInUSerCurLat"];
////    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%.4f", curLong] forKey:@"LinkInUSerCurLongt"];
//    
//    
//    
//    
//    //To get the Location Name from Lat And Long
//    
//    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(curLat, curLong)
//                    completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
//                        // NSLog(@"placemarks = %@", placemarks);
//                        NSMutableArray *subAdministrativeArea=[placemarks valueForKey:@"formattedAddress"];
//                        
//                        // NSLog(@"formattedAddress=%@",subAdministrativeArea);
//                        NSString *locationStr=[subAdministrativeArea objectAtIndex:6];
//                         NSLog(@"locStr=%@",locationStr);
//                        //To save teh current loction in local database
//                       // [[NSUserDefaults standardUserDefaults] setObject:locationStr forKey:@"LinkdeInUserLocationName"];
//                        
//                        
//                    }];
//    
//    /*
//     formattedAddress=(
//     "E-66, E Block, Sector 6, Noida, Uttar Pradesh 110096, India",
//     "E Block, Sector 6, Noida, Uttar Pradesh 110096, India",
//     "Sector 6, Noida, Uttar Pradesh, India",
//     "110096, India",
//     "Noida, Uttar Pradesh, India",
//     "Gautam Buddh Nagar, Uttar Pradesh, India",
//     "Uttar Pradesh, India",
//     India
//     )
//     
//     */
//    
//    
//    
//    
//    //To stop updating location
//    [locManager stopUpdatingLocation];
//}





@end
