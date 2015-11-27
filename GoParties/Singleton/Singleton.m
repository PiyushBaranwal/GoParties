//
//  singleton.m
//  singletondemo
//
//  Created by naveen rana on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation Singleton

static Singleton * sharedinstance = nil;

+(Singleton *)sharedmysingleton
{
	@synchronized(self)
	{
		if (sharedinstance==nil)
			[[self alloc] init];
		return sharedinstance;
	}	
	return nil;
}

+(id)alloc
{
	@synchronized(self)
	{
		NSAssert(sharedinstance == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedinstance = [super alloc];
		return sharedinstance;
	}
	
	return nil;
}

-(id)init {
	self = [super init];
	
	if (self != nil) {
		// initialize stuff here
	}
	return self;
}
- (void) refresh {
    [sharedinstance release];
    sharedinstance = nil;
    
}


#pragma mark check internet connection
+(BOOL)checkinternetconnection
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
	Reachability* reachabilityconn = [Reachability reachabilityForInternetConnection];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];	
	NetworkStatus connstatus=[reachabilityconn currentReachabilityStatus];
	
    
	if((remoteHostStatus == NotReachable)||(connstatus == NotReachable))
	{
		NSLog(@"Connnection Error");
		return NO;
	}
    return YES;
}


+(void)showMsgAlert:(NSString *)message
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
}

+(void)connectionErrorMsg
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error in Connection" message:@"Please check your Internet Connection !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}



@end