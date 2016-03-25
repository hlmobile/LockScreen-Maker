//
//  AppzingDelegate.h
//  AppzingAPI - Appzing library
//	The Appzing delegate to provide info on appzing status.
//  Created by bwheeler@saucetank.com on 2/26/10.
//  Copyright 2010 Appzing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppzingAPI;

@protocol AppzingDelegate<NSObject>

@optional
//notification that the zing was loaded
- (void)didLoadZing:(AppzingAPI *)appzing;

//notification that the zing was not loaded
- (void)didNotLoadZing:(AppzingAPI *)appzing;

//notification that the zing ok was clicked
- (void)didAcceptZing:(AppzingAPI *)appzing;

//notification that the zing no thanks was clicked
- (void)didNotAcceptZing:(AppzingAPI *)appzing;

@end
