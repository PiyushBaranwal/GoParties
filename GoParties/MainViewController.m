//
//  MainViewController.m
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "MainViewController.h"

#import "HomeViewController.h"
#import "SearchPartiesViewController.h"
#import "PartiesNearYouViewController.h"
#import "TrendingPartiesViewController.h"
#import "SpecialDealsViewController.h"
#import "PartiesCalendarViewController.h"
#import "CreatePartiesViewController.h"
#import "InviteFriendsViewController.h"
#import "NotificationViewController.h"
#import "SettingsViewController.h"



@interface MainViewController ()

@end

@implementation MainViewController
@synthesize slideshow,listTableView;

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
    
   // self.title = NSLocalizedString(@"Main", nil);
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
    
    
    //To add location and location list buttons on left navbar
    UIButton *Button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 25)];
    [Button1 setImage:[UIImage imageNamed:@"location_pin_main.png"] forState:UIControlStateNormal];
    //[Button1 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *locButton= [[UIBarButtonItem alloc]initWithCustomView:Button1];
    
    
    UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 120, 25)];
    [Button setTitle:country forState:UIControlStateNormal];
   /// [Button setImage:[UIImage imageNamed:@"Notification_Bell_main.png"] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(locListBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *locListButton= [[UIBarButtonItem alloc]initWithCustomView:Button];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:revealButtonItem, locButton,locListButton, nil]];
    
    
    
    
    
    
    
    // to set the buttons on right bar item
    [self AddRightBarButtonItems];
    
    //[self.view setBackgroundColor:[UIColor lightGrayColor]];
    //[self.listTableView setBackgroundColor:[UIColor lightGrayColor]];
    iconImgArray=[[NSMutableArray alloc]init];
   titleArray=[[NSMutableArray alloc]init];
    descArray= [[NSMutableArray alloc]init];
    
    
    
    locationArray=[[NSMutableArray alloc]initWithObjects:@"All of Delhi NCR",@"Popular Locations",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    categoryArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Parties",@"Events",@"Bands",@"Djs", nil];
    typeArray=[[NSMutableArray alloc]initWithObjects:@"Delhi NCR",@"Mumbai",@"Chandigarh",@"Banglore", nil];
    

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
    // before navigation hit service with filled strings on the search popupview
//    PartiesNearYouViewController *objParties=[[PartiesNearYouViewController alloc]initWithNibName:@"PartiesNearYouViewController" bundle:nil];
//    [self.navigationController pushViewController:objParties animated:YES];
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
    
    
        return 125*5;
   
    
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
//    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
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
        [cell1 setBackgroundColor:[UIColor whiteColor]];
//        if (banImgArray.count)
//        {
            // KASlideshow
            slideshow  =[[KASlideShow alloc]initWithFrame:CGRectMake(3, 3, 314, 205)];//3, 3, 314, 245
            //slideshow.backgroundColor=[UIColor grayColor];
            slideshow.backgroundColor=[UIColor whiteColor];
            slideshow.delegate = self;
            [slideshow setDelay:1]; // Delay between transitions
            [slideshow setTransitionDuration:.5]; // Transition duration
            [slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
            [slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
            //[slideshow addImagesFromURLs:banImgArray];
        [slideshow addImagesFromResources:@[@"First1.png",@"Second1.png"]];
            [slideshow addGesture:KASlideShowGestureAll];
        [slideshow start];
            [cell1.contentView addSubview:slideshow];
            
       // }
        
        
        // To set the name and location name on banner
        //name label
        UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 130, 160, 30)];
        nameLbl.backgroundColor=[UIColor whiteColor];
        nameLbl.text=@"  Ladies Night ";
        [slideshow addSubview:nameLbl];
        // location label
        UILabel *locLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 160, 160, 30)];
        locLbl.backgroundColor=[UIColor whiteColor];
        locLbl.textColor=[UIColor grayColor];
        locLbl.text=@"  New Delhi,India";
        [slideshow addSubview:locLbl];
        

        
        
        NSInteger a=0;
        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
        {
            //For First Cell
            UIView *cellView=[[UIView alloc]initWithFrame:CGRectMake(9, 225+a, 298, 65)];
            cellView.backgroundColor=[UIColor whiteColor];
            [listTableView addSubview:cellView];
            
            
            //for Icon back Image
           UIImageView *iconBackImg=[[UIImageView alloc]initWithFrame:CGRectMake(7, 8, 50, 50)];
            iconBackImg.layer.cornerRadius = iconBackImg.frame.size.width / 2;
            iconBackImg.backgroundColor=[UIColor colorWithRed:96.0/255 green:3.0/255 blue:125.0/255 alpha:1.0];
            iconBackImg.clipsToBounds = YES;
            
            
            //for icon image
            UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
            //For Title Lable
            UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(68, 5, 190, 25)];
            titleLbl.textColor=[UIColor colorWithRed:96.0/255 green:3.0/255 blue:125.0/255 alpha:1.0];
            [titleLbl setFont: [titleLbl.font fontWithSize: 15]];
            //For detail Label
            UILabel *detailLbl=[[UILabel alloc]initWithFrame:CGRectMake(68, 15, 190, 50)];
            [detailLbl setFont: [detailLbl.font fontWithSize: 10]];
            detailLbl.numberOfLines=4;
            if (i==0)
            {
                iconImg.image=[UIImage imageNamed:@"search-icon_main2.png" ];
                titleLbl.text=@"Search Parties";
                detailLbl.text=@"Search parties that you like by using filters like party, places, DJs etc.";
            }
            else if (i==1)
            {
                iconImg.image=[UIImage imageNamed:@"LocationArrow_main.png" ];
                titleLbl.text=@"Parties Near You";
                 detailLbl.text=@"Explore what is happening around you in the party circle.";
            }
            else if (i==2)
            {
                 iconImg.image=[UIImage imageNamed:@"trending_main.png" ];
                titleLbl.text=@"Trending Parties";
                detailLbl.text=@"Discover trending parties in town and be where the world is.";
            }
            else if(i==3)
            {
                 iconImg.image=[UIImage imageNamed:@"percent_main.png" ];
                titleLbl.text=@"Special Deals";
                detailLbl.text=@"Avail deals on the parties and go party with offers.";
            }
            else if(i==4)
            {
                iconImg.image=[UIImage imageNamed:@"calendar_main.png" ];
                titleLbl.text=@"Parties Master Calendar";
                detailLbl.text=@"Look for parties schedule in the days to come.";
            }
            
            [iconBackImg addSubview:iconImg];
            [cellView addSubview:iconBackImg];
            
            //For Title Lable
           // UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(78, 20, 142, 25)];
