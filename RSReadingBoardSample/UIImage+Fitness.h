//
//  UIImage+Fitness.h
//  RSImageFitnessSample
//
//  Created by R0CKSTAR on 3/28/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RSHorizontalAlignment) {
    /**
     *  H: Center align
     */
    RSHorizontalAlignmentCenter = 0,
    /**
     *  H: Left align
     */
    RSHorizontalAlignmentLeft,
    /**
     *  H: Right align
     */
    RSHorizontalAlignmentRight,
};

typedef NS_ENUM(NSUInteger, RSVerticalAlignment) {
    /**
     *  V: Center align
     */
    RSVerticalAlignmentCenter = 0,
    /**
     *
     */
    RSVerticalAlignmentTop,
    /**
     *  V: Bottom align
     */
    RSVerticalAlignmentBottom,
};

@interface UIImage (Fitness)

/**
 *  Create a new UIImage instance if its size NOT equals to the give size,
 *  otherwise retrun the unchanged self.
 *
 *  @param newSize             Size of the new image
 *  @param horizontalAlignment Horizontal alignment
 *  @param verticalAlignment   Vertical alignment
 *  @param scale               Scale of the new image
 *
 *  @return UIImage instace
 */
- (UIImage *)imageWithNewSize:(CGSize)newSize
          horizontalAlignment:(RSHorizontalAlignment)horizontalAlignment
            verticalAlignment:(RSVerticalAlignment)verticalAlignment
                        scale:(CGFloat)scale;

/**
 *  @NOTE: this function use RSHorizontalAlignmentCenter, RSVerticalAlignmentTop
 *  and current screen scale.
 */
- (UIImage *)imageWithNewSize:(CGSize)newSize;

@end
