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

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usertextField.delegate=self;
    passTextField.delegate=self;
    mobileTextFiled.delegate=self;
    typeTextField.delegate=self;
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
}

- (IBAction)regBtnClick:(id)sender {
}

- (IBAction)fbBtnClick:(id)sender {
}

- (IBAction)gpBtnClick:(id)sender {
}

- (IBAction)contAsGuestBtnClick:(id)sender {
    
    MainViewController *objMain=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:objMain animated:YES];
}

//- (IBAction)haveAccBtnClick:(id)sender {
//}

- (IBAction)loginBtnClick:(id)sender {
    LoginViewController *objLog=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}
@end
