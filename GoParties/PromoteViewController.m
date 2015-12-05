//
//  PromoteViewController.m
//  GoParties
//
//  Created by GoParties on 04/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "PromoteViewController.h"

@interface PromoteViewController ()

@end

@implementation PromoteViewController

@synthesize promoteTableView;;

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
    
    
    return 450;
    
    
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
        cell1.contentView.backgroundColor=[UIColor whiteColor];
        
        
               //For DesignationtextField
        detailTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, 290, 100)];
        // detailTextView.placeholder=@"Max: 100 words";
        detailTextView.text=@"Promote your parties, club, band/s or yourself as an artist and reach your interested audience with this special 'promote' feature.Call us on +919711971244 oR share us your number we will be glad to call you soon Lets us connect via a call to understand and customize your promotions better";
        detailTextView.font=[UIFont systemFontOfSize:15];
        detailTextView.editable=NO;
        detailTextView.scrollEnabled=NO;
        detailTextView.delegate=self;
        detailTextView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:detailTextView];
        
        
        
        detailTextView1=[[UITextView alloc]initWithFrame:CGRectMake(10, 110, 290, 60)];
        // detailTextView1.placeholder=@"Max: 100 words";
        detailTextView1.text=@"Lets us connect via a call to understand and customize your promotions better";
        detailTextView1.font=[UIFont systemFontOfSize:15];
        detailTextView1.editable=NO;
        detailTextView1.scrollEnabled=NO;
        detailTextView1.delegate=self;
        detailTextView1.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:detailTextView1];
        
        
        
        //For Special Deals textField
        phoneTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 200, 200, 30)];
        phoneTextField.placeholder=@"Your Phone Number";
        phoneTextField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"callPhone_TextField.png"]];
        [phoneTextField setBackground:[UIImage imageNamed:@"callPhone_TextField.png"]];
        phoneTextField.delegate=self;
        phoneTextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:phoneTextField];
        
        //For speacial deals Btn
        callBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        callBackBtn.frame=CGRectMake(200, 200, 100, 30);
        callBackBtn.tag=106;
        callBackBtn.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];
        [callBackBtn setImage:[UIImage imageNamed:@"call_back.png"] forState:UIControlStateNormal];
        [callBackBtn setTitle: @"Call Back" forState: UIControlStateNormal];
        //callBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [callBackBtn addTarget:self action:@selector(callBackBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:callBackBtn];
        
        
        
                
        
    }
    
    return cell1;
    
    
}


-(IBAction)callBackBtnClick:(id)sender
{
    NSLog(@"callBackBtnClick");
}

@end
