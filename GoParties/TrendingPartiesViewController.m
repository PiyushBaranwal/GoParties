//
//  TrendingPartiesViewController.m
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "TrendingPartiesViewController.h"
#import "PartiesNearYouViewController.h"
#import "ProfileViewController.h"
#import "PartyDetailViewController.h"

#import "Defines.h"
#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"



@interface TrendingPartiesViewController ()
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation TrendingPartiesViewController

@synthesize partiesTableView,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To get the country name from device
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *country = [usLocale displayNameForKey: NSLocaleCountryCode value: countryCode];
    //to set teh default country name
    //    countryTextField.text=country;
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
    self.title = NSLocalizedString(@"Trending Parties", nil);
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,[UIFont fontWithName:@"Open Sans" size:20],NSFontAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    SWRevealViewController *revealController = [self revealViewController];
    // [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Toggle_main.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    
    // revealButtonItem.width=10;
    // [self.navigationItem.leftBarButtonItem setWidth:10];
    
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    //To set the left BarButton background color
    self.navigationItem.leftBarButtonItem.tintColor = [ UIColor whiteColor];
    
    
//    //To add location and location list buttons on left navbar
//    UIButton *Button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
//    [Button1 setImage:[UIImage imageNamed:@"location_pin_main.png"] forState:UIControlStateNormal];
//    //[Button1 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *locButton= [[UIBarButtonItem alloc]initWithCustomView:Button1];
//    
//    
//    UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 120, 25)];
//    [Button setTitle:country forState:UIControlStateNormal];
//    /// [Button setImage:[UIImage imageNamed:@"Notification_Bell_main.png"] forState:UIControlStateNormal];
//    [Button addTarget:self action:@selector(locListBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *locListButton= [[UIBarButtonItem alloc]initWithCustomView:Button];
//    
//    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:revealButtonItem, locButton,locListButton, nil]];
    
    [self AddRightBarButtonItems];
    
    partiesArray=[[NSMutableArray alloc]init];
    bookmarkArray=[[NSMutableArray alloc]init];
    followingArray=[[NSMutableArray alloc]init];;
    partyTitleArray=[[NSMutableArray alloc]init];
    partyAddArray=[[NSMutableArray alloc]init];
    partyPlaceLatArray=[[NSMutableArray alloc]init];
    partyPlaceLongArray=[[NSMutableArray alloc]init];
    partyBannerArray=[[NSMutableArray alloc]init];
    partyIdArray=[[NSMutableArray alloc]init];
    
    
    locationArray=[[NSMutableArray alloc]initWithObjects:@"All of Delhi NCR",@"Popular Locations",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    categoryArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Parties",@"Events",@"Bands",@"Djs", nil];
    typeArray=[[NSMutableArray alloc]initWithObjects:@"Delhi NCR",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    
    
    // to get the user lat and long from local database
    userLatStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserCurLat"];
    userLongStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserCurLong"];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [self callingWebServiceForTrendingParties];
}

-(void)AddRightBarButtonItems
{
    //To add searchButton on the right navbar
    UIButton *Button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
    [Button1 setImage:[UIImage imageNamed:@"search-icon_main.png"] forState:UIControlStateNormal];
    [Button1 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchButton= [[UIBarButtonItem alloc]initWithCustomView:Button1];
    
    
    UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
    [Button setImage:[UIImage imageNamed:@"Notification_Bell_main.png"] forState:UIControlStateNormal];
    //[Button addTarget:self action:@selector(bell) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bellButton= [[UIBarButtonItem alloc]initWithCustomView:Button];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:searchButton, bellButton, nil]];
    
}

-(void)search
{
    //for popup view
    popUpView=[[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    popUpView.backgroundColor=[UIColor colorWithRed:96.0/255 green:3.0/255 blue:125.0/255 alpha:1.0];
    self.navigationController.navigationBarHidden = YES;
    
    // for title label
    UILabel *searchTtileLbl=[[UILabel alloc]initWithFrame:CGRectMake(147, 20, 80, 40)];//(120, 20, 80, 40)
    searchTtileLbl.text=@"SEARCH";
    searchTtileLbl.textColor=[UIColor whiteColor];
    [popUpView addSubview:searchTtileLbl];
    
    //for location icon
    locIcon=[[UIImageView alloc]initWithFrame:CGRectMake(38, 70, 40, 40)];//10, 70, 40, 40
    locIcon.image=[UIImage imageNamed:@"Location1.png"];
    locIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:locIcon];
    
    
    // for location textField
    locTextField=[[UITextField alloc]initWithFrame:CGRectMake(78, 70, 260, 40)];//50, 70, 260, 40
    locTextField.placeholder=@"  Location";
    locTextField.delegate=self;
    locTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:locTextField];
    
    
    // to set the drop down button for location
    UIButton *locBtn=[[UIButton alloc]initWithFrame:CGRectMake(38, 70, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25 //10, 70, 290, 45
    locBtn.backgroundColor=[UIColor clearColor];
    [locBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
    locBtn.tag=100;
    //[locBtn setTitle:@">" forState:UIControlStateNormal];
    [locBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [locBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    locBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [locBtn addTarget:self action:@selector(locBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [popUpView addSubview:locBtn];
    
    
    
    
    
    
    //for category icon
    catIcon=[[UIImageView alloc]initWithFrame:CGRectMake(38, 120, 40, 40)];//10, 120, 40, 40
    catIcon.image=[UIImage imageNamed:@"List1.png"];
    catIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:catIcon];
    
    // for category textfield
    catTextField=[[UITextField alloc]initWithFrame:CGRectMake(78, 120, 260, 40)];//50, 120, 260, 40
    catTextField.placeholder=@"  Category";
    catTextField.delegate=self;
    catTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:catTextField];
    
    // to set the drop down button for category
    UIButton *catBtn=[[UIButton alloc]initWithFrame:CGRectMake(38, 120, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25//10, 120, 290, 45
    catBtn.backgroundColor=[UIColor clearColor];
    [catBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
    catBtn.tag=101;
    //[catBtn setTitle:@">" forState:UIControlStateNormal];
    [catBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [catBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    catBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [catBtn addTarget:self action:@selector(catBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [popUpView addSubview:catBtn];
    
    
    
    
    //for type icon
    typeIcon=[[UIImageView alloc]initWithFrame:CGRectMake(38, 170, 40, 40)];//10, 170, 40, 40
    typeIcon.image=[UIImage imageNamed:@"Search1.png"];
    typeIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:typeIcon];
    
    // for type textfield
    typeTextField=[[UITextField alloc]initWithFrame:CGRectMake(78, 170, 260, 40)];//50, 170, 260, 40
    typeTextField.placeholder=@"  Type";
    typeTextField.delegate=self;
    typeTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:typeTextField];
    
    
    // to set the drop down button for type
    UIButton *typeBtn=[[UIButton alloc]initWithFrame:CGRectMake(38, 170, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25//10, 170, 290, 45
    typeBtn.backgroundColor=[UIColor clearColor];
    [typeBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
    typeBtn.tag=102;
    //[typeBtn setTitle:@">" forState:UIControlStateNormal];
    [typeBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [typeBtn addTarget:self action:@selector(typeBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [popUpView addSubview:typeBtn];
    
    // for search button
    UIButton *searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(38, 220, 300, 45)];//10, 220, 300, 45
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"yello backgroundbtn.png"] forState:UIControlStateNormal];
    //searchBtn.tag=102;
    [searchBtn setTitle:@"Search" forState:UIControlStateNormal];
    //[searchBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick)forControlEvents:UIControlEventTouchUpInside];
    [popUpView addSubview:searchBtn];
    
    
    
    
    
    
    
    //for cancel button
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 15, 50, 50)];
    // [cancelBtn setImage:[UIImage imageNamed:@"search-icon_main.png"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"X" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [popUpView addSubview:cancelBtn];
    
    
    [self.view addSubview:popUpView];
}




-(void)cancel
{
    // to show the navigation bar
    self.navigationController.navigationBarHidden = NO;
    // to remove the popup view
    [popUpView removeFromSuperview];
}



-(void)locListBtnClick
{
    NSLog(@"Location list Button Clicked");
}


-(void)searchBtnClick
{
    NSLog(@"Search Button Clicked");
    // before navigation hit service with filled strings on the search popupview
    //    PartiesNearYouViewController *objParties=[[PartiesNearYouViewController alloc]initWithNibName:@"PartiesNearYouViewController" bundle:nil];
    //    [self.navigationController pushViewController:objParties animated:YES];
}

-(IBAction)locBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(78.0f, 70.0f, 260.0f, 150.0f)];//50.0f, 70.0f, 260.0f, 150.0f
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
}

-(IBAction)catBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(78.0f, 120.0f, 260.0f, 150.0f)];//50.0f, 120.0f, 260.0f, 150.0f
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
    //self.view.backgroundColor=[UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha:0.70];
    
    //[adultTextField resignFirstResponder];
}

-(IBAction)typeBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(78.0f, 170.0f, 260.0f, 150.0f)];//50.0f, 170.0f, 260.0f, 150.0f
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
    //self.view.backgroundColor=[UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha:0.70];
    
    //[adultTextField resignFirstResponder];
    
}


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
    
    
    return 275*5;
    
    
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
        
        
        // To set the segmented control.
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Parties",@"Profiles"]];
        // [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        segmentControl.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);//10, 10, 300, 30
        [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange1:) forControlEvents:UIControlEventValueChanged];
        
        [segmentControl setSelectedSegmentIndex:0];
        [[segmentControl.subviews objectAtIndex:0] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        
        [[segmentControl.subviews objectAtIndex:1] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        
        [[segmentControl.subviews objectAtIndex:1] setBackgroundColor:[UIColor whiteColor]];
        
        
        //        for (id subview in [segmentControl subviews]) {
        //            if ([subview isSelected])
        //                [subview setTintColor:[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        //            else
        //                [subview setTintColor:[UIColor whiteColor]];
        //        }
        
        [cell1.contentView addSubview:segmentControl];
        
        
        
        NSInteger a=0;
        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
        {
            
            //To create the card view.
            UIView *cardView=[[UIView alloc]initWithFrame:CGRectMake(5, 50+a, self.view.frame.size.width-10, 250)];
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
            UIButton *bannerClickBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-10, 140)];//
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
            UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(170, 128, 2, 15)];//115, 128, 2, 15
            sepLbl.backgroundColor=[UIColor whiteColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            [cardView addSubview:sepLbl];
            
            //For time Icon
            UIImageView *timeImg=[[UIImageView alloc]initWithFrame:CGRectMake(180, 128, 15, 15)];//125, 128, 15, 15
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
            // here set the starting point as zero and ending point as the no of days
            circle.path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:27 startAngle:2*M_PI*0-M_PI_2 endAngle:2*M_PI*1-M_PI_2*100/30 clockwise:NO].CGPath;
            circle.fillColor=[UIColor clearColor].CGColor;
            circle.strokeColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0].CGColor;
            circle.lineWidth=4;//4
            
            //            // to set the animation
            //            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            //            animation.duration=10;
            //            animation.removedOnCompletion=NO;
            //            animation.fromValue=@(0);
            //            animation.toValue=@(1);
            //            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            //            [circle addAnimation:animation forKey:@"drawCircleAnimation"];
            
            [circularView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
            [circularView.layer addSublayer:circle];
            
            
            
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
            
            
            
            /////-----------------------------------------------------
            
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
            
            /////-----------------------------------------------------
            
            // for saperator
            UIImageView *saperatorImg=[[UIImageView alloc]initWithFrame:CGRectMake(285, 180 , 5, 70)];//230, 180 , 5, 70
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
    [self.navigationController pushViewController:objPB animated:YES];
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
    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"GoParties!"] applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
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
            // [[segment.selectedSegmentIndex objectAtIndex:0] setTintColor:[UIColor whiteColor]];
            break;
        }
        case 1:{
            //action for the first button (Current)
            break;}
    }
}




#pragma -mark
#pragma  mark Picker view DelegateMethods
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (clickedBtn.tag==100)
    {
        return locationArray.count;
        
    }
    
    else if(clickedBtn.tag==101)
    {
        return categoryArray.count;
    }
    else
    {
        return typeArray.count;
    }
    //    return adultArray.count;
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (clickedBtn.tag==100)
    {
        return locationArray[row];
        
    }
    
    else if(clickedBtn.tag==101)
    {
        return categoryArray[row];
    }
    else
    {
        return typeArray[row];
    }
    //    return adultArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (clickedBtn.tag==100)
    {
        //to set the text
        [locTextField setText:[NSString stringWithFormat:@"  %@",[locationArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        locTextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
        
    }
    
    else if(clickedBtn.tag==101)
    {
        //to set the text
        [catTextField setText:[NSString stringWithFormat:@"  %@",[categoryArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        catTextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    }
    
    else
    {
        //to set the text
        [typeTextField setText:[NSString stringWithFormat:@"  %@",[typeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        typeTextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    }
    
    pickerView.hidden=YES;
    
    //    [salutationTextField setText:[NSString stringWithFormat:@"%@",[countryArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    //    salutationPickerView.hidden=YES;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)callingWebServiceForTrendingParties
{
    //get userid userlat and userlong here from local database
   /// NSString *userIDStr=[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        //offer=YES;
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"%@/partiessearch?access_token=133688745fb3253a0b4c3cbb3f67d444cf4b418a&userid=1&to=10&from=1&flag=2",BaseURL];
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
    partiesArray=[mainDataDict valueForKey:@"parties"];
    partyDict=[partiesArray valueForKey:@"party"];
    bookmarkArray=[partiesArray valueForKey:@"bookmark"];
    followingArray=[partiesArray valueForKey:@"following"];
    partyTitleArray=[partyDict valueForKey:@"title"];
    partyAddArray=[partyDict valueForKey:@"address"];
    partyPlaceLatArray=[partyDict valueForKey:@"latitude"];
    partyPlaceLongArray=[partyDict valueForKey:@"longitude"];
    partyBannerArray=[partyDict valueForKey:@"banner"];
    partyIdArray=[partyDict valueForKey:@"id"];
    partyDescArray=[partyDict valueForKey:@"description"];
    NSLog(@"partiesArray=%@",partiesArray);
    NSLog(@"bookmarkArray=%@",bookmarkArray);
    NSLog(@"followingArray=%@",followingArray);
    NSLog(@"partyTitleArray=%@",partyTitleArray);
    NSLog(@"partyIdArray=%@",partyIdArray);
    NSLog(@"partyAddArray=%@",partyAddArray);
    NSLog(@"partyPlaceLatArray=%@",partyPlaceLatArray);
    NSLog(@"partyPlaceLongArray=%@",partyPlaceLongArray);
    NSLog(@"partyBannerArray=%@",partyBannerArray);
    NSLog(@"partyDescArray=%@",partyDescArray);

    
    
    
    
    
//    NSMutableDictionary *dealDict=[dealsArray valueForKey:@"deal"];
//    NSLog(@"dealDict=%@",dealDict);
//    dealsByDict=[dealDict valueForKey:@"deal_by"];
//    //dealsByArray=[dealsArray valueForKey:@"deal_by"];
//    NSLog(@"dealsByDict=%@",dealsByDict);
//    NSMutableArray *profileTypeArray=[dealsByDict valueForKey:@"profile_type"];
//    NSMutableArray *profilePicArray=[dealsByDict valueForKey:@"profile_pic"];
//    NSMutableArray *ratingArray=[dealsByDict valueForKey:@"rating"];
//    NSMutableArray *coverImgArray=[dealsByDict valueForKey:@"cover"];
//    NSMutableArray *partyCreaterNameArray=[dealsByDict valueForKey:@"name"];
//    NSMutableArray *dealTitleArray=[dealsByDict valueForKey:@"title"];
//    NSMutableArray *dealDescArray=[dealsByDict valueForKey:@"description"];
//    NSLog(@"profileTypeArray=%@",profileTypeArray);
//    NSLog(@"profilePicArray=%@",profilePicArray);
//    NSLog(@"ratingArray=%@",ratingArray);
//    NSLog(@"coverImgArray=%@",coverImgArray);
//    NSLog(@"partyCreaterNameArray=%@",partyCreaterNameArray);
//    
//    
//    NSLog(@"dealTitleArray=%@",dealTitleArray);
//    NSLog(@"dealDescArray=%@",dealDescArray);
    
    
    // to save the data in locallly in the app.
    // [[NSUserDefaults standardUserDefaults] setObject:userAddress forKey:@"userAddress"];
    
    
}


@end
