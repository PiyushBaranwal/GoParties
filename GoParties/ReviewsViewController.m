//
//  ReviewsViewController.m
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "ReviewsViewController.h"

#import "Defines.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"




@interface ReviewsViewController ()

@end

@implementation ReviewsViewController

@synthesize reviewsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //[self callingWebServiceForReviewsList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    reviewsArray=[[NSMutableArray alloc]init];
    reviewsCreatedAtArray=[[NSMutableArray alloc]init];
    revDateArray=[[NSMutableArray alloc]init];
    revByNameArray=[[NSMutableArray alloc]init];
    revByRatingArray=[[NSMutableArray alloc]init];
    revByReviewArray=[[NSMutableArray alloc]init];
    revByProfilePicArray=[[NSMutableArray alloc]init];
    revByProfileTypeArray=[[NSMutableArray alloc]init];
    
    // hitting API
     [self callingWebServiceForReviewsList];
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
    //    if (titleArray.count==0)
    //    {
    //        return 200;
    //    }
    //    else
    //    {
    //        return 200*(titleArray.count+1);
    //    }
    
    
    return 350*5;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
// to set the row background color
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor lightGrayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    // [cell1 setBackgroundColor:[UIColor lightGrayColor]];
    //    [cell1 setBackgroundColor:[UIColor lightGrayColor]];
    //    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.row==0)
    {
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.contentView.backgroundColor=[UIColor colorWithRed:220.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1.0];
        
        
        // for first back view ---------------------------------------------------
        UIView *fBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, 160)];
        fBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:fBackView];
        
        //for total reviewsvalue Label;
        UILabel *revvalue=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 200, 30)];
        revvalue.text=@"223";
        revvalue.backgroundColor=[UIColor clearColor];
        [fBackView addSubview:revvalue];
        
        // for totalreviews label
        UILabel *reviewsLbl=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 290, 30)];
        reviewsLbl.text=@"Reviews";
        reviewsLbl.textColor=[UIColor grayColor];
        [fBackView addSubview:reviewsLbl];
        
        //for rating label
        UILabel *ratingBackLbl=[[UILabel alloc]initWithFrame:CGRectMake(305, 10, 50, 30)];//250, 10, 50, 30
        ratingBackLbl.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];
        ratingBackLbl.layer.masksToBounds = YES;
        ratingBackLbl.layer.cornerRadius = 8.0;
        ratingBackLbl.clipsToBounds = YES;
        [fBackView addSubview:ratingBackLbl];
        
        //for rating value laebl
        UILabel *rateValueLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 30, 20)];
        rateValueLbl.text=@"4.2";
        rateValueLbl.font=[UIFont systemFontOfSize:15];
        rateValueLbl.textColor=[UIColor whiteColor];
        [ratingBackLbl addSubview:rateValueLbl];
        
        // for star image
        UIImageView *starImg=[[UIImageView alloc]initWithFrame:CGRectMake(30, 7, 15, 15)];
        starImg.image=[UIImage imageNamed:@"star_white.png"];
        starImg.backgroundColor=[UIColor clearColor];
        [ratingBackLbl addSubview:starImg];
        
        
        
        //for saperator line
        UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width-10, 1)];
        sepLbl.backgroundColor=[UIColor lightGrayColor];
        [fBackView addSubview:sepLbl];
        
        
        
        // for type label
        UILabel *yourRevLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, self.view.frame.size.width-30, 30)];
        yourRevLbl.text=@"YOUR REVIEW";
        yourRevLbl.font=[UIFont systemFontOfSize:14];
        [fBackView addSubview:yourRevLbl];
        
        // for rating stars
        NSInteger a=0;
        for (int i=0; i<5; i++)
        {
            UIButton *strBtn=[[UIButton alloc]initWithFrame:CGRectMake(285+a, 60, 15, 15)];//230+a, 60, 15, 15
            strBtn.backgroundColor=[UIColor lightGrayColor];
            [strBtn setImage:[UIImage imageNamed:@"star_white.png"] forState:UIControlStateNormal];
            strBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            strBtn.tag=i;
            [strBtn addTarget:self action:@selector(strBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [fBackView addSubview:strBtn];
            a=a+15;
        }
        
        //for userIconImg
        UIImageView *userIconImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 90, 50, 50)];
        userIconImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
        [fBackView addSubview:userIconImg];
        
        //for user comment text view
        UITextView *usercommTextView=[[UITextView alloc]initWithFrame:CGRectMake(60, 90, 250, 50)];
        usercommTextView.text=@"Tell people what you think (Max. 100 words)";
        //also sets the background image of this textView
        [fBackView addSubview:usercommTextView];
        
        
        
        
        // for feeded back view
        UIView *revHeaderBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 175, self.view.frame.size.width-10, 40)];
        revHeaderBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:revHeaderBackView];
        
        //for reviews header
        UILabel *revHeaderLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 250, 30)];
        revHeaderLbl.text=@"REVIEWS (MOST TO HELPFUL)";
        revHeaderLbl.font=[UIFont systemFontOfSize:14];
        [revHeaderBackView addSubview:revHeaderLbl];
        
        NSInteger b=0;
        for (int j=0; j<5; j++)
        {
            
            // for feeded back view
            UIView *feededBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 200+b, self.view.frame.size.width-10, 250)];
            feededBackView.backgroundColor=[UIColor whiteColor];
            [cell1.contentView addSubview:feededBackView];
            //for userIconImg
            UIImageView *feededIconImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 35, 50, 50)];
            feededIconImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
            [feededBackView addSubview:feededIconImg];
            
            //for feeded name label
            UILabel *feededLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 90, 30)];
            feededLbl.text=@"Capitol Club";
            feededLbl.font=[UIFont systemFontOfSize:14];
            [feededBackView addSubview:feededLbl];
            
            //for feeded rating star
            // for rating stars
            NSInteger c=0;
            for (int j=0; j<5; j++)
            {
                UIImageView *feededStrImg=[[UIImageView alloc]initWithFrame:CGRectMake(285+c, 35, 15, 15)];//230+c, 35, 15, 15
                feededStrImg.backgroundColor=[UIColor clearColor];
                feededStrImg.image=[UIImage imageNamed:@"star_orange.png"];
                //strBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                feededStrImg.tag=j;
                [feededBackView addSubview: feededStrImg];

                c=c+15;
            }
            
           
            
           
            
            // for feeded reviews label
            UILabel *feededRevLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 50, 50, 30)];
            feededRevLbl.text=@"Reviews";
            feededRevLbl.font=[UIFont systemFontOfSize:12];
            feededRevLbl.textColor=[UIColor grayColor];
            [feededBackView addSubview:feededRevLbl];
            
            // for feeded review values
            UILabel *feededRvValues=[[UILabel alloc]initWithFrame:CGRectMake(110 , 50, 50, 30)];
            feededRvValues.text=@"23";
            feededRvValues.font=[UIFont systemFontOfSize:12];
            feededRvValues.textColor=[UIColor grayColor];
            [feededBackView addSubview:feededRvValues];
            
            
            // for feeded folowers label
            UILabel *followLbl=[[UILabel alloc]initWithFrame:CGRectMake(140, 50, 70, 30)];
            followLbl.text=@"Followers";
            followLbl.font=[UIFont systemFontOfSize:12];
            followLbl.textColor=[UIColor grayColor];
            [feededBackView addSubview:followLbl];
            
            
            // for feeded followers value
            UILabel *followValueLbl=[[UILabel alloc]initWithFrame:CGRectMake(200, 50, 50, 30)];
            followValueLbl.text=@"152";
            followValueLbl.font=[UIFont systemFontOfSize:12];
            followValueLbl.textColor=[UIColor grayColor];
            [feededBackView addSubview:followValueLbl];
            
            
            //for timeIcon
            UIImageView *tmIcon=[[UIImageView alloc]initWithFrame:CGRectMake(60, 78, 15, 15)];
            tmIcon.image=[UIImage imageNamed:@"clock_main.png"];
            tmIcon.backgroundColor=[UIColor grayColor];
            [feededBackView addSubview:tmIcon];
            
            // for date label
            UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(85, 70, 70, 30)];
            dateLbl.text=@"August 15";
            dateLbl.font=[UIFont systemFontOfSize:12];
            dateLbl.textColor=[UIColor grayColor];
            [feededBackView addSubview:dateLbl];
            
            
            // for comments textView
            UITextView *commTextView=[[UITextView alloc]initWithFrame:CGRectMake(60, 100, 305, 150)];//60, 100, 250, 150
            commTextView.text=@"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.";
            [feededBackView addSubview:commTextView];
            
            //for saperator line
                   UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width-10, 1)];
                   sepLbl.backgroundColor=[UIColor lightGrayColor];
                   [feededBackView addSubview:sepLbl];

            
            b=b+251;
            
        }
        
        
        /////////--------------------------------------------------
        
        //        // for second back view ---------------------------------------------------
        //        UIView *sBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 110, 310, 100)];
        //        sBackView.backgroundColor=[UIColor whiteColor];
        //        [cell1.contentView addSubview:sBackView];
        //
        //        // for name label
        //        UILabel *mobileLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 290, 30)];
        //        mobileLbl.text=@"Mobile:";
        //        mobileLbl.textColor=[UIColor grayColor];
        //        [sBackView addSubview:mobileLbl];
        //        //for nameTextField;
        //        UITextField *mobileTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        //        mobileTextField.backgroundColor=[UIColor lightGrayColor];
        //        [sBackView addSubview:mobileTextField];
        //
        //        //for saperator line
        //        UILabel *sepLbl2=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 310, 1)];
        //        sepLbl2.backgroundColor=[UIColor lightGrayColor];
        //        [sBackView addSubview:sepLbl2];
        //
        //
        //
        //        // for type label
        //        UILabel *addLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 290, 30)];
        //        addLbl.text=@"Address:";
        //        addLbl.textColor=[UIColor grayColor];
        //        [sBackView addSubview:addLbl];
        //        //for nameTextField;
        //        UITextField *addTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 60, 200, 30)];
        //        addTextField.backgroundColor=[UIColor lightGrayColor];
        //        [sBackView addSubview:addTextField];
        //        /////////--------------------------------------------------
        
    }
    
    
    
    // }
    return cell1;
    
    
}

