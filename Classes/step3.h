//
//  step3.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "wallPaperAppDelegate.h"
@class HFViewController;

@interface step3 : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate> {
	UIImage *newImageFinal;
	BOOL isGridShown;
	IBOutlet UIImageView *thebackGroundImageView;
	IBOutlet UIImageView *theIconImageView;
	IBOutlet UIImageView *theEffectView;
	UIImage *backImage;
	UIImage *effecteffectImage;
	UIImage *backgroundFrame;
	BOOL isProcessing;
	NSMutableArray *theBackgroundList;
	NSMutableArray *theEffectList;
	
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HFViewController *rootViewController;

@property (nonatomic) BOOL isProcessing;
@property (nonatomic) BOOL isGridShown;
-(IBAction)diceButtonPressed:(id)sender; 
-(IBAction)actionButtonPressed:(id)sender; 
-(IBAction)randomButton_Clicked;
@property(retain,nonatomic) NSMutableArray *theBackgroundList;
@property(retain,nonatomic) NSMutableArray *theEffectList;
@property(retain,nonatomic) UIImage *newImageFinal;
@property(retain,nonatomic) UIImage *backImage;
@property(retain,nonatomic) UIImage *effecteffectImage;
@end
