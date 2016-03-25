//
//  JKCustomAlert.h
//  CustomAlert
//
//  Created by Joris Kluivers on 4/2/09.
//  Copyright 2009 Tarento Software Solutions & Projects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JKCustomAlert : UIAlertView {
	//UILabel *alertTextLabel;
	UITextView *alertTextLabel;
	UIImage *backgroundImage;
	UIButton *btnCross;
}

@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) NSString *alertText;

- (id) initWithImage:(UIImage *)image text:(NSString *)text xposition:(float)xpos yposition:(float)ypos direction:(NSString *)upordown;
-(IBAction)crossTooltip:(id)sender;
@end
