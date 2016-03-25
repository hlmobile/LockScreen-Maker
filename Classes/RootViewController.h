//
//  RootViewController.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright Prolog Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	IBOutlet UIToolbar   *extraToolbar;
	IBOutlet UITableView *theTableView;
	IBOutlet UIImageView *theImageViewBackGround;
	IBOutlet UIImageView *theImageViewEffect;
	IBOutlet UIImageView *theImageViewIconView;
	
	UIImage *backgroundImage;
	UIImage *effectImage;
	UIImage *iconImage;
	UIImage *finalImage;
}

@end
