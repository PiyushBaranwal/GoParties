//
//  LoginViewController.m
//  GoParties
//
//  Created by GoParties on 18/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)loginBtnClick:(id)sender {
    
    MainViewController *objLog=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    [self.navigationController pushViewController:objLog animated:YES];
}

- (IBAction)fbBtnClick:(id)sender {
}

- (IBAction)gpBtnClick:(id)sender {
}

- (IBAction)feelForgetBtnClick:(id)sender {
}

- (IBAction)regBtnClick:(id)sender {
}
@end
