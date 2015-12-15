//
//  ResetViewController.m
//  GoParties
//
//  Created by GoParties on 10/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "ResetViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "Singleton.h"
#import "Utils.h"
#import "SVGeocoder.h"
#import "Defines.h"



@interface ResetViewController ()

@end

@implementation ResetViewController

@synthesize mailStr,mobStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    //to hide the back button on navigation bar
   // [self.navigationItem setHidesBackButton:YES animated:YES];

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
    if ((verifyTextField.text && verifyTextField.text.length>0) &&(newpasswordTextField.text && newpasswordTextField.text.length>0))
    {
        //[Utils startActivityIndicatorInView:self.view withMessage:@"Loading"];
        
        [self CallingWebServiceForResetPassword];
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

- (IBAction)loginBtnClick:(id)sender {
    LoginViewController *objL=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objL animated:YES];
}

- (IBAction)signUpBtnClick:(id)sender {
    RegisterViewController *objR=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:objR animated:YES];
}


-(void)CallingWebServiceForResetPassword
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
      if((verifyTextField.text && verifyTextField.text.length>0)&&(newpasswordTextField.text && newpasswordTextField.text.length>0))
      {
          NSString *post = [NSString stringWithFormat:@"code=%@&newPassword=%@&access_token=%@",verifyTextField.text,newpasswordTextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
          
          NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
          NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
          NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
          //http://192.168.1.9/api.php
          NSString *urlAsString;
          urlAsString=[NSString stringWithFormat:@"%@/reset",BaseURL];
          //[request setURL:[NSURL URLWithString:@"http://192.168.1.9/api.php/reset"]];
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
          if(jsonDict)
          {
          mainDataDict=[jsonDict objectForKey:@"data"];
          UIAlertController * alert=   [UIAlertController
                                        alertControllerWithTitle:@"Title"
                                        message:[mainDataDict valueForKey:@"message"]
                                        preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction* okButton = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Handel your yes please button action here
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                         //NAVIGATE TO THE login view
                                         LoginViewController *objL=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                                         [self.navigationController pushViewController:objL animated:YES];

                                         
                                     }];
          
          [alert addAction:okButton];
          [self presentViewController:alert animated:YES completion:nil];
          
          
//          //NAVIGATE TO THE RESET VIEW.
//          LoginViewController *objL=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//          [self.navigationController pushViewController:objL animated:YES];
          }
          else
          {
              NSLog(@"JSONDict Is null");
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
    
    
    
        LoginViewController *objL=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:objL animated:YES];
        
        [Utils stopActivityIndicatorInView:self.view];
        
    
    
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
    
    if (textField==verifyTextField || textField==newpasswordTextField)
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
    else if(textField==verifyTextField || textField==newpasswordTextField)
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


@end
