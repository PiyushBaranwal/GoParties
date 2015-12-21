//
//  MyPartiesViewController.m
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "MyPartiesViewController.h"
#import "PartyDetailViewController.h"
#import "UserProfileViewController.h"

#import "Defines.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"

@interface MyPartiesViewController ()

@end

@implementation MyPartiesViewController

@synthesize myPartiesTableView,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    partyBookmarkArray=[[NSMutableArray alloc]init];
    partyTitleArray=[[NSMutableArray alloc]init];
    partyDescArray=[[NSMutableArray alloc]init];
    partybannerArray=[[NSMutableArray alloc]init];
    partyAddArray=[[NSMutableArray alloc]init];
    
    partyDDayArray=[[NSMutableArray alloc]init];
    partyDateArray=[[NSMutableArray alloc]init];
    
    partyConPhoneArray=[[NSMutableArray alloc]init];
    partyConEmailArray=[[NSMutableArray alloc]init];
    partyConPersonArray=[[NSMutableArray alloc]init];
    
    
    createdNameArray=[[NSMutableArray alloc]init];
    cretaedProfilePicArray=[[NSMutableArray alloc]init];
    createdProfileTypeArray=[[NSMutableArray alloc]init];
    createdRatingArray=[[NSMutableArray alloc]init];
    
    partiesArray=[[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self callingWebServiceForGetMyParties];

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
        
        
        // To set the segmented control.
        segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"My Parties",@"Saved Parties"]];
        // [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        segmentControl.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
        [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange1:) forControlEvents:UIControlEventValueChanged];
        
        [segmentControl setSelectedSegmentIndex:0];
        [[segmentControl.subviews objectAtIndex:0] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        
        [[segmentControl.subviews objectAtIndex:1] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        
        [[segmentControl.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
        
        [cell1.contentView addSubview:segmentControl];
        
        
        
        NSInteger a=0;
        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
        {
            
            //To create the card view.
            UIView *cardView=[[UIView alloc]initWithFrame:CGRectMake(5, 50+a, self.view.frame.size.width-10, 250)];
            cardView.userInteractionEnabled=YES;
            if(i%2==0)
            {
                cardView.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];// 255,153,0
            }
            else
            {
                cardView.backgroundColor=[UIColor colorWithRed:106.0f/255 green:27.0f/255 blue:154.0f/255 alpha:1.0];// 106,27,154
            }
            
            
            //To make the top left and right corner rounded
            UIBezierPath *maskPath;
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cardView.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                   cornerRadii:CGSizeMake(8.0, 8.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.view.bounds;
            maskLayer.path = maskPath.CGPath;
            cardView.layer.mask = maskLayer;
            [cell1.contentView addSubview:cardView];
            
            
            // to set the banner backgroung image
            bannerImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-10, 140)];
            bannerImg.image=[UIImage imageNamed:@"First1.png"];
            bannerImg.alpha=0.90;
            [cardView addSubview:bannerImg];
            
            
            
            // to set the viewlayer on the banner
            UIView *layerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 140)];
            layerView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.70];
            [bannerImg addSubview:layerView];
            
            
            
            //for bannerClickBtn
            UIButton *bannerClickBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, 140)];//
            bannerClickBtn.backgroundColor=[UIColor clearColor];
            // [bannerClickBtn setImage:[UIImage imageNamed:@"bookmark_main.png"] forState:UIControlStateNormal];
            // bannerClickBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            bannerClickBtn.tag=i;
            [bannerClickBtn addTarget:self action:@selector(bannerBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:bannerClickBtn];
            
            
            
            //For type
            [self baseScrollView ];
            
            
            
            //for the bookMarkButton
            UIButton *bookMarkBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 10, 30, 25)];//
            bookMarkBtn.backgroundColor=[UIColor clearColor];
            [bookMarkBtn setImage:[UIImage imageNamed:@"bookmark_main.png"] forState:UIControlStateNormal];
            bookMarkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            bookMarkBtn.tag=i;
            [bookMarkBtn addTarget:self action:@selector(bookMarkBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:bookMarkBtn];
            
            
            //For friendInvite btn
            UIButton *frndInvbtn=[[UIButton alloc]initWithFrame:CGRectMake(300, 10, 30, 25)];//245, 10, 30, 25
            frndInvbtn.backgroundColor=[UIColor clearColor];
            [frndInvbtn setImage:[UIImage imageNamed:@"add_user_main.png"] forState:UIControlStateNormal];
            frndInvbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            frndInvbtn.tag=i;
            [frndInvbtn addTarget:self action:@selector(frndInviteBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:frndInvbtn];
            
            //For Share btn
            UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(330, 10, 30, 25)];//275, 10, 30, 25
            shareBtn.backgroundColor=[UIColor clearColor];
            [shareBtn setImage:[UIImage imageNamed:@"share_main.png"] forState:UIControlStateNormal];
            shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            shareBtn.tag=i;
            [shareBtn addTarget:self action:@selector(shareBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:shareBtn];
            
            
            //For the Free Entry
            UILabel *partyTitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(128, 5, 150, 30)];//100, 5, 150, 30
            partyTitleLbl.backgroundColor=[UIColor clearColor];
            partyTitleLbl.text=@"LADIES NIGHT";
            partyTitleLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:partyTitleLbl];
            
            
            
            //For date Icon
            UIImageView *dateImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 128, 15, 15)];
            dateImg.image=[UIImage imageNamed:@"calendar_main.png"];
            dateImg.backgroundColor=[UIColor clearColor];
            [cardView addSubview:dateImg];
            
            //For DateLabel
            UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 120, 150, 30)];
            dateLbl.backgroundColor=[UIColor clearColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            dateLbl.font=[dateLbl.font fontWithSize:12];
            dateLbl.text=@"25th Sep 2015";
            dateLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:dateLbl];
            
            //for Separator
            UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(115, 128, 2, 15)];//115, 128, 2, 15
            sepLbl.backgroundColor=[UIColor whiteColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            [cardView addSubview:sepLbl];
            
            //For time Icon
            UIImageView *timeImg=[[UIImageView alloc]initWithFrame:CGRectMake(125, 128, 15, 15)];
            timeImg.image=[UIImage imageNamed:@"clock_main.png"];
            timeImg.backgroundColor=[UIColor clearColor];
            [cardView addSubview:timeImg];
            
            
            
            //for outer circle
            UIView *circularView = [[UIView alloc] initWithFrame:CGRectMake(295,110,60,60)];//240,110,60,60
            circularView.layer.cornerRadius = 30;// half of the height or width of the view
            circularView.layer.borderWidth = 3.0f;
            circularView.layer.borderColor = [UIColor whiteColor].CGColor;
            [cardView addSubview:circularView];
            
            
            
            CAShapeLayer *circle=[CAShapeLayer layer];
            // here set the starting point as zero and ending point as the no of days//30,30
            circle.path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(324,140) radius:29 startAngle:2*M_PI*0-M_PI_2 endAngle:2*M_PI*1-M_PI_2*100/30 clockwise:YES].CGPath;
            circle.fillColor=[UIColor clearColor].CGColor;
            circle.strokeColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0].CGColor;
            circle.lineWidth=3;//4
            
            //            // to set the animation
            //            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            //            animation.duration=10;
            //            animation.removedOnCompletion=NO;
            //            animation.fromValue=@(0);
            //            animation.toValue=@(1);
            //            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //            [circle addAnimation:animation forKey:@"drawCircleAnimation"];
            
            // [circularView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            [cardView.layer addSublayer:circle];
            
            
            
            // for inner circle
            UIView *innercircularView = [[UIView alloc] initWithFrame:CGRectMake(3,3,54,54)];
            //circularView.alpha = 0.5;
            innercircularView.backgroundColor=[UIColor clearColor];
            innercircularView.layer.cornerRadius = 27;
            [circularView addSubview:innercircularView];
            
            // for no of days
            UILabel *noLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 40, 30)];
            noLbl.backgroundColor=[UIColor clearColor];
            noLbl.text=@"30";
            noLbl.textColor=[UIColor whiteColor];
            //noLbl.font=[UIFont fontWithName:@"Sans" size:12.0];
            [innercircularView addSubview:noLbl];
            
            // for days
            UILabel *dayLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 30)];
            dayLbl.backgroundColor=[UIColor clearColor];
            dayLbl.text=@"Days";
            dayLbl.textColor=[UIColor whiteColor];
            //noLbl.font=[UIFont fontWithName:@"Sans" size:12.0];
            [innercircularView addSubview:dayLbl];
            
            
            
            
            
            //for Time Label
            UILabel *timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(140, 120, 150, 30)];
            timeLbl.backgroundColor=[UIColor clearColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            timeLbl.font=[dateLbl.font fontWithSize:12];
            timeLbl.text=@" 7 PM Onwards";
            timeLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:timeLbl];
            
            
            
            //For location icon
            UIImageView *locImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 148, 15, 15)];
            locImg.image=[UIImage imageNamed:@"location_pin_main.png"];
            locImg.backgroundColor=[UIColor clearColor];
            [cardView addSubview:locImg];
            
            
            //For location Name Label
            UILabel *locationLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 140, 280, 30)];
            locationLbl.backgroundColor=[UIColor clearColor];
            locationLbl.font=[locationLbl.font fontWithSize:12];
            locationLbl.text=@"Karol Bagh, New Delhi";
            locationLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:locationLbl];
            
            //For ProfileImg
            UIImageView *profileImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 50, 50)];
            //profileImg.image=[UIImage imageNamed:@"First1.png"];
            profileImg.layer.cornerRadius = 5;
            profileImg.layer.masksToBounds = YES;
            profileImg.backgroundColor=[UIColor whiteColor];
            [bannerImg addSubview:profileImg];
            
            //for profile title label
            UILabel *profileLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 180, 300, 30)];
            profileLbl.backgroundColor=[UIColor clearColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            profileLbl.font=[profileLbl.font fontWithSize:15];
            profileLbl.text=@"The Underdoggs";
            profileLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:profileLbl];
            
            
            //for place label
            UILabel *placeLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 200, 100, 30)];
            placeLbl.backgroundColor=[UIColor clearColor];
            placeLbl.font=[placeLbl.font fontWithSize:15];
            placeLbl.text=@"Party Place";
            placeLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:placeLbl];
            
            
            
            
            // for rating
            NSInteger b=0;
            for (int j=0; j<5; j++)
            {
                UIImageView *strImg1=[[UIImageView alloc]initWithFrame:CGRectMake(70+b, 225 , 15, 15)];
                strImg1.image=[UIImage imageNamed:@"star_white.png"];
                [cardView addSubview:strImg1];
                b=b+15;
            }
           
            
            
            // for Party Profile btn
            UIButton *profileBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 180, 225, 70)];
            profileBtn.backgroundColor=[UIColor clearColor];
            //[profileBtn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
            profileBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            profileBtn.tag=i;
            [profileBtn addTarget:self action:@selector(profileBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:profileBtn];
            

            
            // for saperator
            UIImageView *saperatorImg=[[UIImageView alloc]initWithFrame:CGRectMake(275, 180 , 5, 70)];//230, 180 , 5, 70
            saperatorImg.image=[UIImage imageNamed:@"Seprator.png"];
            [cardView addSubview:saperatorImg];
            
            
            
            
            
            
            //for Add DealBtn
            UIButton *followBtn=[[UIButton alloc]initWithFrame:CGRectMake(315, 190, 30, 30)];//10,175,280,20//260, 190, 30, 30
            followBtn.backgroundColor=[UIColor clearColor];
            [followBtn setImage:[UIImage imageNamed:@"FOLLOW_main.png"] forState:UIControlStateNormal];
            followBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            followBtn.tag=i;
            [followBtn addTarget:self action:@selector(addDealBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:followBtn];
            
            //for FOLLOW Label
            UILabel *followLbl=[[UILabel alloc]initWithFrame:CGRectMake(295, 220, 70, 30)];//240, 220, 70, 30
            followLbl.backgroundColor=[UIColor clearColor];
            followLbl.font=[placeLbl.font fontWithSize:15];
            followLbl.text=@"FOLLOW";
            followLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:followLbl];
            
            
            a=a+260;
        }
        
    }
    
    
    
    // }
    return cell1;
    
    
}

