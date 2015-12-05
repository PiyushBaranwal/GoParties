//
//  MyFeedViewController.m
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "MyFeedViewController.h"

@interface MyFeedViewController ()

@end

@implementation MyFeedViewController

@synthesize feedTableView;

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
        UIView *myfeedBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 310, 80)];
        myfeedBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:myfeedBackView];
        
        
        // for user iconImage
        UIImageView *userIconImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        userIconImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
        userIconImg.layer.cornerRadius = 35;
        userIconImg.layer.borderWidth = 3.0f;
        userIconImg.layer.borderColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0].CGColor;
        userIconImg.clipsToBounds = YES;
        [myfeedBackView addSubview:userIconImg];
        
        
        // for my feed textview
        UITextView *userFeedText=[[UITextView alloc]initWithFrame:CGRectMake(75, 5, 170,70)];
        userFeedText.text=@"What`s on your party mind?";
        userFeedText.backgroundColor=[UIColor whiteColor];
        [myfeedBackView addSubview:userFeedText];
        
        
    //////------------------------------------------------------------
        //// for feeds
        
        NSInteger a=0;
        for (int i=0; i<5; i++)
        {
            UIView *feedBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 95+a, 310, 350)];//sets height according the feed data
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
            UIImageView *feededImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 300, 200)];
            feededImg.backgroundColor=[UIColor clearColor];
            feededImg.image=[UIImage imageNamed:@"Verify.png"];
            [feedBackView addSubview:feededImg];
            
            // for feededtext
            UITextView *feededTextView=[[UITextView alloc]initWithFrame:CGRectMake(5, 200, 300, 100)];
            feededTextView.text=@"Hi there hw t r u?";
            feededTextView.backgroundColor=[UIColor grayColor];
            [feedBackView addSubview:feededTextView];
            
            //to set the seperator
            UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 305, 300, 1)];
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
            UIButton *commBtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 315, 20, 20)];
            commBtn.backgroundColor=[UIColor clearColor];
            [commBtn setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
            commBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            commBtn.tag=i;
            [commBtn addTarget:self action:@selector(commBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [feedBackView addSubview:commBtn];
            
            
            // to set the cooment lbel
            UILabel *commLbl=[[UILabel alloc]initWithFrame:CGRectMake(130, 310, 90, 30)];
            commLbl.text=@"Comments";
            commLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:commLbl];
            
            
            // to set the share btn
            UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(225, 315, 20, 20)];
            shareBtn.backgroundColor=[UIColor clearColor];
            [shareBtn setImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
            shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            shareBtn.tag=i;
            [shareBtn addTarget:self action:@selector(shareBtnClick:)forControlEvents:UIControlEventTouchUpInside];
            [feedBackView addSubview:shareBtn];
            
            // to set the share label
            UILabel *shareLbl=[[UILabel alloc]initWithFrame:CGRectMake(250, 310, 100, 30)];
            shareLbl.text=@"Share";
            shareLbl.font=[UIFont systemFontOfSize:15];
            [feedBackView addSubview:shareLbl];
            
            a=a+360;
            
        }
        
        
        
//        NSInteger a=0;
//        for(int i=0; i<5; i++)// (int i=0; i<titleArray.count; i++)
//        {
//            
//            //To create the card view.
//            UIView *cardView=[[UIView alloc]initWithFrame:CGRectMake(5, 50+a, 310, 250)];
//            if(i%2==0)
//            {
//                cardView.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];// 255,153,0
//            }
//            else
//            {
//                cardView.backgroundColor=[UIColor colorWithRed:106.0f/255 green:27.0f/255 blue:154.0f/255 alpha:1.0];// 106,27,154
//            }
//            
//            
//            //To make the top left and right corner rounded
//            UIBezierPath *maskPath;
//            maskPath = [UIBezierPath bezierPathWithRoundedRect:cardView.bounds
//                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
//                                                   cornerRadii:CGSizeMake(8.0, 8.0)];
//            
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = self.view.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cardView.layer.mask = maskLayer;
//            [cell1.contentView addSubview:cardView];
//            
//            
//            // to set the banner backgroung image
//            bannerImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 310, 140)];
//            bannerImg.image=[UIImage imageNamed:@"First1.png"];
//            bannerImg.alpha=0.90;
//            [cardView addSubview:bannerImg];
//            
//            
//            
//            //For type
//            [self baseScrollView ];
//            
//            
//            
//            //for the bookMarkButton
//            UIButton *bookMarkBtn=[[UIButton alloc]initWithFrame:CGRectMake(5, 10, 30, 25)];//
//            bookMarkBtn.backgroundColor=[UIColor clearColor];
//            [bookMarkBtn setImage:[UIImage imageNamed:@"bookmark_main.png"] forState:UIControlStateNormal];
//            bookMarkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            bookMarkBtn.tag=i;
//            [bookMarkBtn addTarget:self action:@selector(bookMarkBtnClick:)forControlEvents:UIControlEventTouchUpInside];
//            [cardView addSubview:bookMarkBtn];
//            
//            
//            //For friendInvite btn
//            UIButton *frndInvbtn=[[UIButton alloc]initWithFrame:CGRectMake(245, 10, 30, 25)];//
//            frndInvbtn.backgroundColor=[UIColor clearColor];
//            [frndInvbtn setImage:[UIImage imageNamed:@"add_user_main.png"] forState:UIControlStateNormal];
//            frndInvbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            frndInvbtn.tag=i;
//            [frndInvbtn addTarget:self action:@selector(frndInviteBtnClick:)forControlEvents:UIControlEventTouchUpInside];
//            [cardView addSubview:frndInvbtn];
//            
//            //For Share btn
//            UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(275, 10, 30, 25)];//
//            shareBtn.backgroundColor=[UIColor clearColor];
//            [shareBtn setImage:[UIImage imageNamed:@"share_main.png"] forState:UIControlStateNormal];
//            shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            shareBtn.tag=i;
//            [shareBtn addTarget:self action:@selector(shareBtnClick:)forControlEvents:UIControlEventTouchUpInside];
//            [cardView addSubview:shareBtn];
//            
//            
//            //For the Free Entry
//            UILabel *partyTitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 150, 30)];
//            partyTitleLbl.backgroundColor=[UIColor clearColor];
//            partyTitleLbl.text=@"LADIES NIGHT";
//            partyTitleLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:partyTitleLbl];
//            
//            
//            
//            //For date Icon
//            UIImageView *dateImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 128, 15, 15)];
//            dateImg.image=[UIImage imageNamed:@"calendar_main.png"];
//            dateImg.backgroundColor=[UIColor clearColor];
//            [cardView addSubview:dateImg];
//            
//            //For DateLabel
//            UILabel *dateLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 120, 150, 30)];
//            dateLbl.backgroundColor=[UIColor clearColor];
//            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
//            dateLbl.font=[dateLbl.font fontWithSize:12];
//            dateLbl.text=@"25th Sep 2015";
//            dateLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:dateLbl];
//            
//            //for Separator
//            UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(115, 128, 2, 15)];
//            sepLbl.backgroundColor=[UIColor whiteColor];
//            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
//            [cardView addSubview:sepLbl];
//            
//            //For time Icon
//            UIImageView *timeImg=[[UIImageView alloc]initWithFrame:CGRectMake(125, 128, 15, 15)];
//            timeImg.image=[UIImage imageNamed:@"clock_main.png"];
//            timeImg.backgroundColor=[UIColor clearColor];
//            [cardView addSubview:timeImg];
//            
//            
//            
//            //for outer circle
//            UIView *circularView = [[UIView alloc] initWithFrame:CGRectMake(240,110,60,60)];
//            circularView.layer.cornerRadius = 30;// half of the height or width of the view
//            circularView.layer.borderWidth = 3.0f;
//            circularView.layer.borderColor = [UIColor whiteColor].CGColor;
//            [cardView addSubview:circularView];
//            
//            
//            
//            CAShapeLayer *circle=[CAShapeLayer layer];
//            // here set the starting point as zero and ending point as the no of days
//            circle.path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:27 startAngle:2*M_PI*0-M_PI_2 endAngle:2*M_PI*1-M_PI_2*100/30 clockwise:NO].CGPath;
//            circle.fillColor=[UIColor clearColor].CGColor;
//            circle.strokeColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0].CGColor;
//            circle.lineWidth=4;//4
//            
//            //            // to set the animation
//            //            CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            //            animation.duration=10;
//            //            animation.removedOnCompletion=NO;
//            //            animation.fromValue=@(0);
//            //            animation.toValue=@(1);
//            //            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//            //            [circle addAnimation:animation forKey:@"drawCircleAnimation"];
//            
//            [circularView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
//            [circularView.layer addSublayer:circle];
//            
//            
//            
//            // for inner circle
//            UIView *innercircularView = [[UIView alloc] initWithFrame:CGRectMake(3,3,54,54)];
//            //circularView.alpha = 0.5;
//            innercircularView.backgroundColor=[UIColor clearColor];
//            innercircularView.layer.cornerRadius = 27;
//            [circularView addSubview:innercircularView];
//            
//            // for no of days
//            UILabel *noLbl=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 40, 30)];
//            noLbl.backgroundColor=[UIColor clearColor];
//            noLbl.text=@"30";
//            noLbl.textColor=[UIColor whiteColor];
//            //noLbl.font=[UIFont fontWithName:@"Sans" size:12.0];
//            [innercircularView addSubview:noLbl];
//            
//            // for days
//            UILabel *dayLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 30)];
//            dayLbl.backgroundColor=[UIColor clearColor];
//            dayLbl.text=@"Days";
//            dayLbl.textColor=[UIColor whiteColor];
//            //noLbl.font=[UIFont fontWithName:@"Sans" size:12.0];
//            [innercircularView addSubview:dayLbl];
//            
//            
//            
//            
//            
//            //for Time Label
//            UILabel *timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(140, 120, 150, 30)];
//            timeLbl.backgroundColor=[UIColor clearColor];
//            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
//            timeLbl.font=[dateLbl.font fontWithSize:12];
//            timeLbl.text=@" 7 PM Onwards";
//            timeLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:timeLbl];
//            
//            
//            
//            //For location icon
//            UIImageView *locImg=[[UIImageView alloc]initWithFrame:CGRectMake(5, 148, 15, 15)];
//            locImg.image=[UIImage imageNamed:@"location_pin_main.png"];
//            locImg.backgroundColor=[UIColor clearColor];
//            [cardView addSubview:locImg];
//            
//            
//            //For location Name Label
//            UILabel *locationLbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 140, 280, 30)];
//            locationLbl.backgroundColor=[UIColor clearColor];
//            locationLbl.font=[locationLbl.font fontWithSize:12];
//            locationLbl.text=@"Karol Bagh, New Delhi";
//            locationLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:locationLbl];
//            
//            //For ProfileImg
//            UIImageView *profileImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 150, 50, 50)];
//            //profileImg.image=[UIImage imageNamed:@"First1.png"];
//            profileImg.layer.cornerRadius = 5;
//            profileImg.layer.masksToBounds = YES;
//            profileImg.backgroundColor=[UIColor whiteColor];
//            [bannerImg addSubview:profileImg];
//            
//            //for profile title label
//            UILabel *profileLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 180, 300, 30)];
//            profileLbl.backgroundColor=[UIColor clearColor];
//            //detailLbl2.font=[UIFont fontWithName:@"Sans" size:12.0];
//            profileLbl.font=[profileLbl.font fontWithSize:15];
//            profileLbl.text=@"The Underdoggs";
//            profileLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:profileLbl];
//            
//            
//            //for place label
//            UILabel *placeLbl=[[UILabel alloc]initWithFrame:CGRectMake(70, 200, 100, 30)];
//            placeLbl.backgroundColor=[UIColor clearColor];
//            placeLbl.font=[placeLbl.font fontWithSize:15];
//            placeLbl.text=@"Party Place";
//            placeLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:placeLbl];
//            
//            
//            
//            
//            // for rating
//            NSInteger b=0;
//            for (int j=0; j<5; j++)
//            {
//                UIImageView *strImg1=[[UIImageView alloc]initWithFrame:CGRectMake(70+b, 225 , 15, 15)];
//                strImg1.image=[UIImage imageNamed:@"star_white.png"];
//                [cardView addSubview:strImg1];
//                b=b+15;
//            }
//            
//            
//            // for saperator
//            UIImageView *saperatorImg=[[UIImageView alloc]initWithFrame:CGRectMake(230, 180 , 5, 70)];
//            saperatorImg.image=[UIImage imageNamed:@"Seprator.png"];
//            [cardView addSubview:saperatorImg];
//            
//            
//            
//            
//            
//            
//            //for Add DealBtn
//            UIButton *followBtn=[[UIButton alloc]initWithFrame:CGRectMake(260, 190, 30, 30)];//10,175,280,20
//            followBtn.backgroundColor=[UIColor clearColor];
//            [followBtn setImage:[UIImage imageNamed:@"FOLLOW_main.png"] forState:UIControlStateNormal];
//            followBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            followBtn.tag=i;
//            [followBtn addTarget:self action:@selector(addDealBtnClick:)forControlEvents:UIControlEventTouchUpInside];
//            [cardView addSubview:followBtn];
//            
//            //for FOLLOW Label
//            UILabel *followLbl=[[UILabel alloc]initWithFrame:CGRectMake(240, 220, 70, 30)];
//            followLbl.backgroundColor=[UIColor clearColor];
//            followLbl.font=[placeLbl.font fontWithSize:15];
//            followLbl.text=@"FOLLOW";
//            followLbl.textColor=[UIColor whiteColor];
//            [cardView addSubview:followLbl];
//            
//            
//            a=a+260;
//        }
        
    }
    
    
    
    // }
    return cell1;
    
    
}


@end
