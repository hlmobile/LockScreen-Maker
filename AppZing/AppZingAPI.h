//
//  AppzingAPI.h
//  AppzingTouch
//
//  Created by bwheeler@saucetank.com on 2/26/10.
//  Copyright 2010 Appzing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppzingDelegate.h"

@interface AppzingAPI : NSObject {
	
	NSString *appId;
	NSString *bannerId;
	NSString *storeLink;
	
}

+ (void)showZing:(NSString *)appId;
+ (void)showZing:(NSString *)appId zingDelegate:(id<AppzingDelegate>)newZingDelegate;

- (id)initWithAppId:(NSString *)newAppId;

- (void)loadZing;

@property(copy) NSString *appId;
@property(copy) NSString *bannerId;
@property(copy) NSString *storeLink;

@end
