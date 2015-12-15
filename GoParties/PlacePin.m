//
//  PlacePin.m
//  LinkIn
//
//  Created by Piyush Baranwal on 19/09/14.
//  Copyright (c) 2014 BlueApple. All rights reserved.
//

#import "PlacePin.h"

@implementation PlacePin

@synthesize coordinate,title,subtitle;
@synthesize nTag;

- (id)initWithLocation:(CLLocationCoordinate2D)coord{
    
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}


@end