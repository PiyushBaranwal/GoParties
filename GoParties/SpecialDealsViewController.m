//
//  SpecialDealsViewController.m
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "SpecialDealsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SpecialDealsViewController ()

@end

@implementation SpecialDealsViewController

@synthesize dealsTableView;

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
    
    self.title = NSLocalizedString(@"Special Deals", nil);
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
    
    
    locationArray=[[NSMutableArray alloc]initWithObjects:@"All of Delhi NCR",@"Popular Locations",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    categoryArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Parties",@"Events",@"Bands",@"Djs", nil];
    typeArray=[[NSMutableArray alloc]initWithObjects:@"Delhi NCR",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    popUpView=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,568)];
    popUpView.backgroundColor=[UIColor colorWithRed:96.0/255 green:3.0/255 blue:125.0/255 alpha:1.0];
    self.navigationController.navigationBarHidden = YES;
    
    // for title label
    UILabel *searchTtileLbl=[[UILabel alloc]initWithFrame:CGRectMake(120, 20, 80, 40)];
    searchTtileLbl.text=@"SEARCH";
    searchTtileLbl.textColor=[UIColor whiteColor];
    [popUpView addSubview:searchTtileLbl];
    
    //for location icon
    locIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 40, 40)];
    locIcon.image=[UIImage imageNamed:@"Location1.png"];
    locIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:locIcon];
    
    
    // for location textField
    locTextField=[[UITextField alloc]initWithFrame:CGRectMake(50, 70, 260, 40)];
    locTextField.placeholder=@"  Location";
    locTextField.delegate=self;
    locTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:locTextField];
    
    
    // to set the drop down button for location
    UIButton *locBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 70, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25
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
    catIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 120, 40, 40)];
    catIcon.image=[UIImage imageNamed:@"List1.png"];
    catIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:catIcon];
    
    // for category textfield
    catTextField=[[UITextField alloc]initWithFrame:CGRectMake(50, 120, 260, 40)];
    catTextField.placeholder=@"  Category";
    catTextField.delegate=self;
    catTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:catTextField];
    
    // to set the drop down button for category
    UIButton *catBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 120, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25
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
    typeIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 170, 40, 40)];
    typeIcon.image=[UIImage imageNamed:@"Search1.png"];
    typeIcon.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:typeIcon];
    
    // for type textfield
    typeTextField=[[UITextField alloc]initWithFrame:CGRectMake(50, 170, 260, 40)];
    typeTextField.placeholder=@"  Type";
    typeTextField.delegate=self;
    typeTextField.backgroundColor=[UIColor whiteColor];
    [popUpView addSubview:typeTextField];
    
    
    // to set the drop down button for type
    UIButton *typeBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 170, 290, 45)];//6,8,283,50 //250, 245+b, 25, 25
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
    UIButton *searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 220, 300, 45)];
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
}

-(IBAction)locBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50.0f, 70.0f, 260.0f, 150.0f)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
}

