//
//  wallPaperAppDelegate.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright Prolog Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
#import "AdMobViewController.h"
#import "AppzingDelegate.h"


@interface wallPaperAppDelegate : NSObject <UIApplicationDelegate>
//#ifdef APP_ZING_APP_ID
// AppzingDelegate
//#endif

{
    
    UIWindow *window;
    UINavigationController *navigationController;
	UITabBarController *tabBarController;
    UITabBarController *tabBarController1;
    UITabBarController *tabBarController2;
	AdMobViewController *vcForAdMob;

	UILabel *myTestLabel;
	
	BOOL isGridShown;
	NSString *theBackGroundImagePath;
	UIImage *theBackGroundImage;
	UIImage *theEffectImage;
	CGRect theBackGroundFrame;
	UIImage *finalImage;
	BOOL isBackLoaded;
	BOOL isEffectLoaded;
	BOOL isResetForStep1;
	BOOL isResetForStep2;
	NSURL           *nagITunesStoreURL;
	BOOL                         isPlayingMovie;
	BOOL        isLoggedIn;
    //ListItem					*promoPageURL;
	ListItem                    *nagTextURL;
	NSMutableDictionary *savedPhotoParamsDictionary;
	
		
}

- (void) moveTheAdAbove1Tabbar;
- (void) moveTheAdAbove2Tabbars;
- (void) hideTheAdLabel;



@property (nonatomic, retain) NSMutableDictionary *savedPhotoParamsDictionary;

@property (nonatomic)BOOL isResetForStep1;
@property (nonatomic)BOOL isResetForStep2;
@property (nonatomic)BOOL isBackLoaded;
@property (nonatomic)BOOL isEffectLoaded;
@property (nonatomic) CGRect theBackGroundFrame;
@property (nonatomic) CGRect theEffectFrame;
@property (nonatomic) BOOL isGridShown;
@property (nonatomic) BOOL isLoggedIn;
@property (nonatomic, retain) NSString *theBackGroundImagePath;
@property (nonatomic, retain) UIImage *theBackGroundImage;
@property (nonatomic, retain) UIImage *theEffectImage;
@property (nonatomic, retain) UIImage *finalImage;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController1;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController2;
//@property (nonatomic, retain)	ListItem		*promoPageURL;
@property (nonatomic, retain)	ListItem		*nagTextURL;
@property (nonatomic, retain)	NSURL           *nagITunesStoreURL;

@property (nonatomic, retain) AdMobViewController * vcForAdMob;



@end