-(IBAction)bannerBtnClick:(id)sender
{
    NSLog(@"bannerBtnClick");
    PartyDetailViewController *objPB=[[PartyDetailViewController alloc]initWithNibName:@"PartyDetailViewController" bundle:nil];
   // [self presentViewController:objPB animated:YES completion:nil];
    
//    UINavigationController *navigationController =
//    [[UINavigationController alloc] initWithRootViewController:objPB];
//    //now present this navigation controller modally
//    [self presentViewController:navigationController
//                       animated:YES
//                     completion:^{
//                         
//                     }];
    
    [ self.navigationController pushViewController:objPB animated:YES];
}


-(IBAction)profileBtnClick:(id)sender
{
    
    NSLog(@"profileBtnClick");
    ProfileViewController *objP=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:objP animated:YES];
}

-(IBAction)followBtnClick:(id)sender
{
    NSLog(@"Follow Btn Clicked");
}

-(IBAction)addDealBtnClick:(id)sender
{
    NSLog(@"Add Deal Btn Clicked");
}

-(IBAction)bookMarkBtnClick:(id)sender
{
    NSLog(@"book mark Btn Clicked");
}

-(IBAction)frndInviteBtnClick:(id)sender
{
    NSLog(@"Frnd Invite Btn Clicked");
}

