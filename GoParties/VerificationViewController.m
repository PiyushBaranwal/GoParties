//
//  VerificationViewController.m
//  GoParties
//
//  Created by GoParties on 20/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "VerificationViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "MainViewController.h"

#import "Singleton.h"
#import "Defines.h"

#import "WebViewController.h"

@interface VerificationViewController ()

@end

@implementation VerificationViewController

@synthesize mailId;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
    // self.title = NSLocalizedString(@"Login", nil);
    //To set the left BarButton background color
    self.navigationItem.leftBarButtonItem.tintColor = [ UIColor whiteColor];
    //to hide the back button on navigation bar
   // [self.navigationItem setHidesBackButton:YES animated:YES];
    
    verificationTextField.delegate=self;
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)submitBtnClick:(id)sender {
    
    if (verificationTextField.text && verificationTextField.text.length>0)
    {
      [self CallingWebServiceToverifyOTP];
    }
    else
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Title"
                                      message:@"Please enter received OTP"
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

- (IBAction)loginBtnClick:(id)sender {
    
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

- (IBAction)signupBtnClick:(id)sender {
    
    RegisterViewController *objLog=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

- (IBAction)resendOTPBtnClick:(id)sender {
    
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
        
        
        NSString *post = [NSString stringWithFormat:@"email=%@&verifOtp=%@&access_token=%@",mailId,verificationTextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
        
       // NSString *post = [NSString stringWithFormat:@"email=%@&access_token=%@",usertextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
        
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
            objV.mailId=mailId;
            [self.navigationController pushViewController:objV animated:YES];
            
        }
        else
        {
            
        }
        
//        logged=YES;
//        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
//        
//        mainDataDict=[jsonDict objectForKey:@"data"];
//        webURL=[mainDataDict valueForKey:@"url"];
//        NSLog(@"webURL=%@",webURL);
//        //////////////////////////////////
//        // move to the web view for now.
//        WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
//        objW.urlStr=webURL;
//        [self.navigationController pushViewController:objW animated:YES];
//        //////////////////////////////////

        
    }

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
    
    
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame; frame.origin.y = -150;
        [self.view setFrame:frame];
        [UIView commitAnimations];

    
}



-(void)CallingWebServiceToverifyOTP
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        
        if (verificationTextField.text && verificationTextField.text.length>0)
        {
            NSString *post = [NSString stringWithFormat:@"email=%@&verifOtp=%@&access_token=%@",mailId,verificationTextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            //
            NSString *urlAsString;
            urlAsString=[NSString stringWithFormat:@"%@/verifyOtp",BaseURL];
            //[request setURL:[NSURL URLWithString:@"http://192.168.1.9/api.php/verifyOtp"]];
            [request setURL:[NSURL URLWithString:urlAsString]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:postData];
            NSURLResponse *requestResponse;
            NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
            
            NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                                            options:kNilOptions
                                                                              error:nil];
            NSLog(@"jsonDict:%@",jsonDict);
            
            NSMutableDictionary *rootDict=[jsonDict objectForKey:@"error"];
            mainDataDict=[jsonDict objectForKey:@"data"];
           userDict=[mainDataDict objectForKey:@"user"];
            
            
            mainDataDict=[jsonDict objectForKey:@"data"];
            webURL=[mainDataDict valueForKey:@"url"];
            NSLog(@"userDict=%@",userDict);
            if (rootDict)
            {
                //code=;
                if ([[[jsonDict objectForKey:@"error"] valueForKey:@"code"] integerValue] == 109)
                {
                    NSLog(@"Error code 109");
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
            }
            
            else
            {
                
                logged=YES;
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
                
                [[NSUserDefaults standardUserDefaults] setObject:webURL forKey:@"webURL"];
                
                
                 NSLog(@"webURL=%@",webURL);
                //////////////////////////////////
                // move to the web view for now.
                WebViewController *objW=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
                objW.urlStr=webURL;
                [self.navigationController pushViewController:objW animated:YES];
                //////////////////////////////////
                
                
//                if (userDict)
//                {
//                    logged=YES;
//                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
//                    
//                    MainViewController *objM=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//                    objM.loggedIn=logged;
//                    [self.navigationController pushViewController:objM animated:YES];
//                    
//                }
                
            }
 
        }
       else
       {
           UIAlertController * alert=   [UIAlertController
                                         alertControllerWithTitle:@"Title"
                                         message:@"Please enter verification code"
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
        //To show error no internet connection
        [Singleton connectionErrorMsg];
    }
    
}




@end
