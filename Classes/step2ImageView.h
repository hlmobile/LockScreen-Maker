//
//  step2ImageView.h
//  wallPaper
//
//  Created by Tithy on 8/27/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wallPaperAppDelegate.h"

@interface step2ImageView : UIViewController<UIAlertViewDelegate> {

	IBOutlet UIImageView *thebackGroundImageView;
	IBOutlet UIImageView *theEffectImageViewForAnimation;
	IBOutlet UIImageView *theEffectImageView;
	IBOutlet UIImageView *theIconImageView;
	IBOutlet UIToolbar *theToolBar;
	int section;
	NSArray *cellArray;
	int imageIndex;
	BOOL isShow;
	wallPaperAppDelegate *appDelegate;
	CGPoint prevTouchPoint;
	NSString *pathForRes;
	BOOL isprocessing;
}
-(void)reset;
-(CGRect)theBackGroundFrame;
-(UIImage*)theBackGroundImage;
-(UIImage*)theEffectImage;
-(void)gotoFirstScreen;
-(void)isLoadedActionTotal;
-(void)isLoadedAction;
-(UIImage*)getImage;
-(void)setImage:(UIImage*) imageEffect withBack:(UIImage*) backgroundImage;
-(void)randomButton_Clicked;
@property (nonatomic,retain)NSString *pathForRes;
@property (nonatomic,retain)NSArray *cellArray;
@property (nonatomic) int section;
@property (nonatomic) BOOL isShow;
@property (nonatomic) BOOL isprocessing;
@property (nonatomic) int imageIndex;
@property (nonatomic)CGPoint prevTouchPoint;
-(IBAction)nextButtonPressed:(id)sender; 
-(IBAction)arevButtonPressed:(id)sender; 
-(IBAction)diceButtonPressed:(id)sender; 
-(IBAction)actionButtonPressed:(id)sender; 
-(IBAction)randomButton_Clicked;
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
@end
