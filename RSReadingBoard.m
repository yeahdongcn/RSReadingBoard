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

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (false)
#endif

#define PROPERTY_NAME(property) [[(@""#property) componentsSeparatedByString:@"."] lastObject]

@interface RSReadingBoard () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *vContent;

@property (nonatomic, weak) IBOutlet UIImageView  *ivImage;
@property (nonatomic) CGRect ivImageFrame;

@property (nonatomic, weak) IBOutlet UIView       *vColor;

@property (nonatomic, weak) IBOutlet UILabel      *lTitle;

@property (nonatomic, weak) IBOutlet UILabel      *lSource;

@property (nonatomic, weak) IBOutlet UILabel      *lDate;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTop;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lclTitleTrailing;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcvColorLeading;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageTrailing;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageTop;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lcivImageBottom;

@property (nonatomic, strong) NSLayoutManager *layoutManager;

@property (nonatomic, strong) NSTextStorage   *textStorage;

@property (nonatomic, strong) NSMutableDictionary *oldConstants;

@end

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

#pragma mark - NSObject

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        self.enableImageDragZoomIn = YES;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  @NOTE: Turn off automatically adjusts scroll view insets in xib or here
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /**
     *  @NOTE: Enable content view's paging in xib or here
     */
    self.vContent.pagingEnabled = YES;
    
    /**
     *  @NOTE: Set content view's delegate in xib or here
     */
    self.vContent.delegate = self;
    
    [self.oldConstants setObject:@(self.lcivImageTop.constant) forKey:PROPERTY_NAME(self.lcivImageTop)];
    [self.oldConstants setObject:@(self.lcivImageHeight.constant) forKey:PROPERTY_NAME(self.lcivImageHeight)];
}

#pragma mark - Setters

- (void)setArticle:(RSArticle *)article
{
    if (_article == article) {
        return;
    }
    
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
    if (article.color) {
        self.vColor.backgroundColor = article.color;
    } else {
        self.vColor.backgroundColor = [UIColor colorWithRed:(arc4random() % 256 / 255.0f) green:(arc4random() % 256 / 255.0f) blue:(arc4random() % 256 / 255.0f) alpha:1.0f];
    }
    [self.lTitle layoutIfNeeded];
    [self.lSource layoutIfNeeded];
    [self.lDate layoutIfNeeded];
    [self.vColor layoutIfNeeded];
    
    self.textStorage = [[NSTextStorage alloc] initWithString:article.body];
    self.layoutManager = [[NSLayoutManager alloc] init];
    [self.textStorage addLayoutManager:self.layoutManager];
    
    NSUInteger lastGlyph = 0;
    NSUInteger currentPage = 0;
    while (lastGlyph < self.layoutManager.numberOfGlyphs) {
        CGRect frame = CGRectMake(self.contentInsets.left,
                                  self.contentInsets.top + self.vContent.bounds.size.height * currentPage,
                                  self.vContent.bounds.size.width - self.contentInsets.left - self.contentInsets.right,
                                  self.vContent.bounds.size.height - self.contentInsets.top - self.contentInsets.bottom);
        if (currentPage == 0) {
            CGFloat δ = self.vColor.frame.origin.y + self.vColor.bounds.size.height;
            frame.origin.y += δ;
            frame.size.height -= δ;
        }
        
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:frame.size];
        [self.layoutManager addTextContainer:textContainer];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:frame
                                                   textContainer:textContainer];
        if (self.bodyBackgroundColor) {
            [textView setBackgroundColor:self.bodyBackgroundColor];
        } else {
            [textView setBackgroundColor:[UIColor clearColor]];
        }
        if (self.bodyTextColor) {
            [textView setTextColor:self.bodyTextColor];
        } else {
            [textView setTextColor:[UIColor darkGrayColor]];
        }
        if (self.bodyFont) {
            [textView setFont:self.bodyFont];
        } else {
            [textView setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
        }
        textView.scrollEnabled = NO;
        textContainer.size = textView.contentSize;
        [self.vContent addSubview:textView];
        
        lastGlyph = NSMaxRange([self.layoutManager glyphRangeForTextContainer:textContainer]);
        currentPage++;
    }
    self.lcivImageBottom.constant = self.vContent.bounds.size.height * currentPage - self.lcivImageHeight.constant;
}

- (NSMutableDictionary *)oldConstants
{
    if (!_oldConstants) {
        _oldConstants = [[NSMutableDictionary alloc] init];
    }
    return _oldConstants;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.vContent) {
        if (self.enableImageDragZoomIn) {
            CGFloat yOffset = scrollView.contentOffset.y;
            if (yOffset < 0) {
                self.lcivImageTop.constant = [[self.oldConstants objectForKey:PROPERTY_NAME(self.lcivImageTop)] floatValue] + yOffset;
                self.lcivImageHeight.constant = [[self.oldConstants objectForKey:PROPERTY_NAME(self.lcivImageHeight)] floatValue] - yOffset;
            } else {
                self.lcivImageTop.constant = [[self.oldConstants objectForKey:PROPERTY_NAME(self.lcivImageTop)] floatValue];
                self.lcivImageHeight.constant = [[self.oldConstants objectForKey:PROPERTY_NAME(self.lcivImageHeight)] floatValue];
            }
            [self.ivImage layoutIfNeeded];
        }
    }
}

@end
