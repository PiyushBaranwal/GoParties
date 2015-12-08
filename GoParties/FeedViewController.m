//
//  FeedViewController.m
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "FeedViewController.h"



@interface FeedViewController ()

@end

@implementation FeedViewController

@synthesize feedTableView,slideshow;

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
    //    if (titleArray.count==0)
    //    {
    //        return 200;
    //    }
    //    else
    //    {
    //        return 200*(titleArray.count+1);
    //    }
    
    
    return 400*5;
    
    
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
    
    
    
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.row==0)
    {
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.contentView.backgroundColor=[UIColor colorWithRed:220.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1.0];
        
        
        // for the myfeed comment box
        UIView *myfeedBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, 250)];
        myfeedBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:myfeedBackView];
        
        
        // suggested label
        UILabel *suggestedLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, (self.view.frame.size.width/2)-10, 30)];
        suggestedLbl.text=@"Suggested Profiles";
        suggestedLbl.font=[UIFont systemFontOfSize:15];
        [cell1.contentView addSubview:suggestedLbl];
        
        // for sliding part
        // KASlideshow
        
        //UIImageView *sliderImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
        
        slideshow  =[[KASlideShow alloc]initWithFrame:CGRectMake(10, 15, self.view.frame.size.width-20, 150)];//2,2,316,295//2, 2, 316, 255
        slideshow.backgroundColor=[UIColor grayColor];
        slideshow.delegate = self;
        [slideshow setDelay:1]; // Delay between transitions
        [slideshow setTransitionDuration:.5]; // Transition duration
        [slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
        [slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
        //[slideshow addImagesFromURLs:headerImgArray];
        [slideshow addImagesFromResources:@[@"welcome_logo.png",@"welcome_logo.png",@"welcome_logo.png"]];
        [slideshow start];
        [slideshow addGesture:KASlideShowGestureAll];
        [cell1.contentView addSubview:slideshow];

        
        // for user iconImage
        UIImageView *userIconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 170, 70, 70)];
        userIconImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
        [cell1.contentView addSubview:userIconImg];
        
        
        // for my feed Party name label
       UILabel *partyNameLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 165, 170,25)];
        partyNameLbl.text=@"By Underdoggs";
        partyNameLbl.font=[UIFont systemFontOfSize:16];
        partyNameLbl.backgroundColor=[UIColor whiteColor];
        [myfeedBackView addSubview:partyNameLbl];
        
        //for suggested party place label
        UILabel *partyPlaceLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 185, 170,25)];
        partyPlaceLbl.text=@"Party Place";
         partyPlaceLbl.font=[UIFont systemFontOfSize:10];
        partyPlaceLbl.textColor=[UIColor grayColor];
        partyPlaceLbl.backgroundColor=[UIColor whiteColor];
        [myfeedBackView addSubview:partyPlaceLbl];
        
        // for suggested party`s liked no peoples
        UILabel *noOFPplLbl=[[UILabel alloc]initWithFrame:CGRectMake(80, 205, 200,25)];
        noOFPplLbl.text=@"6521 peoples follow this page.";
        noOFPplLbl.font=[UIFont systemFontOfSize:10];
        noOFPplLbl.textColor=[UIColor grayColor];

        noOFPplLbl.backgroundColor=[UIColor whiteColor];
        [myfeedBackView addSubview:noOFPplLbl];
        
        
        
        // for suggested party Follow btn
        UIButton *partyFollowBtn=[[UIButton alloc]initWithFrame:CGRectMake(315, 175, 30, 30)];//260, 175, 30, 30
        partyFollowBtn.backgroundColor=[UIColor grayColor];
        [partyFollowBtn setImage:[UIImage imageNamed:@"FOLLOW_main.png"] forState:UIControlStateNormal];
        partyFollowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        //partyFollowBtn.tag=i;
        [partyFollowBtn addTarget:self action:@selector(partyBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [myfeedBackView addSubview:partyFollowBtn];
        
        //for suggested party follow label
        UILabel *followLbl=[[UILabel alloc]initWithFrame:CGRectMake(305, 200, 80, 30)];//250, 200, 80, 30
        followLbl.text=@"FOLLOW";
        followLbl.font=[UIFont systemFontOfSize:13];
        [myfeedBackView addSubview:followLbl];
        
        //////------------------------------------------------------------
        //// for feeds
        
        NSInteger a=0;
        for (int i=0; i<5; i++)
        {
            UIView *feedBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 265+a, self.view.frame.size.width-10, 350)];//sets height according the feed data
            feedBackView.backgroundColor=[UIColor whiteColor];
            [cell1.contentView addSubview:feedBackView];
            
            
            // for feeded user iconImage
            UIImageView *feededUserImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
            feededUserImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
            feededUserImg.layer.cornerRadius = 20;
            feededUserImg.layer.borderWidth = 3.0f;
            feededUserImg.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
            feededUserImg.clipsToBounds = YES;
            [feedBackView addSubview:feededUserImg];
            
            // user name label
            UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(55, 5, 180, 30)];
            nameLbl.text=@"Varun Bajaj";
            nameLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:nameLbl];
            
            //user feed date/time label
            UILabel *dateTimeLbl=[[UILabel alloc]initWithFrame:CGRectMake(55, 20, 180, 30)];
            dateTimeLbl.text=@"Sep 20 at 08:29pm";
            dateTimeLbl.font=[UIFont systemFontOfSize:10];
            dateTimeLbl.textColor=[UIColor lightGrayColor];
            [feedBackView addSubview:dateTimeLbl];
            
            
            // for feeded image
            UIImageView *feededImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, self.view.frame.size.width-20, 200)];
            feededImg.backgroundColor=[UIColor clearColor];
            feededImg.image=[UIImage imageNamed:@"Verify.png"];
            [feedBackView addSubview:feededImg];
            
            // for feededtext
            UITextView *feededTextView=[[UITextView alloc]initWithFrame:CGRectMake(5, 200, self.view.frame.size.width-20, 100)];
            feededTextView.text=@"Hi there hw t r u?";
            feededTextView.backgroundColor=[UIColor grayColor];
            [feedBackView addSubview:feededTextView];
            
            //to set the seperator
            UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 305, self.view.frame.size.width-20, 1)];
            sepLbl.backgroundColor=[UIColor grayColor];
            [feedBackView addSubview:sepLbl];
            
            // to set the like btn
            UIButton *likeBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 315, 20, 20)];
            likeBtn.backgroundColor=[UIColor clearColor];
            [likeBtn setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
            likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            likeBtn.tag=i;
            [likeBtn addTarget:self action:@selector(likeBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [feedBackView addSubview:likeBtn];
            
            // to set the like label
            UILabel *likeLbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 310, 50, 30)];
            likeLbl.text=@"Like";
            likeLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:likeLbl];
            
            // to set the comment btn
            UIButton *commBtn=[[UIButton alloc]initWithFrame:CGRectMake(128, 315, 20, 20)];//100, 315, 20, 20
            commBtn.backgroundColor=[UIColor clearColor];
            [commBtn setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
            commBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            commBtn.tag=i;
            [commBtn addTarget:self action:@selector(commBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [feedBackView addSubview:commBtn];
            
            
            // to set the cooment lbel
            UILabel *commLbl=[[UILabel alloc]initWithFrame:CGRectMake(158, 310, 90, 30)];//130, 310, 90, 30
            commLbl.text=@"Comments";
            commLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:commLbl];
            
            
            // to set the share btn
            UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(253, 315, 20, 20)];//225, 315, 20, 20
            shareBtn.backgroundColor=[UIColor clearColor];
            [shareBtn setImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
            shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            shareBtn.tag=i;
            [shareBtn addTarget:self action:@selector(shareBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [feedBackView addSubview:shareBtn];
            
            // to set the share label
            UILabel *shareLbl=[[UILabel alloc]initWithFrame:CGRectMake(278, 310, 100, 30)];//250, 310, 100, 30
            shareLbl.text=@"Share";
            shareLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:shareLbl];
            
            a=a+360;
            
        }
    }
    return cell1;
    
    
}


-(IBAction)likeBtnClick:(id)sender
{
    
}

-(IBAction)commBtnClick:(id)sender
{
    
}

-(IBAction)shareBtnClick:(id)sender
{
    
}

@end
