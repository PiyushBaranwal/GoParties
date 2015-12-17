//
//  FollowingViewController.m
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "FollowingViewController.h"
#import "Defines.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"

@interface FollowingViewController ()

@end

@implementation FollowingViewController

@synthesize followingTableView,cell;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self callingWebServiceForFollowings];
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
    return followingNameArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier=@"FollowingTableViewCell";
    cell=(FollowingTableViewCell *)[followingTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    // to set the name type and pic here
    nameLabel.text=[followingNameArray objectAtIndex:indexPath.row];
    placeLbl.text=[followingTypeArray objectAtIndex:indexPath.row];
    //iconImg.image=

    return cell;
}


-(void)callingWebServiceForFollowings
{
    //get userid userlat and userlong here from local database
    /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        //offer=YES;
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/getfollowdata?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&from=0&to=10&flag=1",BaseURL];
        NSLog(@"%@", urlAsString);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlAsString]];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (conn)
        {
            // webData=[NSMutableData data];
            webData=[[NSMutableData alloc]init];
        }
    }
    else
    {
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
    followingsArray=[mainDataDict  objectForKey:@"following"];
    followingNameArray=[followingsArray valueForKey:@"name"];
    followingPicArray=[followingsArray valueForKey:@"profile_pic"];
    followingTypeArray=[followingsArray valueForKey:@"profile_type"];
    NSLog(@"followingsArray=%@",followingsArray);
    NSLog(@"followingNameArray=%@",followingNameArray);
    NSLog(@"followingPicArray=%@",followingPicArray);
    NSLog(@"followingTypeArray=%@",followingTypeArray);
    
    [followingTableView reloadData];
    
    // to save the data in locallly in the app.
    // [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
    
    
}


@end