-(IBAction)catBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50.0f, 120.0f, 260.0f, 150.0f)];
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
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50.0f, 170.0f, 260.0f, 150.0f)];
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
    
    
    return 225*5;
    
    
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
      
       
//        // To set the segmented control.
//        UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Parties",@"Profiles"]];
//        [segmentControl setSegmentedControlStyle:UISegmentedControlStyleBar];
//        segmentControl.frame = CGRectMake(10, 10, 300, 30);
//        [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
//        [segmentControl setSelectedSegmentIndex:0];
//        
//        [[segmentControl.subviews objectAtIndex:0] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
//        
//        [[segmentControl.subviews objectAtIndex:1] setTintColor: [UIColor whiteColor]];
//        
//        [cell1.contentView addSubview:segmentControl];
        
        
        
        NSInteger a=0;
        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
        {
            
            //To create the card view.
            UIView *cardView=[[UIView alloc]initWithFrame:CGRectMake(5, 10+a, 310, 200)];
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
            UIImageView *bannerImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 310, 170)];
            bannerImg.image=[UIImage imageNamed:@"First1.png"];
            bannerImg.alpha=0.90;
            // to make the rounded corner
            UIBezierPath *maskPath1;
            maskPath1 = [UIBezierPath bezierPathWithRoundedRect:bannerImg.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                   cornerRadii:CGSizeMake(0.0, 0.0)];
            
            CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
            maskLayer1.frame = self.view.bounds;
            maskLayer1.path = maskPath.CGPath;
            bannerImg.layer.mask = maskLayer;
            [cardView addSubview:bannerImg];
            
            
            //For the Free Entry
            UILabel *freeEntryLbl=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 150, 30)];
            freeEntryLbl.backgroundColor=[UIColor clearColor];
            freeEntryLbl.text=@"FREEE ENTRY";
            freeEntryLbl.textColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];
            [cardView addSubview:freeEntryLbl];
            
            
            //For the Detail Lbl1
            UILabel *detailLbl1=[[UILabel alloc]initWithFrame:CGRectMake(30, 40, 280, 30)];
            detailLbl1.backgroundColor=[UIColor clearColor];
            detailLbl1.text=@"Get a FREE shot and FREE entry to";
            detailLbl1.textColor=[UIColor whiteColor];
            [cardView addSubview:detailLbl1];
            
            
            //For the Detail Lbl2
            UILabel *detailLbl2=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 300, 30)];
            detailLbl2.backgroundColor=[UIColor clearColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            detailLbl2.font=[detailLbl2.font fontWithSize:15];
            detailLbl2.text=@"The club on 25th September for our event";
            detailLbl2.textColor=[UIColor whiteColor];
            [cardView addSubview:detailLbl2];

            
            //For ProfileImg
            UIImageView *profileImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 50, 50)];
            //profileImg.image=[UIImage imageNamed:@"First1.png"];
            profileImg.backgroundColor=[UIColor whiteColor];
            [bannerImg addSubview:profileImg];
            
            //for profile title label
            UILabel *profileLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 90, 300, 30)];
            profileLbl.backgroundColor=[UIColor clearColor];
            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
            profileLbl.font=[profileLbl.font fontWithSize:15];
            profileLbl.text=@"The Underdoggs";
            profileLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:profileLbl];
            
            
            //for place label
            UILabel *placeLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 110, 100, 30)];
            placeLbl.backgroundColor=[UIColor clearColor];
            placeLbl.font=[placeLbl.font fontWithSize:15];
            placeLbl.text=@"Party Place";
            placeLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:placeLbl];
            
            
            
            
            // for rating
            NSInteger b=0;
            for (int j=0; j<5; j++)
            {
                 UIImageView *strImg1=[[UIImageView alloc]initWithFrame:CGRectMake(70+b, 135 , 15, 15)];
                strImg1.image=[UIImage imageNamed:@"star_white.png"];
                [cardView addSubview:strImg1];
                b=b+15;
            }
            
            
            
            
            // for follow Button
            UIButton *followBtn=[[UIButton alloc]initWithFrame:CGRectMake(160, 120, 25, 25)];
            [followBtn setImage:[UIImage imageNamed:@"FOLLOW_main.png"] forState:UIControlStateNormal];
            followBtn.tag=i;
            [followBtn addTarget:self action:@selector(followBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:followBtn];
            
            
            
            //for Show Parties with this Deals Label
            UILabel *showDealsLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 170, 280, 30)];
            showDealsLbl.backgroundColor=[UIColor clearColor];
            showDealsLbl.font=[placeLbl.font fontWithSize:15];
            showDealsLbl.text=@"SHOW PARTIES WITH THIS DEAL";
            showDealsLbl.textColor=[UIColor whiteColor];
            [cardView addSubview:showDealsLbl];
            
            //for Add DealBtn
            UIButton *addDealBtn=[[UIButton alloc]initWithFrame:CGRectMake(270, 175, 20, 20)];//10,175,280,20
            addDealBtn.backgroundColor=[UIColor clearColor];
            [addDealBtn setImage:[UIImage imageNamed:@"deal_main.png"] forState:UIControlStateNormal];
             addDealBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            addDealBtn.tag=i;
            [addDealBtn addTarget:self action:@selector(addDealBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [cardView addSubview:addDealBtn];

            
            a=a+210;
        }
        
    }
    
    
    
    // }
    return cell1;
    
    
}

-(IBAction)followBtnClick:(id)sender
{
    NSLog(@"Follow Btn Clicked");
}

-(IBAction)addDealBtnClick:(id)sender
{
    NSLog(@"Add Deal Btn Clicked");
}


-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    
    for (int i=0; i<[segment.subviews count]; i++)
    {
        if ([[segment.subviews objectAtIndex:i]isSelected] )
        {
            [[segment.subviews objectAtIndex:i] setTintColor: [UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0]];
        }else{
            [[segment.subviews objectAtIndex:i] setTintColor:[UIColor whiteColor]];
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

- (IBAction)accessBtnClick:(id)sender
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