-(IBAction)shareBtnClick:(id)sender
{
    NSLog(@"Share Btn Clicked");
}





-(void)baseScrollView
{
    
    //int numOfCount=6;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0,10.0,self.view.frame.size.width,40.0)];//0.0,0.0,480.0,960.0
    //    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*(imgArray.count-2.5),self.scrollView.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*(4-2.5),self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor=[UIColor clearColor];
    
    CGFloat xPos = 5.0;
    
    for (int j=0; j<5; j++)//int j=0; j<imgArray.count; j++
    {
        
        @autoreleasepool {
            
            
            //To create button
            UIButton * locBtn = [[UIButton alloc]init];
            locBtn.frame = CGRectMake(xPos, 0,50 ,30);//xpos,5,60,60
            locBtn.tag=j ;
            //[locBtn addTarget:self action:@selector(ViewProfile1:) forControlEvents:UIControlEventTouchUpInside];
            [locBtn setBackgroundImage:[UIImage imageNamed:@"Tab_bg.png"] forState:UIControlStateNormal];
            [locBtn setBackgroundColor:[UIColor clearColor]];
            [locBtn setTitle:@"Book" forState:UIControlStateNormal];
            
            
            
            [self.scrollView addSubview:locBtn];
            
            xPos += 55;
        }
    }
    
    //self.imgListTableView.hidden=YES;
    [bannerImg addSubview:self.scrollView];
    // [self.view addSubview:self.imgListTableView];
    
}


