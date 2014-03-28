//
//  RSReadingBoard.m
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSReadingBoard.h"

#import "RSArticle.h"

// https://github.com/yeahdongcn/RSImageFitness
#import "UIImage+Fitness.h"

@interface RSReadingBoard ()

@property (nonatomic, weak) IBOutlet UIScrollView *vContent;

@property (nonatomic, weak) IBOutlet UIImageView  *ivImage;

@property (nonatomic, weak) IBOutlet UIView       *vColor;

@property (nonatomic, weak) IBOutlet UILabel      *lTitle;

@property (nonatomic, weak) IBOutlet UILabel      *lSource;

@property (nonatomic, weak) IBOutlet UILabel      *lDate;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTop;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTrailing;

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
    
    /**
     *  @NOTE: Turn off automatically adjusts scroll view insets in xib or here
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setArticle:(RSArticle *)article
{
    _article = article;
    
    if (article.image) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [article.image imageWithNewSize:CGSizeMake(self.lcivImageWidth.constant, self.lcivImageHeight.constant)];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ivImage.image = image;
            });
        });
    } else {
        self.lcivImageHeight.constant = 0;
    }
    self.lTitle.text = article.title;
    self.lSource.text = article.source;
    self.lDate.text = article.date;
    self.vColor.backgroundColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0f) green:(arc4random() % 256 / 255.0f) blue:(arc4random() % 256 / 255.0f) alpha:1.0f];
}

@end
