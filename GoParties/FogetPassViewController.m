//
//  FogetPassViewController.m
//  GoParties
//
//  Created by GoParties on 20/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "FogetPassViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResetViewController.h"
#import "Singleton.h"
#import "Defines.h"


@interface FogetPassViewController ()

@end

@implementation FogetPassViewController

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

    
    userTextField.delegate=self;
    mobileTextField.delegate=self;
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
    
    if ((userTextField.text && userTextField.text.length>0)||(mobileTextField.text && mobileTextField.text.length>0))
    {
        NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:mobileTextField.text];
        BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
        if (stringIsValid)
        {
         [self CallingWebServiceforforgot];
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Title"
                                          message:@"Please enetr the correct mobile no."
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
                                      message:@"Please fill all the field"
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
    
//    if ((userTextField.text && userTextField.text.length>0) ||(mobileTextField.text && mobileTextField.text.length>0))
//    {
    
   // }
//    else
//    {
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:@"Title"
//                                      message:@"Please fill any one of the provided fields"
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* okButton = [UIAlertAction
//                                   actionWithTitle:@"OK"
//                                   style:UIAlertActionStyleDefault
//                                   handler:^(UIAlertAction * action)
//                                   {
//                                       //Handel your yes please button action here
//                                       [alert dismissViewControllerAnimated:YES completion:nil];
//                                       // to navigate on the verification view
//                                       
//                                   }];
//        
//        [alert addAction:okButton];
//        [self presentViewController:alert animated:YES completion:nil];
// 
//    }
//    
    
   
}

- (IBAction)loginBtnClick:(id)sender {
    
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
    
}

- (IBAction)signUpBtnClick:(id)sender {
    RegisterViewController *objLog=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
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
    
    if (textField==userTextField || textField==mobileTextField)
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
    else if(textField==userTextField || textField==mobileTextField)
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


-(void)CallingWebServiceforforgot
{
    
    
   
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
       NSString *locUserNameStr= [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        NSLog(@"locUserNameStr=%@",locUserNameStr);
        if([locUserNameStr isKindOfClass:[NSString class]])
        {
         
        }
        else
        {
          locUserNameStr=@"";
        }
            NSString *post = [NSString stringWithFormat:@"email=%@&username=%@&phone=%@&access_token=%@",userTextField.text,locUserNameStr,mobileTextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            //http://192.168.1.9/api.php
            NSString *urlAsString;
            urlAsString=[NSString stringWithFormat:@"%@/forgot",BaseURL];
            
            //[request setURL:[NSURL URLWithString:@"http://192.168.1.9/api.php/forgot"]];
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
       
        NSMutableDictionary *locDict=[jsonDict valueForKey:@"message"];
        if (locDict)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Title"
                                          message:[locDict valueForKey:@"message"]
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
            //NAVIGATE TO THE RESET VIEW.
            ResetViewController *objR=[[ResetViewController alloc]initWithNibName:@"ResetViewController" bundle:nil];
            
            if (mobileTextField.text  && mobileTextField.text.length > 0)
            {
                objR.mobStr=mobileTextField.text;
            }
            else
            {
                objR.mailStr=userTextField.text;
            }
            
            [self.navigationController pushViewController:objR animated:YES];
  
        }
            
//            NSString *responseStr=[[jsonDict objectForKey:@"data"] valueForKey:@"code"];
//            
//            // check how to comapare a string containing a string
//            if ([responseStr isEqualToString:@"Password reset code:aNtUpgvwskVQMw=="])
//            {
//                
//            }
        
            
        
    }
    else
    {
        //To show error no internet connection
        [Singleton connectionErrorMsg];
    }
    
}


@end
