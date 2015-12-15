//
//  InfoViewController.m
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize infoTableView;

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
    
    
    return 300*5;
    
    
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
        UIView *myfeedBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 150)];
        myfeedBackView.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];
        [cell1.contentView addSubview:myfeedBackView];
        
        
        // special offer label
        UILabel *specialOfferLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, (self.view.frame.size.width/2)-10, 30)];
        specialOfferLbl.text=@"Special Offers";
        specialOfferLbl.textColor=[UIColor whiteColor];
        specialOfferLbl.font=[UIFont systemFontOfSize:20];
        [myfeedBackView addSubview:specialOfferLbl];
        
        // Specila Offers Detail TextView
        UITextView *offerTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 40, (self.view.frame.size.width)-20, 100)];
        offerTextView.text=@"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.";
        offerTextView.backgroundColor=[UIColor clearColor];
        offerTextView.font=[UIFont systemFontOfSize:15];
        offerTextView.textColor=[UIColor whiteColor];
        offerTextView.editable=NO;
        [myfeedBackView addSubview:offerTextView];
        
        NSInteger b=0;
        for (int j=0; j<4; j++)
        {
            // for user iconImage
            UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(10+b, 170, 70, 70)];
            iconImg.layer.cornerRadius = iconImg.frame.size.width / 2;
            //iconImg.layer.borderWidth = 2.0f;
            iconImg.layer.masksToBounds = YES;
            iconImg.image=[UIImage imageNamed:@"AppIcon@2x.png"];
            [cell1.contentView addSubview:iconImg];
            
            
            //for icon name label
            UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(20+b, 240, 80, 40)];
            nameLbl.text=@"Offers";
            [cell1.contentView addSubview:nameLbl];

            
            b=b+90;
        }
        
        // for divider
        UILabel *dividerLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 280, self.view.frame.size.width-20, 1)];
        dividerLbl.backgroundColor=[UIColor grayColor];
        [cell1.contentView addSubview:dividerLbl];
        
        //for offer Detail TextView
        UITextView *detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 285, self.view.frame.size.width, 800)];
        detailTextView.text=@"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.";
        detailTextView.font=[UIFont systemFontOfSize:15];
        detailTextView.backgroundColor=[UIColor clearColor];
        detailTextView.editable=NO;
        [cell1.contentView addSubview:detailTextView];
        
        
        }
    return cell1;
    
    
}


@end
