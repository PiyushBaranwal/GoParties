//
//  PhotosViewController.m
//  GoParties
//
//  Created by GoParties on 14/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

//to get the modulo functionality.
#import  <tgmath.h>
#import "PhotosViewController.h"

#import "Utils.h"
#import "SBJSON.h"
#import "Singleton.h"

#import "FXImageView.h"

#import "UIImageView+WebCache.h"


@interface PhotosViewController ()

@end

@implementation PhotosViewController
@synthesize imgView,carousel,photoTableView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"PHOTO", nil);
    //To change the navigation title bar color
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName]];
    
    // Do any additional setup after loading the view from its nib.
    carousel.hidden=YES;
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
    int rem=thumbImgArray.count % 2;
    
    if (rem==1)
    {
        return (thumbImgArray.count/3)*100+180;//1500
    }
    else
    {
        return (thumbImgArray.count/3)*100+160;//1500
    }
    // return (thumbImgArray.count/2)*100+160;//1500
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        cell1 = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row==0)
    {
        NSInteger a=0;
        for (int i=0; i<thumbImgArray.count; i++)
        {
            
            // first row-  first cell of first column
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:[thumbImgArray objectAtIndex:i]
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     // progression tracking code
                                 }
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                    if (image)
                                    {
                                        UIButton *cellBtn1=[[UIButton alloc]initWithFrame:CGRectMake(11, 10+a, 92, 92)];//5, 5+a, 152, 100
                                        cellBtn1.backgroundColor=[UIColor grayColor];
                                        [cellBtn1 setImage:image forState:UIControlStateNormal];
                                        // [cellBtn1 setBackgroundImage:image forState:UIControlStateNormal];
                                        cellBtn1.tag=i;
                                        [cellBtn1 addTarget:self action:@selector(cellBtnClick:)forControlEvents:UIControlEventTouchUpInside];
                                        [cell1.contentView addSubview:cellBtn1];
                                    }
                                }];
            
            
            if (i+2>=thumbImgArray.count)
            {
                
            }
            else
            {
                // first row-  second cell of second column
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:[thumbImgArray objectAtIndex:i+1]
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if (image)
                                        {
                                            UIButton *cellBtn1=[[UIButton alloc]initWithFrame:CGRectMake(114, 10+a, 92, 92)];//162, 5+a, 152, 100
                                            cellBtn1.backgroundColor=[UIColor grayColor];
                                            [cellBtn1 setImage:image forState:UIControlStateNormal];
                                            // [cellBtn1 setBackgroundImage:image forState:UIControlStateNormal];
                                            cellBtn1.tag=i+1;
                                            [cellBtn1 addTarget:self action:@selector(cellBtnClick:)forControlEvents:UIControlEventTouchUpInside];
                                            [cell1.contentView addSubview:cellBtn1];
                                        }
                                    }];
                
                // first row-  third cell of third column
                [manager downloadImageWithURL:[thumbImgArray objectAtIndex:i+2]
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if (image)
                                        {
                                            UIButton *cellBtn1=[[UIButton alloc]initWithFrame:CGRectMake(217, 10+a, 92, 92)];//162, 5+a, 152, 100
                                            cellBtn1.backgroundColor=[UIColor grayColor];
                                            [cellBtn1 setImage:image forState:UIControlStateNormal];
                                            // [cellBtn1 setBackgroundImage:image forState:UIControlStateNormal];
                                            cellBtn1.tag=i+2;
                                            [cellBtn1 addTarget:self action:@selector(cellBtnClick:)forControlEvents:UIControlEventTouchUpInside];
                                            [cell1.contentView addSubview:cellBtn1];
                                        }
                                    }];
            }
            
            
            a=a+105;
            i=i+2;
        }
    }
    return cell1;
}


-(IBAction)cellBtnClick:(id)sender
{
    //clickedImgView.image=nil;
    
    UIButton *btn=(UIButton *)sender;
    NSLog(@"button with tag=%ld clicked",(long)btn.tag);
    
    
    // [Utils startActivityIndicatorInView:self.view withMessage:@"Loading..."];
    selectedImgInd=btn.tag;
    
    
    carousel.hidden=NO;
    carousel.delegate=self;
    carousel.dataSource=self;
    carousel.type = iCarouselTypeLinear;//iCarouselTypeRotary
    carousel.currentItemIndex=selectedImgInd;
    //[carousel setAutoscroll:1.00];//0.10
    //carousel.scrollSpeed=10;
    self.carousel.clipsToBounds = YES;
    carousel.pagingEnabled = YES;
    //carousel.scrollToItemBoundary=YES;
    carousel.centerItemWhenSelected=YES;
    
    
    
    //    // KASlideshow
    //    slideshow.hidden=NO;
    //    slideshow.delegate = self;
    //   // slideshow.dataSource=self;
    //    [slideshow setDelay:1]; // Delay between transitions
    //    [slideshow setTransitionDuration:.5]; // Transition duration
    //    [slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
    //    [slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    //   [slideshow addImagesFromURLs:oriImgArray];
    //   //[slideshow addImagesFromURLs:oriImgArray SelectedPosition:selectedImgInd];
    //
    //  // [slideshow addImage:[oriImgArray objectAtIndex:selectedImgInd]];
    //    [slideshow addGesture:KASlideShowGestureAll];
    
    
    
    //To hide the buttons and view
    self.photoTableView.hidden=YES;
    
    
    
    //For ViewMore Button
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"X" forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor grayColor]];
    cancelBtn.frame = CGRectMake(140, 425, 40, 40);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    //self.view.backgroundColor=[UIColor blackColor];
    // self.galTableView.backgroundColor=[UIColor blackColor];
    [Utils stopActivityIndicatorInView: self.view];
}


