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

@interface VerificationViewController ()

@end

@implementation VerificationViewController

@synthesize mailId;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    
    
    
    [self CallingWebServiceToverifyOTP];
    
}

- (IBAction)loginBtnClick:(id)sender {
    
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

- (IBAction)signupBtnClick:(id)sender {
    
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
        
        NSString *post = [NSString stringWithFormat:@"email=%@&verifOtp=%@&access_token=%@",mailId,verificationTextField.text,@"133688745fb3253a0b4c3cbb3f67d444cf4b418a" ];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://api.startup-designer.com/verifyOtp"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:postData];
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:requestHandler
                                                                        options:kNilOptions
                                                                          error:nil];
        NSLog(@"jsonDict:%@",jsonDict);
        
        
        
        mainDataDict=[jsonDict objectForKey:@"data"];
                if ([mainDataDict objectForKey:@"user"])
                {
                    logged=YES;
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:logged] forKey:@"userLoggedIn"];
                    
                    MainViewController *objM=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
                    objM.loggedIn=logged;
                    [self.navigationController pushViewController:objM animated:YES];

                }
        
        
        
    }
    else
    {
        //To show error no internet connection
        [Singleton connectionErrorMsg];
    }
    
}




@end
