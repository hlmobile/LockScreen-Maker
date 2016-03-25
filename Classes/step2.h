//
//  step2.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface step2 : UIViewController<UIAlertViewDelegate> {
	NSMutableArray *dataArray;
	NSMutableArray *imageArray;
	IBOutlet UITableView *theTableView;
	IBOutlet UIImageView *theImageView;
	IBOutlet UIImageView *theImageView2;
}
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableviewCellWithReuseIdentifier:(NSString *)identifier withIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) NSMutableArray *imageArray;
@end