#pragma -Mark
#pragma -mark NSURLConnection delagate methods

-(void)CallingGalleryWebservice
{
    //To check Internet connection
    BOOL checkConn=[Singleton checkinternetconnection];
    if(checkConn)
    {
        NSString *urlAsString;
        urlAsString=[NSString stringWithFormat:@"http://dunesbyalnahda.com/servicecenter/gallery-images"];
        NSLog(@"%@", urlAsString);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlAsString]];
        conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (conn)
        {
            // webData=[NSMutableData data];
            webData=[[NSMutableData alloc]init];
        }
    }
    else
    {
        [Singleton connectionErrorMsg];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"String is=%@",returnString);
    if (webData != nil)
    {
        [webData appendData:data];
    }
    else
    {
        webData = [[NSMutableData alloc] initWithData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString1 = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSError *error;
    SBJSON *json = [SBJSON new];
    NSArray *webResforconnection = [json objectWithString:responseString1 error:&error];
    NSLog(@"webResforconnection=%@",webResforconnection);
    NSArray *jsonDataArray = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingMutableContainers error:&error];
    
    for (int i=0 ; i<jsonDataArray.count ; i++)
    {
        thumbImgArray=[jsonDataArray valueForKey:@"thumb_image" ];
        oriImgArray=[jsonDataArray valueForKey:@"ori_image"];
    }
    NSLog(@"thumbImgArray=%@",thumbImgArray);
    NSLog(@"oriImgArray=%@",oriImgArray);
    
    //  [self.collectionViewPack reloadData];
    
    [self.photoTableView reloadData];
    
    
    
    ///////////----------------------------------------------
    
    ///////////----------------------------------------------
    
    [Utils stopActivityIndicatorInView:self.view];
}



#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [oriImgArray count];//oriImgArray
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //galImageView.image=nil;
    // galImageView=nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:self.carousel.bounds];
        galImageView = [[UIImageView alloc] initWithFrame:view.bounds];
        galImageView.backgroundColor=[UIColor grayColor];
        galImageView.tag = 1;
        [view addSubview:galImageView];
    }
    else
    {
        //get a reference to the label in the recycled view
        galImageView = (UIImageView *)[view viewWithTag:1];
    }
    
    // galImageView.image=[UIImage imageNamed:@"placeholder.png"];
    [Utils startActivityIndicatorInView:galImageView withMessage:@"Loading..."];
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    [galImageView sd_setImageWithURL:[NSURL URLWithString:[oriImgArray objectAtIndex:index]]
                    placeholderImage:[UIImage imageNamed:@""]]; //placeholder.png
    [Utils stopActivityIndicatorInView:galImageView];
    
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
    //        NSURL *urlForImage = [NSURL URLWithString:[oriImgArray objectAtIndex:index]];
    //
    //        NSData *data0 = [NSData dataWithContentsOfURL:urlForImage];
    //        UIImage *image = [UIImage imageWithData:data0];
    //
    //        dispatch_sync(dispatch_get_main_queue(), ^(void) {
    //
    ////            for (int i=0; i<oriImgArray.count; i++)
    ////            {
    ////                galImageView=(UIImageView *)[view  viewWithTag:1];//101
    ////                galImageView.image = image;
    ////
    ////            }
    //
    //
    //            if (data0)
    //            {
    //                galImageView=(UIImageView *)[view  viewWithTag:1];//101
    //                galImageView.image = image;
    //                [Utils stopActivityIndicatorInView:galImageView];
    //            }
    //            else
    //            {
    //             // [Utils stopActivityIndicatorInView:galImageView];
    //            }
    //
    //        });
    //    });
    
    
    // [Utils stopActivityIndicatorInView:self.view];
    // galImageView.image=[UIImage imageNamed:[galleryImages objectAtIndex:index]];
    return view;
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    
    // clickedImgView.hidden=YES;
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark - Button Clicks

-(IBAction)cancelBtnClick:(id)sender
{
    carousel.hidden=YES;
    // slideshow.hidden=YES;
    // [galImageView removeFromSuperview];
    self.photoTableView.hidden=NO;
    //self.collectionViewPack.hidden=NO;
    cancelBtn.hidden=YES;
    //clickedImgView.hidden=YES;
    [Utils stopActivityIndicatorInView:self.view];
}



- (IBAction)homeBtnClick:(id)sender
{
    
}
- (IBAction)myProfileBtnClick:(id)sender
{
    
}
- (IBAction)myPartiesBtnClick:(id)sender
{
    
}
- (IBAction)myDealsBtnClick:(id)sender
{
    
}
- (IBAction)accessBtnClick:(id)sender
{
    
}


@end
