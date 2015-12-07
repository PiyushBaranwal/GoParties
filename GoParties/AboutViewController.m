//
//  AboutViewController.m
//  GoParties
//
//  Created by GoParties on 05/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize aboutTableView;

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
    
    
    return 950;
    
    
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
        UIView *fBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 310, 100)];
        fBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:fBackView];
        
        // for name label
        UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 290, 30)];
        nameLbl.text=@"Name:";
        nameLbl.textColor=[UIColor grayColor];
        [fBackView addSubview:nameLbl];
        //for nameTextField;
        UITextField *nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        nameTextField.backgroundColor=[UIColor lightGrayColor];
        [fBackView addSubview:nameTextField];
        
        //for saperator line
        UILabel *sepLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 310, 1)];
        sepLbl.backgroundColor=[UIColor lightGrayColor];
        [fBackView addSubview:sepLbl];
        
        
        
        // for type label
        UILabel *typeLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 290, 30)];
        typeLbl.text=@"Type:";
        typeLbl.textColor=[UIColor grayColor];
        [fBackView addSubview:typeLbl];
        //for nameTextField;
        UITextField *typeTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 60, 200, 30)];
        typeTextField.backgroundColor=[UIColor lightGrayColor];
        [fBackView addSubview:typeTextField];
        /////////--------------------------------------------------
        
        // for second back view ---------------------------------------------------
        UIView *sBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 110, 310, 100)];
        sBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:sBackView];
        
        // for name label
        UILabel *mobileLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 290, 30)];
        mobileLbl.text=@"Mobile:";
        mobileLbl.textColor=[UIColor grayColor];
        [sBackView addSubview:mobileLbl];
        //for nameTextField;
        UITextField *mobileTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        mobileTextField.backgroundColor=[UIColor lightGrayColor];
        [sBackView addSubview:mobileTextField];
        
        //for saperator line
        UILabel *sepLbl2=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 310, 1)];
        sepLbl2.backgroundColor=[UIColor lightGrayColor];
        [sBackView addSubview:sepLbl2];
        
        
        
        // for type label
        UILabel *addLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 290, 30)];
        addLbl.text=@"Address:";
        addLbl.textColor=[UIColor grayColor];
        [sBackView addSubview:addLbl];
        //for nameTextField;
        UITextField *addTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 60, 200, 30)];
        addTextField.backgroundColor=[UIColor lightGrayColor];
        [sBackView addSubview:addTextField];
        /////////--------------------------------------------------
        
        // for Third back view ---------------------------------------------------
        UIView *tBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 215, 310, 300)];
        tBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:tBackView];
        
        // for name label
        UILabel *aboutLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 290, 30)];
        aboutLbl.text=@"About:";
        aboutLbl.textColor=[UIColor grayColor];
        [tBackView addSubview:aboutLbl];
        //for nameTextField;
        UITextField *aboutTextField=[[UITextField alloc]initWithFrame:CGRectMake(100, 10, 200, 30)];
        aboutTextField.backgroundColor=[UIColor lightGrayColor];
        [tBackView addSubview:aboutTextField];
        
        //for saperator line
        UILabel *sepLbl3=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 310, 1)];
        sepLbl3.backgroundColor=[UIColor lightGrayColor];
        [tBackView addSubview:sepLbl3];
        
        
        
        // for type label
        UILabel *desLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 290, 30)];
        desLbl.text=@"Description:";
        desLbl.textColor=[UIColor grayColor];
        [tBackView addSubview:desLbl];
        //for nameTextField;
        UITextView *desTextView=[[UITextView alloc]initWithFrame:CGRectMake(5, 90, 300, 205)];
        desTextView.backgroundColor=[UIColor lightGrayColor];
        desTextView.scrollEnabled=NO;
        desTextView.editable=NO;
        [tBackView addSubview:desTextView];
        /////////--------------------------------------------------
        
        // for Fourth back view ---------------------------------------------------
        UIView *frBackView=[[UIView alloc]initWithFrame:CGRectMake(5, 520, 310, 60)];
        frBackView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:frBackView];
        
        
        //for mail btn
        UIButton *mailBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 15, 30, 30)];//
        mailBtn.backgroundColor=[UIColor clearColor];
        [mailBtn setImage:[UIImage imageNamed:@"mail.png"] forState:UIControlStateNormal];
        mailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //mailBtn.tag=i;
        [mailBtn addTarget:self action:@selector(mailBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [frBackView addSubview:mailBtn];
        
        // for mail label
        UILabel *mailLbl=[[UILabel alloc]initWithFrame:CGRectMake(55, 15, 90, 30)];
        mailLbl.text=@"Copy Email";
        mailLbl.textColor=[UIColor grayColor];
        [frBackView addSubview:mailLbl];
        
        
        
        //for saperator line
        UILabel *sepLbl4=[[UILabel alloc]initWithFrame:CGRectMake(150, 0, 1, 60)];
        sepLbl4.backgroundColor=[UIColor lightGrayColor];
        [frBackView addSubview:sepLbl4];
        
        //for webSite btn
        UIButton *webBtn=[[UIButton alloc]initWithFrame:CGRectMake(160, 15, 30, 30)];//
        webBtn.backgroundColor=[UIColor clearColor];
        [webBtn setImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
        webBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //mailBtn.tag=i;
        [webBtn addTarget:self action:@selector(webBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [frBackView addSubview:webBtn];
        
        
        // for type label
        UILabel *webLbl=[[UILabel alloc]initWithFrame:CGRectMake(195, 15, 120, 30)];
        webLbl.text=@"Visit Website";
        webLbl.textColor=[UIColor grayColor];
        [frBackView addSubview:webLbl];
        
        /////////--------------------------------------------------
        
        
        
        
        
        
    }
    
    
    
    // }
    return cell1;
    
    
}


-(IBAction)mailBtnClick:(id)sender
{
    NSLog(@"mailBtnClick Btn Clicked");
}

-(IBAction)webBtnClick:(id)sender
{
    NSLog(@"webBtnClick Clicked");
}




@end
