//
//  RSReadingBoard.m
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "RSReadingBoard.h"

#import "RSArticle.h"

typedef NS_ENUM(NSUInteger, RSHorizontalAlignment) {
    RSHorizontalAlignmentCenter = 0,
    RSHorizontalAlignmentLeft,
    RSHorizontalAlignmentRight,
};

typedef NS_ENUM(NSUInteger, RSVerticalAlignment) {
    RSVerticalAlignmentCenter = 0,
    RSVerticalAlignmentTop,
    RSVerticalAlignmentBottom,
};

@interface UIImage (Fitness)

- (UIImage *)imageWithNewSize:(CGSize)newSize
          horizontalAlignment:(RSHorizontalAlignment)horizontalAlignment
            verticalAlignment:(RSVerticalAlignment)verticalAlignment
                        scale:(CGFloat)scale;

/**
 *  Create a new UIImage instance if its size NOT equals to the give size,
 *  otherwise retrun the unchanged self.
 *  NOTE this function use RSHorizontalAlignmentCenter, RSVerticalAlignmentTop
 *  and current screen scale.
 *
 *  @param newSize The given size.
 *
 *  @return UIImage instance.
 */
- (UIImage *)imageWithNewSize:(CGSize)newSize;

@end

@implementation UIImage (Fitness)

- (UIImage *)imageWithNewSize:(CGSize)newSize
          horizontalAlignment:(RSHorizontalAlignment)horizontalAlignment
            verticalAlignment:(RSVerticalAlignment)verticalAlignment
                        scale:(CGFloat)scale
{
    if (CGSizeEqualToSize(self.size, newSize) == NO) {
        CGFloat sourceWidth    = self.size.width;
        CGFloat sourceHeight   = self.size.height;
        CGFloat targetWidth    = newSize.width;
        CGFloat targetHeight   = newSize.height;
        CGFloat scaleFactor    = 0.0f;
        CGFloat scaledWidth    = targetWidth;
        CGFloat scaledHeight   = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0f ,0.0f);
        
        CGFloat widthFactor = targetWidth / sourceWidth;
        CGFloat heightFactor = targetHeight / sourceHeight;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;  // Fit height
        } else {
            scaleFactor = heightFactor; // Fit width
        }
        
        scaledWidth  = sourceWidth * scaleFactor;
        scaledHeight = sourceHeight * scaleFactor;
        
        if (widthFactor > heightFactor) {
            switch (verticalAlignment) {
                case RSVerticalAlignmentCenter:
                    // V: Center align
                    thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
                    break;
                case RSVerticalAlignmentTop:
                    // V: Top align
                    thumbnailPoint.y = 0;
                    break;
                case RSVerticalAlignmentBottom:
                    // V: Bottom align
                    thumbnailPoint.y = targetHeight - scaledHeight;
                    break;
                default:
                    break;
            }
        } else if (widthFactor < heightFactor) {
            switch (horizontalAlignment) {
                case RSHorizontalAlignmentCenter:
                    // H: Center align
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
                    break;
                case RSHorizontalAlignmentLeft:
                    // H: Left align
                    thumbnailPoint.x = 0;
                    break;
                case RSHorizontalAlignmentRight:
                    // H: Right align
                    thumbnailPoint.x = targetWidth - scaledWidth;
                    break;
                default:
                    break;
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [self drawInRect:thumbnailRect];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    return self;
}

- (UIImage *)imageWithNewSize:(CGSize)newSize
{
    return [self imageWithNewSize:newSize
              horizontalAlignment:RSHorizontalAlignmentCenter
                verticalAlignment:RSVerticalAlignmentTop
                            scale:[[UIScreen mainScreen] scale]];
}

@end

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
    
    for (UIView *subview in self.vContent.subviews) {
        subview.layer.borderWidth = 1.0f;
    }
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
}

@end
