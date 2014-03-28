//
//  UIImage+Fitness.m
//  RSImageFitnessSample
//
//  Created by R0CKSTAR on 3/28/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import "UIImage+Fitness.h"

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
