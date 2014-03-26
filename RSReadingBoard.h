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

@property (nonatomic) UIEdgeInsets contentInsets;


@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcVerticalSpace;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lchorizontalSpace;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageWidth;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageHeight;


/**
 *  Using default xib and bundle for initializing a reading board
 *
 *  @return RSReadingBoard instance
 */
+ (instancetype)board;

/**
 *  Using custom xib for initializing a reading board
 *
 *  @param name   Xib name
 *  @param bundle Which bundle the xib file lives
 *
 *  @return RSReadingBoard instance
 */
+ (instancetype)boardWithWithNibName:(NSString *)name bundle:(NSBundle *)bundle;

@end
