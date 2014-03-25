//
//  RSReadingBoard.h
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSArticle;

@interface RSReadingBoard : UIViewController

@property (nonatomic, strong) RSArticle *article;

/**
 *  Using default xib for initializing a reading board
 *
 *  @return RSReadingBoard instance
 */
+ (instancetype)board;

/**
 *  Using custom xib for initializing a reading board
 *
 *  @param name   Xib name
 *  @param bundle Bundle
 *
 *  @return RSReadingBoard instance
 */
+ (instancetype)boardWithWithNibName:(NSString *)name bundle:(NSBundle *)bundle;

@end
