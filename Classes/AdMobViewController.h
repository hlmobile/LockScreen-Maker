//
//  AdMobViewController.h
//  wallPaper
//
//  Created by David Snider on 10/23/10.
//  Copyright 2010 Midnight Magic Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMobView.h"
#import "AdMobDelegateProtocol.h"



@interface AdMobViewController : UIViewController < AdMobDelegate> {

	
// for AdMob ads
    UIView      *adContainerView;
    AdMobView   *adMobView;
    NSTimer     *refreshTimer;			// still needed??
	

}


- (NSString *)publisherIdForAd:(AdMobView *)adView;
- (UIViewController *)currentViewControllerForAd:(AdMobView *)adView;


- (void) setUpAdMobAd;
- (void) moveAdMobAbove1Tabbar;
- (void) moveAdMobAbove2Tabbars;
- (void) hideAdMob;


@end
