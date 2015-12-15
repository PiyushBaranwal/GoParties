//
//  LocationViewController.m
//  GoParties
//
//  Created by GoParties on 15/12/15.
//  Copyright © 2015 GoParties. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize locationTableView,myMapView;

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
    
    
    return 200*5;
    
    
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
        UIView *myfeedBackView=[[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 600)];
        myfeedBackView.backgroundColor=[UIColor clearColor];
        [cell1.contentView addSubview:myfeedBackView];
        
        
        // party profile name label
        UILabel *partyProfileNameLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 30)];
        partyProfileNameLbl.text=@"Underdoggs-The Sports Bar & Grill";
        partyProfileNameLbl.font=[UIFont systemFontOfSize:20];
        [myfeedBackView addSubview:partyProfileNameLbl];
        
        // for divider
        UILabel *dividerLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, self.view.frame.size.width-20, 1)];
        dividerLbl.backgroundColor=[UIColor grayColor];
        [cell1.contentView addSubview:dividerLbl];
        
        // Party Address label
        UILabel *partyAddLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, self.view.frame.size.width-20, 80)];
        partyAddLbl.numberOfLines=3;
        partyAddLbl.text=@"Golf Course Road, Next to some Mercedes Showroom, DLF Phase 1, Gurgaon";
        [cell1.contentView addSubview:partyAddLbl];
        
        // for map view
        // For map view
        myMapView=[[MKMapView alloc]initWithFrame:CGRectMake(10, 140, 355, 400)];
        myMapView.delegate = self;
        [myMapView setMapType:MKMapTypeStandard];
        [cell1.contentView addSubview:myMapView];
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=2.30;
        span.longitudeDelta=2.30;
        region.center = CLLocationCoordinate2DMake(46, 2);
        
        
        
        //region.span = span;
        region.center = location;
        //Lat and Long of Muscat,Oman
        location.latitude  =28.465045; //23.629745;////23.614328    23.621799,58.491452
        location.longitude =77.100712; //58.494404;// //58.545284  //+ 23.5833453 + "," + 58.4236662
        
        mapPoint = [[PlacePin alloc] initWithLocation:location];
        //mapPoint.nTag = i;
        //[mapPoint setTitle:@"    The Jungle"];
        
        //    MKAnnotationView* annotationView = [myMapView viewForAnnotation:mapPoint];
        //    annotationView.canShowCallout = NO;
        [myMapView addAnnotation:mapPoint];
        mapPoint = nil;
        //[myMapView setRegion:region animated:YES];
        [myMapView regionThatFits:region];
        [self zoomToFitMapAnnotations:myMapView];
        //To initialize
        locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];

        
    
        
        
    }
    return cell1;
    
    
}



#pragma mark Delegate Methods




- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        NSLog(@"longitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"Latitude=%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            
            NSLog(@"Address=%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country]);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    //    //URL to get the path using source and destination lat lon....
    //    NSString *googleMapUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%@,%@&daddr=%f,%f", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude], [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude], location.latitude,location.longitude];
    
    
    NSString* address = @"Qurm, Muscat, Oman";
    //URL to get the path using source and destination lat lon....
    NSString *googleMapUrlString = [NSString stringWithFormat:@"http:/maps.google.com/?saddr=%@,%@&daddr=%@",[NSString stringWithFormat:@"%.6f", currentLocation.coordinate.latitude], [NSString stringWithFormat:@"%.6f", currentLocation.coordinate.longitude],[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"googleMapUrlString=%@",googleMapUrlString);
    
    
    
    //     NSString *googleMapUrlString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%f,%f&daddr=%f,%f", 28.59480624, 77.32000490, 28.612896200000000000,77.229449800000000000];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapUrlString]];
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    control.hidden=YES;
    //    [Utils startActivityIndicatorInView:self.view withMessage:@"Loading"];
    // Calling the Webservice.
    // [self performSelector:@selector(callingWebServForFriendProfileInfoOnMap) withObject:nil afterDelay:.3];
    
    //[self nearbyFrndDetailPopupView];
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKAnnotationView* annotationView = [mapView viewForAnnotation:userLocation];
    annotationView.canShowCallout = NO;
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    MKPinAnnotationView *pinView = nil;
    if(annotation != myMapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        pinView.pinColor = MKPinAnnotationColorRed;
        //To show the flag on pin click
        pinView.canShowCallout = YES;
        //To animate the pin on map view
        pinView.animatesDrop = YES;
        //to set teh right button of the popup comes on pin clcik on map view
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pinView.rightCalloutAccessoryView = rightButton;
    }
    else {
        [mapView.userLocation setTitle:@"I am here"];
    }
    
    
    pinView.image = nil;
    dispatch_queue_t queue = dispatch_queue_create("com.aroundme.mapannotationimage", NULL);
    
    dispatch_async(queue, ^{
        NSInteger index = [(PlacePin*)annotation nTag];
        NSLog(@"Load Image for Index : %ld", index);
        
        @try
        {
            // [self loadImageUrl:userImgArray[index] onMapAnnotation:pinView];
        }
        @catch (NSException *exception)
        {
            //[self loadImageUrl:userImgArray[0] onMapAnnotation:pinView];
            
        }
        
    });
    
    pinView.annotation = annotation;
    return pinView;
    
    
}

#pragma mark Zoom

- (IBAction)zoomToCurrentLocation:(UIBarButtonItem *)sender
{
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.myMapView.userLocation.coordinate.latitude;
    region.center.longitude = self.myMapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.myMapView setRegion:region animated:YES];
}




-(void)zoomToFitMapAnnotations:(MKMapView*)mv
{
    if([mv.annotations count] == 0)
        return;
    
    if([mv.annotations count] == 1) {
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=1.30;
        span.longitudeDelta=1.30;
        
        for(PlacePin* annotation in mv.annotations){
            
            CLLocationCoordinate2D location1;
            location1.latitude = annotation.coordinate.latitude;
            location1.longitude = annotation.coordinate.longitude;
            region.span=span;
            region.center=location1;
            
            [mv setRegion:region animated:TRUE];
            [mv regionThatFits:region];
            
        }
        
        
    }
    else
    {
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        topLeftCoord.longitude = 180;
        
        CLLocationCoordinate2D bottomRightCoord;
        bottomRightCoord.latitude = 90;
        bottomRightCoord.longitude = -180;
        
        for(PlacePin* annotation in mv.annotations)
        {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        }
        
        MKCoordinateRegion region;
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
        
        region = [mv regionThatFits:region];
        [mv setRegion:region animated:YES];
        
    }
    
}


@end