-(IBAction)strBtnClick:(id)sender
{
    NSLog(@"strBtnClick");
}



-(void)callingWebServiceForReviewsList
{
    //get userid userlat and userlong here from local database
    /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        //offer=YES;
        NSString *urlAsString;
        
        urlAsString=[NSString stringWithFormat:@"%@/getuserreviews?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&from=0&to=13",BaseURL];
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
    reviewsArray=[mainDataDict objectForKey:@"reviews"];
    revByRatingArray=[reviewsArray valueForKey:@"rating"];
    revByReviewArray=[reviewsArray valueForKey:@"review"];
    reviewsCreatedAtArray=[reviewsArray valueForKey:@"created_at"];
    reviewByDict=[reviewsArray valueForKey:@"reviewed_by"];
    revByNameArray=[reviewByDict valueForKey:@"name"];
    revByProfilePicArray=[reviewByDict valueForKey:@"profile_pic"];
    revByProfileTypeArray=[reviewByDict valueForKey:@"profile_type"];
    
    NSLog(@"reviewsArray=%@",reviewsArray);
    NSLog(@"revByRatingArray=%@",revByRatingArray);
    NSLog(@"revByReviewArray=%@",revByReviewArray);
    NSLog(@"reviewsCreatedAtArray=%@",reviewsCreatedAtArray);
    //NSLog(@"reviewByDict=%@",reviewByDict);
    NSLog(@"revByNameArray=%@",revByNameArray);
    NSLog(@"revByProfilePicArray=%@",revByProfilePicArray);
    NSLog(@"revByProfileTypeArray=%@",revByProfileTypeArray);
    
    [self timeStampToDate];
    //[reviewsTableView reloadData];
    
    // to save the data in locallly in the app.
    // [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
    
    
}

-(void)timeStampToDate
{
    // to convert the time stamp into date
    for (int j=0; j<reviewsCreatedAtArray.count; j++)
    {
        NSTimeInterval _interval=[[reviewsCreatedAtArray objectAtIndex:j] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"dd.MM.yyyy"];
        NSString *_date=[_formatter stringFromDate:date];
        [revDateArray addObject:_date];
        
    }
    NSLog(@"revDateArray=%@",revDateArray);
}


@end
