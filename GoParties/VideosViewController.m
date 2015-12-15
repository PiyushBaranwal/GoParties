//
//  VideosViewController.m
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "VideosViewController.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"

@interface VideosViewController ()

@end

@implementation VideosViewController
@synthesize videoTableView;

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


#pragma -mark
#pragma mark TableView delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int rem=thumbImgArray.count % 2;
//    
//    if (rem==1)
//    {
//        return (thumbImgArray.count/3)*100+180;//1500
//    }
//    else
//    {
//        return (thumbImgArray.count/3)*100+160;//1500
//    }
    return 50; //(thumbImgArray.count/2)*100+160;//1500
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        cell1 = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier];
    }
    
    return cell1;
}




- (IBAction)homeBtnClick:(id)sender
{
    
}
- (IBAction)myProfileBtnClick:(id)sender
{
    
}
- (IBAction)myPartiesBtnClick:(id)sender
{
    
}
- (IBAction)myDealsBtnClick:(id)sender
{
    
}
- (IBAction)accessBtnClick:(id)sender
{
    
}





@end
