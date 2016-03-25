//
//  step1.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface step1 : UIViewController<UIAlertViewDelegate> {
	NSArray *dataArray;
	NSMutableArray *imageArray;
	IBOutlet UITableView *theTableView;
	IBOutlet UIImageView *theImageView;
}
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableviewCellWithReuseIdentifier:(NSString *)identifier withIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,retain) NSArray *dataArray;
@property (nonatomic,retain) NSMutableArray *imageArray;
@end
