//
//  PartyDetailViewController.m
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "PartyDetailViewController.h"

@interface PartyDetailViewController ()
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation PartyDetailViewController
@synthesize partyDetailTableView,scrollView;

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
    
    //self.title = NSLocalizedString(@"User Profile", nil);
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
    
      //self.navigationController.navigationBarHidden = NO;
    
    
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
    
    
    locationArray=[[NSMutableArray alloc]initWithObjects:@"All of Delhi NCR",@"Popular Locations",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    categoryArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Parties",@"Events",@"Bands",@"Djs", nil];
    typeArray=[[NSMutableArray alloc]initWithObjects:@"Delhi NCR",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    // Do any additional setup after loading the view from its nib.
    //to check whether user is logged in or not
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"userLoggedIn"])
    {
        homeBtn.hidden=NO;
        myProfBtn.hidden=NO;
        myPartiesbtn.hidden=NO;
        myDealsBtn.hidden=NO;
        accessBtn.hidden=YES;
    }
    else
    {
        accessBtn.hidden=NO;
        homeBtn.hidden=YES;
        myProfBtn.hidden=YES;
        myPartiesbtn.hidden=YES;
        myDealsBtn.hidden=YES;
        
    }
    
    // self.navigationController.navigationBarHidden = YES;
    
    ////////////
    //    viewPager.dataSource = self;
    //    viewPager.delegate = self;
    /////////////////
    

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
    
    //To add num of count label fro messages
    UILabel *messgaeCountLbl = [[UILabel alloc]init];
    messgaeCountLbl.backgroundColor=[UIColor redColor];
    messgaeCountLbl.textColor=[UIColor whiteColor];
    
    //    // getting an NSInteger and sets the value
    //    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //    NSInteger myInt = [prefs integerForKey:@"NumberOfOffers"];
    //
    //    if (myInt ==0)
    //    {
    //
    //    }
    //    else
    //    {
    //        messgaeCountLbl.text=[NSString stringWithFormat:@"%d",myInt];
    messgaeCountLbl.text=@"4";
    messgaeCountLbl.font = [UIFont systemFontOfSize:14.0];
    messgaeCountLbl.textAlignment=NSTextAlignmentCenter;
    messgaeCountLbl.frame = CGRectMake(12.0, -3.0, 15.0, 15.0);
    //To make round
    messgaeCountLbl.layer.cornerRadius = messgaeCountLbl.frame.size.width / 2;
    messgaeCountLbl.layer.borderWidth = 0.0f;
    //messgaeCountLbl.layer.borderColor=[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
    messgaeCountLbl.clipsToBounds = YES;
    [Button addSubview:messgaeCountLbl];
    // }

    
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
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
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
        cell1.contentView.backgroundColor=[UIColor whiteColor];
        //To create the card view.
        cardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
        cardView.backgroundColor=[UIColor colorWithRed:106.0f/255 green:27.0f/255 blue:154.0f/255 alpha:1.0];// 106,27,154
        [cell1.contentView addSubview:cardView];
        
        
        // to set the banner backgroung image
        bannerImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
        bannerImg.image=[UIImage imageNamed:@"First1.png"];
        bannerImg.alpha=0.90;
        [cardView addSubview:bannerImg];
        
        
        UILabel *partyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 40)];
        partyNameLabel.text=@"Love International Festival";
        partyNameLabel.textColor=[UIColor whiteColor];
        [cardView addSubview:partyNameLabel];
        
        //For date Icon
        UIImageView *dateImg=[[UIImageView alloc]initWithFrame:CGRectMake(100, 58, 15, 15)];
        dateImg.image=[UIImage imageNamed:@"calendar_main.png"];
        dateImg.backgroundColor=[UIColor clearColor];
        [cardView addSubview:dateImg];
        
        //For DateLabel
        UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(120, 50, 150, 30)];
        dateLbl.backgroundColor=[UIColor clearColor];
        //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
        dateLbl.font=[dateLbl.font fontWithSize:12];
        dateLbl.text=@"25th Sep 2015";
        dateLbl.textColor=[UIColor whiteColor];
        [cardView addSubview:dateLbl];
        
        //for Separator
        UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(205, 58, 2, 15)];//115, 128, 2, 15
        sepLbl.backgroundColor=[UIColor whiteColor];
        //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
        [cardView addSubview:sepLbl];
        
        //For time Icon
        UIImageView *timeImg=[[UIImageView alloc]initWithFrame:CGRectMake(215, 58, 15, 15)];//125, 128, 15, 15
        timeImg.image=[UIImage imageNamed:@"clock_main.png"];//clock_main.png
        timeImg.backgroundColor=[UIColor clearColor];
        [cardView addSubview:timeImg];
        
        
        
        //for outer circle
        UIView *circularView = [[UIView alloc] initWithFrame:CGRectMake(295,90,60,60)];//240,110,60,60
        circularView.layer.cornerRadius = 30;// half of the height or width of the view
        circularView.layer.borderWidth = 3.0f;
        circularView.layer.borderColor = [UIColor whiteColor].CGColor;
        [cardView addSubview:circularView];
        
        
        
        CAShapeLayer *circle=[CAShapeLayer layer];
        // here set the starting point as zero and ending point as the no of days//30,30
        circle.path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(324,120) radius:29 startAngle:2*M_PI*0-M_PI_2 endAngle:2*M_PI*1-M_PI_2*100/30 clockwise:YES].CGPath;
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
        // to change the string into date
        //[Utils daysBetweenDate:<#(NSDate *)#> andDate:<#(NSDate *)#>];
        // using above method find the no of days between two dates
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
        UILabel *timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(230, 50, 150, 30)];
        timeLbl.backgroundColor=[UIColor clearColor];
        //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
        timeLbl.font=[dateLbl.font fontWithSize:12];
        timeLbl.text=@" 7 PM Onwards";
        timeLbl.textColor=[UIColor whiteColor];
        [cardView addSubview:timeLbl];

        
        //For type
        [self baseScrollView ];
        
        
        //For ProfileImg
        UIImageView *profileImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 90, 60, 60)];//130, 30, 60, 60
        profileImg.image=[UIImage imageNamed:@"AppIcon.png"];
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2;
        profileImg.layer.borderWidth = 2.0f;
        profileImg.layer.borderColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0].CGColor;
        profileImg.layer.masksToBounds = YES;
        profileImg.backgroundColor=[UIColor whiteColor];
        [bannerImg addSubview:profileImg];
        
        
        // profile buttn
        UIButton *partyProfileBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 90, 200, 140)];//
        partyProfileBtn.backgroundColor=[UIColor clearColor];
        // [partyProfileBtn setImage:[UIImage imageNamed:@"bookmark_main.png"] forState:UIControlStateNormal];
        // partyProfileBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        //partyProfileBtn.tag=i;
        [partyProfileBtn addTarget:self action:@selector(partyProfileBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cardView addSubview:partyProfileBtn];
        
        
        
        //for profile title label
        UILabel *profileLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 95, self.view.frame.size.width-20, 30)];//100, 85, self.view.frame.size.width-20, 30
        profileLbl.backgroundColor=[UIColor clearColor];
        //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
        profileLbl.font=[profileLbl.font fontWithSize:15];
        profileLbl.text=@"The Underdoggs";
        profileLbl.textColor=[UIColor whiteColor];
        [cardView addSubview:profileLbl];
        
        
        //for place label
        UILabel *placeLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 115, 100, 30)];//140, 100, 100, 30
        placeLbl.backgroundColor=[UIColor clearColor];
        placeLbl.font=[placeLbl.font fontWithSize:15];
        placeLbl.text=@"Party Place";
        placeLbl.textColor=[UIColor whiteColor];
        [cardView addSubview:placeLbl];
        
        
        
        
        // for rating
        NSInteger b=0;
        for (int j=0; j<5; j++)
        {
            UIImageView *strImg1=[[UIImageView alloc]initWithFrame:CGRectMake(163+b, 122 , 15, 15)];//120+b, 125 , 15, 15
            strImg1.image=[UIImage imageNamed:@"star_white.png"];
            [cardView addSubview:strImg1];
            b=b+15;
        }
        
        
        
        
        ////////// for the view Pager using CAPS PageMenu  //////////////////////////////////
        InfoViewController *controller1 = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
        controller1.title = @"Info";
        LocationViewController *controller2 = [[LocationViewController alloc]initWithNibName:@"LocationViewController" bundle:nil];
        controller2.title = @"Location";
        BookingViewController *controller3 = [[BookingViewController alloc] initWithNibName:@"BookingViewController" bundle:nil];
        controller3.title = @"Booking";
        CommentsViewController *controller4 = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
        controller4.title = @"Comments";
        
        InviteViewController *controller5 = [[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
        controller5.title = @"Invite";
        
        
        NSArray *controllerArray = @[controller1, controller2, controller3, controller4,controller5];
        NSDictionary *parameters = @{
                                     CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:106.0/255 green:27.0/255 blue:154.0/255 alpha:1.00],
                                     CAPSPageMenuOptionViewBackgroundColor: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
                                     CAPSPageMenuOptionSelectionIndicatorColor: [UIColor orangeColor],
                                     CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                     CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:15.0],
                                     CAPSPageMenuOptionMenuHeight: @(40.0),
                                     CAPSPageMenuOptionMenuItemWidth: @(100.0),
                                     CAPSPageMenuOptionCenterMenuItems: @(YES)
                                     };
        
        _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(-0.0, 160.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
        [partyDetailTableView addSubview:_pageMenu.view];
        ///////////////////////////////////////////////////
        
        
        
        
        
        //        NSInteger a=0;
        //        //
        //        //For First Cell, for user comment cell
        //        UIView *cellView=[[UIView alloc]initWithFrame:CGRectMake(10, 220+a, 300, 65)];
        //        cellView.backgroundColor=[UIColor whiteColor];
        //        [userTableView addSubview:cellView];
        
    }
    
    
    
    
    
    // }
    return cell1;
    
    
}



