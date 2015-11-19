//
//  MainViewController.m
//  GoParties
//
//  Created by GoParties on 19/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize slideshow,listTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    //    // To add the functionality of left menu bar button
    
    self.title = NSLocalizedString(@"Main", nil);
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
    
    [self AddRightBarButtonItems];
    
    //[self.view setBackgroundColor:[UIColor lightGrayColor]];
    //[self.listTableView setBackgroundColor:[UIColor lightGrayColor]];
    iconImgArray=[[NSMutableArray alloc]init];
   titleArray=[[NSMutableArray alloc]init];
    descArray= [[NSMutableArray alloc]init];

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
        [Button addTarget:self action:@selector(bell) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *bellButton= [[UIBarButtonItem alloc]initWithCustomView:Button];
        
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:searchButton, bellButton, nil]];
        
    }

-(void)search
{
    
}

-(void)bell
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
        
        
        
        NSInteger a=0;
        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
        {
            //For First Cell
            UIView *cellView=[[UIView alloc]initWithFrame:CGRectMake(9, 225+a, 298, 65)];
            cellView.backgroundColor=[UIColor lightGrayColor];
            [listTableView addSubview:cellView];
            
            [cell1.contentView addSubview:slideshow];
            
            
            //for Icon Image
            //use iconImgArray;
            UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(7, 8, 50, 50)];
            iconImg.layer.cornerRadius = iconImg.frame.size.width / 2;
            //iconImg.layer.borderWidth = 3.0f;
            //iconImg.layer.borderColor=[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
            iconImg.clipsToBounds = YES;
           iconImg.image=[UIImage imageNamed:@"search.png" ];
            iconImg.backgroundColor=[UIColor colorWithRed:96.0/255 green:3.0/255 blue:125.0/255 alpha:1.0];
            [cellView addSubview:iconImg];
            
            //For Title Lable
            UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(78, 20, 142, 25)];
//            titleLbl.text=[titleArray objectAtIndex:i];
            titleLbl.font=[UIFont fontWithName:@"Open Sans" size:15];
            [cellView addSubview:titleLbl];
            
            //For Select Button
            UIButton *selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 235+a, 275, 45)];//6,8,283,50 //250, 245+b, 25, 25
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
    
    UIButton *btn=(UIButton*)sender;
    NSLog(@"Btn.tag=%d",btn.tag);
    NSLog(@"next Button Clicked");
    
    
//    BAEatDetailViewController *objDD=[[BAEatDetailViewController alloc]initWithNibName:@"BAEatDetailViewController" bundle:nil];
//    objDD.nodeTag=[nidArray objectAtIndex:btn.tag];
//    [self.navigationController pushViewController:objDD animated:YES];
}


@end
