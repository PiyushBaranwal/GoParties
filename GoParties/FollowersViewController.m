//
//  FollowersViewController.m
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "FollowersViewController.h"

#import "Defines.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"

@interface FollowersViewController ()

@end

@implementation FollowersViewController
@synthesize followersTableView,cell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To initialize the array
    followersArray=[[NSMutableArray alloc]init];
    followerNameArray=[[NSMutableArray alloc]init];
    followerPicArray=[[NSMutableArray alloc]init];
    followerTypeArray=[[NSMutableArray alloc]init];
    
//    [self callingWebServiceForFollowers];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self callingWebServiceForFollowers];
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
    return followerNameArray.count;
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
    
    static NSString *cellIdentifier=@"FollowersTableViewCell";
    cell=(FollowersTableViewCell *)[followersTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    // to set the name type and pic
    nameLabel.text=[followerNameArray objectAtIndex:indexPath.row];
    placeLbl.text=[followerTypeArray objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)callingWebServiceForFollowers
{
    //get userid userlat and userlong here from local database
    /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        //offer=YES;
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/getfollowdata?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&from=0&to=10&flag=0",BaseURL];
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
    followersArray=[mainDataDict  objectForKey:@"followers"];
    followerNameArray=[followersArray valueForKey:@"name"];
    followerPicArray=[followersArray valueForKey:@"profile_pic"];
    followerTypeArray=[followersArray valueForKey:@"profile_type"];
    NSLog(@"followersArray=%@",followersArray);
    NSLog(@"followerNameArray=%@",followerNameArray);
    NSLog(@"followerPicArray=%@",followerPicArray);
    NSLog(@"followerTypeArray=%@",followerTypeArray);
    
    [followersTableView reloadData];
    
    // to save the data in locallly in the app.
    // [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
    
    
}


@end
