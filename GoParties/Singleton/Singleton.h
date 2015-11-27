//
//  singleton.h
//  singletondemo
//
//  Created by naveen rana on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <UIKit/UIKit.h>

@interface Singleton : NSObject{
	
	

}

+(BOOL)checkinternetconnection;
+(void)showMsgAlert:(NSString *)message;
+(void)connectionErrorMsg;


@end
