//
//  main.m
//  wallPaper
//
//  Created by Shaestagir Chowdhury on 8/26/10.
//  Copyright Prolog Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "general.h"

int main(int argc, char *argv[]) {
    
    d_width = 320.0;
    d_height = 480.0;
    i_width = 320.0;
    i_height = 568.0;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}




