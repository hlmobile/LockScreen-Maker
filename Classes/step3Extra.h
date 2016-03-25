//
//  step3Extra.h
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 9/1/10.
//  Copyright 2010 Prolog Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface step3Extra : UIViewController {

}
-(void)reset;
-(void)isLoadedActionTotal;
-(void)setImage:(UIImage*) imageEffect withBack:(UIImage*) backgroundImage;
-(CGRect)getBackgroundFrame;
-(UIImage*)getBackgroundImage;
-(UIImage*)getEffectImage;
-(void)setBackgroundImage;
-(void)setEffectImage;

@end
