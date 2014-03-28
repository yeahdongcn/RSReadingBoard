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

/**
 *  Model object
 */
@property (nonatomic, strong) RSArticle *article;

/**
 *  Insets which controls the content area exclude the headline image
 */
@property (nonatomic) UIEdgeInsets contentInsets;

/**
 *  Horizontal space between source label and date label
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lchorizontalSpace;

/**
 *  Vertical space between title label and source label & date label
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcVerticalSpace;

/**
 *  Headline image width layout constraint
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageWidth;

/**
 *  Headline image height layout constraint
 */
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
