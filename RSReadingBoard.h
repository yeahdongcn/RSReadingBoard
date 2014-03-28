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
 *  Body text view background color
 */
@property (nonatomic, strong) UIColor *bodyBackgroundColor; // default is clear color

/**
 *  Body text view text color
 */
@property (nonatomic, strong) UIColor *bodyTextColor; // default is dark gray color

/**
 *  Body text view font
 */
@property (nonatomic, strong) UIFont  *bodyFont; // default is body font

/**
 *  Model object
 */
@property (nonatomic, strong) RSArticle *article;

/**
 *  Insets which controls the content area exclude the headline image
 */
@property (nonatomic) UIEdgeInsets contentInsets; // default is UIEdgeInsetsMake(20, 20, 20, 20)

/**
 *  Color view width layout constraint
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcvColorWidth; // default is 5

/**
 *  Horizontal space between color view and title label
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lchorizontalSpaceBetweenvColorlTitle; // default is 5

/**
 *  Horizontal space between source label and date label
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lchorizontalSpaceBetweenlSourcelDate; // default is 10

/**
 *  Vertical space between title label and source label & date label
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcVerticalSpaceBetweenlTitlelSource; // default is 10

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