//[segmentControl setSelectedSegmentIndex:0];
//[[segmentControl.subviews objectAtIndex:0] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
//
//[[segmentControl.subviews objectAtIndex:1] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
//
//[[segmentControl.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];

-(void)segmentedControlValueDidChange1:(UISegmentedControl *)segment
{
    
    for (int i=0; i<[segment.subviews count]; i++)
    {
        if ([[segment.subviews objectAtIndex:i]isSelected] )
        {
            [[segment.subviews objectAtIndex:i] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        }
        else
        {
            [[segment.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
            [[segment.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    
    switch (segment.selectedSegmentIndex) {
        case 0:{
            
            
            //action for the first button (Current)
            
            [self callingWebServiceForGetMyParties];
            // [[segment.selectedSegmentIndex objectAtIndex:0] setTintColor:[UIColor whiteColor]];
            break;
        }
        case 1:{
            //action for the first button (Current)
            [self callingWebServiceForGetMySavedParties];
            break;
        }
    }
}

//to getbookmarked parties list for the user
-(void)callingWebServiceForGetMySavedParties
{
    //get userid userlat and userlong here from local database
    /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        //offer=YES;
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/getbookmarkedparties?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&from=0&to=10",BaseURL];
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


-(void)callingWebServiceForGetMyParties
{
    //get userid userlat and userlong here from local database
    /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/partiessearch?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&from=1&to=13&flag=0&userid=1",BaseURL];
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
    
    
    
        mainDataDict=[rootDict objectForKey:@"data"];
        NSLog(@"mainDataDict=%@",mainDataDict);
    
    //UISegmentedControl *seg;
    
   // self.segmentedControl.selectedSegmentIndex
    if(segmentControl.selectedSegmentIndex==0)
    {
        partiesArray =[mainDataDict valueForKey:@"parties"];
        partyTitleArray=[partiesArray valueForKey:@"title"];
        partyDescArray=[partiesArray valueForKey:@"description"];
        partybannerArray=[partiesArray valueForKey:@"banner"];
        partyAddArray=[partiesArray valueForKey:@"address"];
        partyDDayArray=[partiesArray valueForKey:@"d_day"];
        partyConPhoneArray=[partiesArray valueForKey:@"contact_phone"];
        partyConEmailArray=[partiesArray valueForKey:@"contact_email"];
        partyConPersonArray=[partiesArray valueForKey:@"contact_person"];
        
        NSLog(@"partiesArray=%@",partiesArray);
        NSLog(@"partyTitleArray=%@",partyTitleArray);
        NSLog(@"partyDescArray=%@",partyDescArray);
        NSLog(@"partybannerArray=%@",partybannerArray);
        NSLog(@"partyAddArray=%@",partyAddArray);
        NSLog(@"partyDDayArray=%@",partyDDayArray);
        NSLog(@"partyConPhoneArray=%@",partyConPhoneArray);
        NSLog(@"partyConEmailArray=%@",partyConEmailArray);
        NSLog(@"partyConPersonArray=%@",partyConPersonArray);
        
        createdByDict=[partiesArray valueForKey:@"created_by"];
        createdNameArray=[createdByDict valueForKey:@"name"];
        cretaedProfilePicArray=[createdByDict valueForKey:@"profile_pic"];
        createdProfileTypeArray=[createdByDict valueForKey:@"profile_type"];
        createdRatingArray=[createdByDict valueForKey:@"rating"];
        
        NSLog(@"createdByDict=%@",createdByDict);
        NSLog(@"createdNameArray=%@",createdNameArray);
        NSLog(@"cretaedProfilePicArray=%@",cretaedProfilePicArray);
        NSLog(@"createdProfileTypeArray=%@",createdProfileTypeArray);
        NSLog(@"createdRatingArray=%@",createdRatingArray);
        
        [self timeStampToDate];
        //[myPartiesTableView reloadData];
        
    }
    
    else
    {
    
    partyBookmarkArray=[mainDataDict valueForKey:@"partybookmark"];
    partyTitleArray=[partyBookmarkArray valueForKey:@"title"];
    partyDescArray=[partyBookmarkArray valueForKey:@"description"];
    partybannerArray=[partyBookmarkArray valueForKey:@"banner"];
    partyAddArray=[partyBookmarkArray valueForKey:@"address"];
    partyDDayArray=[partyBookmarkArray valueForKey:@"d_day"];
    partyConPhoneArray=[partyBookmarkArray valueForKey:@"contact_phone"];
    partyConEmailArray=[partyBookmarkArray valueForKey:@"contact_email"];
    partyConPersonArray=[partyBookmarkArray valueForKey:@"contact_person"];
    
    
    

    NSLog(@"partyBookmarkArray=%@",partyBookmarkArray);
    NSLog(@"partyTitleArray=%@",partyTitleArray);
    NSLog(@"partyDescArray=%@",partyDescArray);
    NSLog(@"partybannerArray=%@",partybannerArray);
    NSLog(@"partyAddArray=%@",partyAddArray);
        NSLog(@"partyDDayArray=%@",partyDDayArray);
    NSLog(@"partyConPhoneArray=%@",partyConPhoneArray);
    NSLog(@"partyConEmailArray=%@",partyConEmailArray);
    NSLog(@"partyConPersonArray=%@",partyConPersonArray);
    
    createdByDict=[partyBookmarkArray valueForKey:@"created_by"];
    createdNameArray=[createdByDict valueForKey:@"name"];
    cretaedProfilePicArray=[createdByDict valueForKey:@"profile_pic"];
    createdProfileTypeArray=[createdByDict valueForKey:@"profile_type"];
    createdRatingArray=[createdByDict valueForKey:@"rating"];
    
    NSLog(@"createdByDict=%@",createdByDict);
    NSLog(@"createdNameArray=%@",createdNameArray);
    NSLog(@"cretaedProfilePicArray=%@",cretaedProfilePicArray);
    NSLog(@"createdProfileTypeArray=%@",createdProfileTypeArray);
    NSLog(@"createdRatingArray=%@",createdRatingArray);
    [self timeStampToDate];
       // [myPartiesTableView reloadData];

    }
    
    
    
        // to save the data in locallly in the app.
        // [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
        
   // }
}

-(void)timeStampToDate
{
    // to convert the time stamp into date
    for (int j=0; j<partyDDayArray.count; j++)
    {
        NSTimeInterval _interval=[[partyDDayArray objectAtIndex:j] doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"dd.MM.yyyy"];
        NSString *_date=[_formatter stringFromDate:date];
        [partyDateArray addObject:_date];
        
    }
    NSLog(@"partyDateArray=%@",partyDateArray);
}



@end