-(void)baseScrollView
{
    
    //int numOfCount=6;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0,170.0,self.view.frame.size.width,40.0)];//0.0,0.0,480.0,960.0
    //    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*(imgArray.count-2.5),self.scrollView.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(640,self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled=YES;
    self.scrollView.userInteractionEnabled=YES;
    self.scrollView.backgroundColor=[UIColor clearColor];
    
    CGFloat xPos = 5.0;
    
    for (int j=0; j<5; j++)//int j=0; j<imgArray.count; j++
    {
        
        @autoreleasepool {
            
            
            //To create button
            UIButton * locBtn = [[UIButton alloc]init];
            locBtn.frame = CGRectMake(xPos, 0,50 ,30);//xpos,5,60,60
            locBtn.tag=j ;
            // [locBtn addTarget:self action:@selector(ViewProfile1:) forControlEvents:UIControlEventTouchUpInside];
            // [locBtn setBackgroundImage:[UIImage imageNamed:@"Tab_bg.png"] forState:UIControlStateNormal];
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

-(IBAction)partyProfileBtnClick:(id)sender
{
    NSLog(@"partyProfileBtnClick");
    ProfileViewController *objP=[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:objP animated:YES];
    
}


- (IBAction)homeBtnClick:(id)sender {
    if([homeBtn currentImage]==[UIImage imageNamed:@"active_home.png"])
    {
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
    }
    else
    {
        [homeBtn setImage:[UIImage imageNamed: @"active_home.png"] forState:UIControlStateNormal];
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
    }
    NSLog(@"home btn clicked");
}

- (IBAction)myProfileBtnClick:(id)sender {
    if([myProfBtn currentImage]==[UIImage imageNamed:@"active_profile.png"])
    {
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
    }
    else
    {
        [myProfBtn setImage:[UIImage imageNamed: @"active_profile.png"] forState:UIControlStateNormal];
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
    }
    NSLog(@"myProfBtn btn clicked");
    
    //    UserProfileViewController *objU=[[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
    //    [self.navigationController pushViewController:objU animated:YES];
}

- (IBAction)myPartiesBtnClick:(id)sender {
    
    if([myPartiesbtn currentImage]==[UIImage imageNamed:@"active_parties.png"])
    {
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
    }
    else
    {
        [myPartiesbtn setImage:[UIImage imageNamed: @"active_parties.png"] forState:UIControlStateNormal];
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
    }
    NSLog(@"myPartiesbtn btn clicked");
    
}

- (IBAction)myDealsBtnClick:(id)sender {
    
    if([myDealsBtn currentImage]==[UIImage imageNamed:@"active_deals.png"])
    {
        [myDealsBtn setImage:[UIImage imageNamed:@"footer_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
    }
    else
    {
        [myDealsBtn setImage:[UIImage imageNamed: @"active_deals.png"] forState:UIControlStateNormal];
        [myProfBtn setImage:[UIImage imageNamed:@"footer_profile.png"] forState:UIControlStateNormal];
        [myPartiesbtn setImage:[UIImage imageNamed:@"footer_parties.png"] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:@"footer_home.png"] forState:UIControlStateNormal];
    }
    NSLog(@"myDealsBtn btn clicked");
    
}

- (IBAction)accessBtnClick:(id)sender {
    HomeViewController *objH=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    [self.navigationController pushViewController:objH animated:YES];
}



@end
