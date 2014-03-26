//
//  RSReadingBoard.m
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSReadingBoard.h"

#import "RSArticle.h"

@interface RSReadingBoard ()

@property (nonatomic, weak) IBOutlet UIScrollView *vContent;

@property (nonatomic, weak) IBOutlet UIImageView  *ivImage;

@property (nonatomic, weak) IBOutlet UIView       *vColor;

@property (nonatomic, weak) IBOutlet UILabel      *lTitle;

@property (nonatomic, weak) IBOutlet UILabel      *lSource;

@property (nonatomic, weak) IBOutlet UILabel      *lDate;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTop;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTrailing;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcVerticalSpace;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lchorizontalSpace;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageWidth;

/**
 *  Constraint which controls whether to show this image view
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageHeight;

/**
 *  Constraint which controls the scrollview's contentSize->width
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageTrailing;

/**
 *  Constraint which controls the scrollview's contentSize->height
 */
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageBottom;

@end

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (false)
#endif

@implementation RSReadingBoard

static NSString *const kReadingBoardNib_iPhone = @"RSReadingBoard_iPhone";
static NSString *const kReadingBoardNib_iPad   = @"RSReadingBoard_iPad";

+ (instancetype)board
{
    NSString *name = kReadingBoardNib_iPhone;
    if (IS_IPAD()) {
        name = kReadingBoardNib_iPad;
    }
    return [self boardWithWithNibName:name bundle:[NSBundle mainBundle]];
}

+ (instancetype)boardWithWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    return [[bundle loadNibNamed:name owner:nil options:nil] firstObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIView *subview in self.vContent.subviews) {
        subview.layer.borderWidth = 1.0f;
    }
}

- (void)setArticle:(RSArticle *)article
{
    _article = article;
    
    self.lTitle.text = article.title;
    self.lSource.text = article.source;
    self.lDate.text = article.date;
}

@end
