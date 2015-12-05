//
//  CreatePartiesViewController.m
//  GoParties
//
//  Created by GoParties on 17/11/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "CreatePartiesViewController.h"

@interface CreatePartiesViewController ()

@end

@implementation CreatePartiesViewController

@synthesize createPartiesTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    locationArray=[[NSMutableArray alloc]initWithObjects:@"All of Delhi NCR",@"Popular Locations",@"Mumbai",@"Chandigarh",@"Banglore", nil];
   // categoryArray=[[NSMutableArray alloc]initWithObjects:@"All",@"Parties",@"Events",@"Bands",@"Djs", nil];
    typeArray=[[NSMutableArray alloc]initWithObjects:@"Delhi NCR",@"Mumbai",@"Chandigarh",@"Banglore", nil];


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
    
    
    return 1150;
    
    
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
        
       //for Title
        //Title label
        UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 30)];
        titleLbl.text=@"Title:";
        [cell1.contentView addSubview:titleLbl];
        
        //For Title textField
        titletextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 10, 180, 30)];
        titletextField.placeholder=@"Title";
        titletextField.delegate=self;
        titletextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:titletextField];
        
        
        
        //for Type
        //Type label
        UILabel *typeLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 55, 50, 30)];
        typeLbl.text=@"Type:";
        [cell1.contentView addSubview:typeLbl];
        
        //For Type textField
        typetextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 55, 180, 30)];
        typetextField.placeholder=@"Party Type";
        typetextField.delegate=self;
        typetextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:typetextField];
        
        //For type Btn
        typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        typeBtn.frame=CGRectMake(120, 55, 180, 30);
        typeBtn.tag=100;
        typeBtn.backgroundColor=[UIColor clearColor];
        [typeBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        typeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [typeBtn addTarget:self action:@selector(typeBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:typeBtn];

        
        //for When
        // for when Label
        UILabel *whenLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 50, 30)];
        whenLbl.text=@"When:";
        [cell1.contentView addSubview:whenLbl];
        
        //For When textField
        whentextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 100, 180, 30)];
        whentextField.placeholder=@"Party Time";
        whentextField.delegate=self;
        whentextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:whentextField];
        
        //For when Btn
        whenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        whenBtn.frame=CGRectMake(120, 100, 180, 30);
        whenBtn.tag=101;
        whenBtn.backgroundColor=[UIColor clearColor];
        [whenBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        whenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [whenBtn addTarget:self action:@selector(whenBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:whenBtn];
        
        
        //for Where
        // for where Label
        UILabel *whreLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 145, 70, 30)];
        whreLbl.text=@"Where:";
        [cell1.contentView addSubview:whreLbl];
        
        //For When textField
        wheretextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 145, 180, 30)];
        wheretextField.placeholder=@"Location";
        wheretextField.delegate=self;
        wheretextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:wheretextField];
        
        //For where Btn
        whereBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        whereBtn.frame=CGRectMake(120, 145, 180, 30);
        //whereBtn.tag=102;
        whereBtn.backgroundColor=[UIColor clearColor];
        [whereBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        whereBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [whereBtn addTarget:self action:@selector(whereBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:whereBtn];

        
        
        //for Upload Photos
        // for upload Label
        UILabel *uploadLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 120, 30)];
        uploadLbl.text=@"UploadPhotos:";
        [cell1.contentView addSubview:uploadLbl];
        
        //For When textField
        uploadtextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 190, 100, 30)];
        uploadtextField.placeholder=@"No Files Chosen";
        uploadtextField.delegate=self;
        uploadtextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:uploadtextField];
        
        //For chose Btn
        choseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        choseBtn.frame=CGRectMake(220, 190, 80, 30);
        choseBtn.tag=103;
        choseBtn.backgroundColor=[UIColor clearColor];
        // set the title of the button
        [choseBtn setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        choseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [choseBtn addTarget:self action:@selector(choseBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:choseBtn];
        
        
        
        
        //for USP
        // for usp Label
        UILabel *uspLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 235, 120, 30)];
        uspLbl.text=@"USP:";
        [cell1.contentView addSubview:uspLbl];
        
        // for couple radio button
        btnCouple = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([btnCouple currentImage]==[UIImage imageNamed:@"radio1.png"])
        {
            
        }
        
        else
        {
            [btnCouple setImage:[UIImage imageNamed: @"radio1.png"] forState:UIControlStateNormal];
        }
        btnCouple.frame=CGRectMake(10, 270, 15, 15);
        btnCouple.backgroundColor=[UIColor clearColor];
        //[btnCouple setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        //btnCouple.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btnCouple addTarget:self action:@selector(coupleBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:btnCouple];
        //for couple Label
        UILabel *cplLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 263, 80, 30)];
        cplLbl.text=@"Couple";
        [cell1.contentView addSubview:cplLbl];
        
        // for drink radio button
        btndrink = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([btndrink currentImage]==[UIImage imageNamed:@"radio1.png"])
        {
            
        }
        
        else
        {
            [btndrink setImage:[UIImage imageNamed: @"radio1.png"] forState:UIControlStateNormal];
        }
        btndrink.frame=CGRectMake(100, 270, 15, 15);
        btndrink.backgroundColor=[UIColor clearColor];
        //[btndrink setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        //btndrink.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btndrink addTarget:self action:@selector(drinkBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:btndrink];
        //for dring Label
        UILabel *drnkLbl=[[UILabel alloc]initWithFrame:CGRectMake(120, 263, 80, 30)];
        drnkLbl.text=@"Drink";
        [cell1.contentView addSubview:drnkLbl];

        // for others radio button
        btnother = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([btnother currentImage]==[UIImage imageNamed:@"radio1.png"])
        {
            
        }
        
        else
        {
            [btnother setImage:[UIImage imageNamed: @"radio1.png"] forState:UIControlStateNormal];
        }

        btnother.frame=CGRectMake(170, 270, 15, 15);
        btnother.backgroundColor=[UIColor clearColor];
        //[btnother setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        //btnother.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btnother addTarget:self action:@selector(otherBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:btnother];
        //for other Label
        UILabel *otherLbl=[[UILabel alloc]initWithFrame:CGRectMake(190, 263, 80, 30)];
        otherLbl.text=@"Others";
        [cell1.contentView addSubview:otherLbl];
        
        
        //for Entry
        // for entry terms Label
        UILabel *entryLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 308, 120, 30)];
        entryLbl.text=@"Entry Terms:";
        [cell1.contentView addSubview:entryLbl];
        
        //For Terms textField
        termstextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 308, 180, 30)];
        termstextField.placeholder=@"Terms";
        termstextField.delegate=self;
        termstextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:termstextField];
        
        //For entry Terms Btn
        termsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        termsBtn.frame=CGRectMake(120, 308, 180, 30);
        termsBtn.tag=104;
        termsBtn.backgroundColor=[UIColor clearColor];
        [termsBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        termsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [termsBtn addTarget:self action:@selector(termsBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:termsBtn];
        
        
        //for Contact Person
        // for contact Person Label
        UILabel *contPersonLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 353, 180, 30)];
        contPersonLbl.text=@"Contact Person:";
        [cell1.contentView addSubview:contPersonLbl];
        
        //for nameLabel
        UILabel *nameLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 398, 120, 30)];
        nameLbl.text=@"Name:";
        [cell1.contentView addSubview:nameLbl];
        
        //For name textField
        nametextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 398, 180, 30)];
        nametextField.placeholder=@"Name";
        nametextField.delegate=self;
        nametextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:nametextField];
        
        
        //for DesignationLabel
        UILabel *designationLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 443, 120, 30)];
        designationLbl.text=@"Designation:";
        [cell1.contentView addSubview:designationLbl];
        
        //For DesignationtextField
        desgntextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 443, 180, 30)];
        desgntextField.placeholder=@"Designation";
        desgntextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:desgntextField];
        
        //for PhoneLabel
        UILabel *phoneLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 488, 120, 30)];
        phoneLbl.text=@"Phone:";
        [cell1.contentView addSubview:phoneLbl];
        
        //For DesignationtextField
        phonetextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 488, 180, 30)];
        phonetextField.placeholder=@"Phone";
        phonetextField.delegate=self;
        phonetextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:phonetextField];
        
        
        
        //for PartyTheme
        UILabel *partyThmLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 533, 120, 30)];
        partyThmLbl.text=@"Party Theme:";
        [cell1.contentView addSubview:partyThmLbl];
        
        //For DesignationtextField
        partyThmtextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 533, 180, 30)];
        partyThmtextField.placeholder=@"Bollywood Comercial";
        partyThmtextField.delegate=self;
        partyThmtextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:partyThmtextField];
        
        //For party theme Btn
        partyThemeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        partyThemeBtn.frame=CGRectMake(120, 533, 180, 30);
        partyThemeBtn.tag=105;
        partyThemeBtn.backgroundColor=[UIColor clearColor];
        [partyThemeBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        partyThemeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [partyThemeBtn addTarget:self action:@selector(partyThemeBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:partyThemeBtn];

        
        
        //for Description
        UILabel *desLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 578, 200, 30)];
        desLbl.text=@"Description: (Optional)";
        [cell1.contentView addSubview:desLbl];
        
        //For DesignationtextField
        destextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 613, 290, 80)];
       // destextView.placeholder=@"Max: 100 words";
        destextView.delegate=self;
        destextView.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:destextView];
        
        
        //for Special Deals
        UILabel *speDealsLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 703, 120, 30)];
        speDealsLbl.text=@"Special Deals:";
        [cell1.contentView addSubview:speDealsLbl];
        
        //For Special Deals textField
        specialtextField=[[UITextField alloc]initWithFrame:CGRectMake(120, 703, 180, 30)];
        specialtextField.placeholder=@"Deal Title";
        specialtextField.delegate=self;
        specialtextField.backgroundColor=[UIColor whiteColor];
        [cell1.contentView addSubview:specialtextField];
        
        //For speacial deals Btn
        dealsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dealsBtn.frame=CGRectMake(120, 703, 180, 30);
        dealsBtn.tag=106;
        dealsBtn.backgroundColor=[UIColor clearColor];
        [dealsBtn setImage:[UIImage imageNamed:@"Arrow20x20.png"] forState:UIControlStateNormal];
        dealsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [dealsBtn addTarget:self action:@selector(dealsBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:dealsBtn];
        
        
        
        // for terms and conditions
        btncond = [UIButton buttonWithType:UIButtonTypeCustom];
//        if ([btncond currentImage]==[UIImage imageNamed:@"radio1.png"])
//        {
//            
//        }
//        
//        else
//        {
//            [btncond setImage:[UIImage imageNamed: @"radio1.png"] forState:UIControlStateNormal];
//        }

        btncond.frame=CGRectMake(10, 758, 15, 15);
        btncond.backgroundColor=[UIColor clearColor];
        btncond.tag=1000;
        [btncond setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
       // btncond.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btncond addTarget:self action:@selector(condBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:btncond];
        //for agree Label
        UILabel *agreeLbl=[[UILabel alloc]initWithFrame:CGRectMake(30, 750, 280, 30)];
        agreeLbl.text=@"I agree to the terms & Conditions.";
        [cell1.contentView addSubview:agreeLbl];
        
        
        
        //for card Preview Button
        UIButton *prevBtn=[[UIButton alloc]initWithFrame:CGRectMake(50, 803, 200, 40)];
        prevBtn.backgroundColor=[UIColor colorWithRed:255.0f/255 green:153.0f/255 blue:0.0f/255 alpha:1.0];
        [prevBtn setTitle: @"Card Preview" forState: UIControlStateNormal];
        [prevBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       // [prevBtn setImage:[UIImage imageNamed:@"bookmark_main.png"] forState:UIControlStateNormal];
        //prevBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [prevBtn addTarget:self action:@selector(prevBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [cell1.contentView addSubview:prevBtn];

    
    }
    
    return cell1;
    
    
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
    
    if (textField==titletextField )
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
    else if(textField==typetextField || textField==whentextField || textField==wheretextField || textField==uploadtextField || textField==termstextField || textField==nametextField || textField==desgntextField || textField==phonetextField || textField==partyThmtextField || textField==desgntextField || textField==specialtextField)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.35f];
        CGRect frame = self.view.frame; frame.origin.y = -20;
        [self.view setFrame:frame];
        [UIView commitAnimations];
    }
    else
    {
        // added this line on 02.07.15
        // [textField resignFirstResponder];
    }
    
}






