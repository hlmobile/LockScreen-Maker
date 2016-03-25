//
//  help.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wallPaperAppDelegate.h"


@interface help : UIViewController<UIWebViewDelegate>  {
	IBOutlet UIWebView *theWebView;
	BOOL isLoad;
}
@property(nonatomic) BOOL isLoad;
@end