//            titleLbl.text=[titleArray objectAtIndex:i];
           // titleLbl.font=[UIFont fontWithName:@"Open Sans" size:15];
            //detailLbl.font=[UIFont fontWithName:@"Open Sans" size:12];
            [cellView addSubview:titleLbl];
            [cellView addSubview:detailLbl];
            
            //For Select Button
            UIButton *selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 235+a, 295, 45)];//6,8,283,50 //250, 245+b, 25, 25
            selectBtn.backgroundColor=[UIColor clearColor];
            //[selectBtn setImage:[UIImage imageNamed:@"Arrow_main.png"] forState:UIControlStateNormal];
            selectBtn.tag=i;
            [selectBtn setTitle:@">" forState:UIControlStateNormal];
            [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
            [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [selectBtn addTarget:self action:@selector(nextBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [listTableView addSubview:selectBtn];
            
            a=a+80;
        }
  
    }
    
    
    
    // }
    return cell1;
    
    
}

-(IBAction)nextBtnClick:(id)sender
{
    
    btn=(UIButton*)sender;
    NSLog(@"Btn.tag=%d",btn.tag);
    NSLog(@"next Button Clicked");
    
    if (btn.tag==0)
    {
        [self search];
        
//        SearchPartiesViewController *objHome=[[SearchPartiesViewController alloc]initWithNibName:@"SearchPartiesViewController" bundle:nil];
//        [self.navigationController pushViewController:objHome animated:YES];
    }
    if (btn.tag==1)
    {
        PartiesNearYouViewController *objHome=[[PartiesNearYouViewController alloc]initWithNibName:@"PartiesNearYouViewController" bundle:nil];
        [self.navigationController pushViewController:objHome animated:YES];
    }
    if (btn.tag==2)
    {
        TrendingPartiesViewController *objHome=[[TrendingPartiesViewController alloc]initWithNibName:@"TrendingPartiesViewController" bundle:nil];
        [self.navigationController pushViewController:objHome animated:YES];
    }
    if (btn.tag==3)
    {
        SpecialDealsViewController *objHome=[[SpecialDealsViewController alloc]initWithNibName:@"SpecialDealsViewController" bundle:nil];
        [self.navigationController pushViewController:objHome animated:YES];
    }
    if (btn.tag==4)
    {
        PartiesCalendarViewController *objHome=[[PartiesCalendarViewController alloc]initWithNibName:@"PartiesCalendarViewController" bundle:nil];
        [self.navigationController pushViewController:objHome animated:YES];
    }

    
    
//    BAEatDetailViewController *objDD=[[BAEatDetailViewController alloc]initWithNibName:@"BAEatDetailViewController" bundle:nil];
//    objDD.nodeTag=[nidArray objectAtIndex:btn.tag];
//    [self.navigationController pushViewController:objDD animated:YES];
}


//To remove virtual keyboard from screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    
//    if (textField==locTextField || textField==catTextField)
//    {
//        // added this line on 02.07.15
//        // [textField resignFirstResponder];
//    }
//    
//    else if(textField==nameTextField || textField==passTextField)
//    {
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.35f];
//        CGRect frame = self.view.frame; frame.origin.y = -150;
//        [self.view setFrame:frame];
//        [UIView commitAnimations];
//    }
//    else
//    {
//        // added this line on 02.07.15
//        // [textField resignFirstResponder];
//    }
    
}


@end