-(IBAction)prevBtnClick:(id)sender
{
    NSLog(@"prevBtnClick");
}
-(IBAction)condBtnClick:(id)sender
{
    if([btncond currentImage]==[UIImage imageNamed:@"radio_checked.png"])
    {
    [btncond setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [btncond setImage:[UIImage imageNamed: @"radio_checked.png"] forState:UIControlStateNormal];
    }

    NSLog(@"condBtnClick");
}
-(IBAction)otherBtnClick:(id)sender
{
    if([btnother currentImage]==[UIImage imageNamed:@"radio_checked.png"])
    {
        [btnother setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [btnother setImage:[UIImage imageNamed: @"radio_checked.png"] forState:UIControlStateNormal];
    }
    NSLog(@"otherBtnClick");
}
-(IBAction)drinkBtnClick:(id)sender
{
    if([btndrink currentImage]==[UIImage imageNamed:@"radio_checked.png"])
    {
        [btndrink setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [btndrink setImage:[UIImage imageNamed: @"radio_checked.png"] forState:UIControlStateNormal];
    }
  NSLog(@"drinkBtnClick");
}
-(IBAction)coupleBtnClick:(id)sender
{
    if([btnCouple currentImage]==[UIImage imageNamed:@"radio_checked.png"])
    {
        [btnCouple setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [btnCouple setImage:[UIImage imageNamed: @"radio_checked.png"] forState:UIControlStateNormal];
    }
  NSLog(@"coupleBtnClick");
}



-(IBAction)typeBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(120.0f, 55.0f, 180.0f, 150.0f)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
    NSLog(@"typeBtnClick");
}
-(IBAction)whenBtnClick:(id)sender
{
    [self datePicker];
    NSLog(@"whenBtnClick");
}
-(IBAction)whereBtnClick:(id)sender
{
    clickedBtn=(UIButton*)sender;
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(120.0f, 145.0f, 180.0f, 150.0f)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    pickerView.backgroundColor=[UIColor whiteColor];
    NSLog(@"whereBtnClick");
}
-(IBAction)choseBtnClick:(id)sender
{
    
    // To create Popup View
    picPopUpView=[[UIView alloc]initWithFrame:CGRectMake(60,120, 200, 150)];
    // popupViewSlide.backgroundColor=[UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0];
    picPopUpView.backgroundColor=[UIColor lightGrayColor];
    
    //To create a Close button.
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(Close) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    closeBtn.layer.masksToBounds=YES;
    closeBtn.layer.cornerRadius=13;
    // [closeBtn setImage:[UIImage imageNamed:@"cancel2.jpg"] forState:UIControlStateNormal];
    closeBtn.backgroundColor= [UIColor grayColor];
    closeBtn.showsTouchWhenHighlighted = YES;
    closeBtn.frame = CGRectMake(185, -8.0, 25.0, 25.0);
    [picPopUpView addSubview:closeBtn];
    
    
    //To create a Choose Photo button.
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn addTarget:self action:@selector(ChoosePhoto) forControlEvents:UIControlEventTouchUpInside];
    [chooseBtn setTitle:@"Choose Photo" forState:UIControlStateNormal];
    //chooseBtn.layer.masksToBounds=YES;
    // chooseBtn.layer.cornerRadius=13;
    //[chooseBtn setImage:[UIImage imageNamed:@"cancel2.jpg"] forState:UIControlStateNormal];
    chooseBtn.backgroundColor= [UIColor redColor];
    chooseBtn.showsTouchWhenHighlighted = YES;
    chooseBtn.frame = CGRectMake(25, 30.0, 150.0, 35.0);
    [picPopUpView addSubview:chooseBtn];
    
    
    //To create a Choose Photo button.
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn addTarget:self action:@selector(Camera) forControlEvents:UIControlEventTouchUpInside];
    [cameraBtn setTitle:@"Camera" forState:UIControlStateNormal];
    //cameraBtn.layer.masksToBounds=YES;
    //cameraBtn.layer.cornerRadius=13;
    //[chooseBtn setImage:[UIImage imageNamed:@"cancel2.jpg"] forState:UIControlStateNormal];
    cameraBtn.backgroundColor= [UIColor redColor];
    cameraBtn.showsTouchWhenHighlighted = YES;
    cameraBtn.frame = CGRectMake(25, 90.0, 150.0, 35.0);
    [picPopUpView addSubview:cameraBtn];
    
    
    [self.view addSubview:picPopUpView];

    
    
    NSLog(@"choseBtnClick");
}
-(IBAction)termsBtnClick:(id)sender
{
   NSLog(@"termsBtnClick");
}
-(IBAction)partyThemeBtnClick:(id)sender
{
    NSLog(@"partyThemeBtnClick");
}
-(IBAction)dealsBtnClick:(id)sender
{
   NSLog(@"dealsBtnClick");
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
    
    
    if (clickedBtn.tag==102)
    {
        return locationArray.count;
        
    }
    else if(clickedBtn.tag==101)
    {
          return locationArray.count;
    }
    else if(clickedBtn.tag==100)
    {
        return typeArray.count;
    }
    else
    {
         return locationArray.count;
    }
   
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (clickedBtn.tag==102)
    {
        return locationArray[row];
        
    }
    
    else if(clickedBtn.tag==101)
    {
        return locationArray[row];
    }
    else if(clickedBtn.tag==100)
    {
        return typeArray[row];
    }
    else
    {
        return locationArray[row];
    }
    //    return adultArray[row];
}


- (void)pickerView:(UIPickerView *)pickerView1 didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (clickedBtn.tag==102)
    {
        //to set the text
        [whentextField setText:[NSString stringWithFormat:@"  %@",[locationArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        whentextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
        
    }
    
    else if(clickedBtn.tag==101)
    {
        //to set the text
        [whentextField setText:[NSString stringWithFormat:@"  %@",[locationArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        whentextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    }
    
    else if(clickedBtn.tag==100)
    {
        //to set the text
        [typetextField setText:[NSString stringWithFormat:@"  %@",[typeArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
        typetextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    }
    else
    {
        
    }
    
    pickerView.hidden=YES;
    
    //    [salutationTextField setText:[NSString stringWithFormat:@"%@",[countryArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    //    salutationPickerView.hidden=YES;
}



-(void)Close
{
    
    [self.view endEditing:YES];
    //    saveBtn.enabled=YES;
    //    cancelBtn.enabled=YES;
    [picPopUpView removeFromSuperview];
    
}

-(void)ChoosePhoto
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
   	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:picker animated:YES completion:nil];
    
    //    saveBtn.enabled=YES;
    //    cancelBtn.enabled=YES;
}

-(void)Camera
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
    
    //    saveBtn.enabled=YES;
    //    cancelBtn.enabled=YES;
    //    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
    //    {
    //        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //        [self presentViewController:picker animated:YES completion:nil];
    //    }
    //    else
    //    {
    //        NSLog(@"Your device is not having camera with itself");
    //        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:@"It seems you are working on Simulator/your device does not support camera" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    //        [av show];
    //    }
    // picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
}

#pragma mark- Delaget method of UImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    selectedImg=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    NSLog(@"selectedImg=%@",selectedImg);
//    picImgView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    
    
    
    
    //To set the image on icon button
//    UIImage *locImg=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    [picBtn setBackgroundImage:locImg forState:UIControlStateNormal];
//    [picBtn setTitle:@"" forState:UIControlStateNormal];
    [picPopUpView removeFromSuperview];
    
}


-(void)datePicker
{
//    pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    
//    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    datePicker.hidden = NO;
//    datePicker.date = [NSDate date];
//    
//    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
//    [pickerToolbar sizeToFit];
//    
//    NSMutableArray *barItems = [[NSMutableArray alloc] init];
//    
//    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    [barItems addObject:flexSpace];
//    
//    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
//    [barItems addObject:doneBtn];
//    
//    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
//    [barItems addObject:cancelBtn];
//    
//    [pickerToolbar setItems:barItems animated:YES];
//    
//    [pickerViewPopup addSubview:pickerToolbar];
//    [pickerViewPopup addSubview:datePicker];
//    [pickerViewPopup showInView:self.view];
//    [pickerViewPopup setBounds:CGRectMake(0,0,320, 464)];
}

-(void)doneButtonPressed:(id)sender
{
//    //Do something here here with the value selected using [pickerView date] to get that value
//    [pickerViewPopup dismissWithClickedButtonIndex:0 animated:YES];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    NSDate *date1;
//    date1  = [datePicker date];
//    whentextField.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date1]];
//    whentextField.font=[UIFont fontWithName:@"Source Sans Pro" size:15];
    
}

-(void)cancelButtonPressed:(id)sender{
   // [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}


@end
