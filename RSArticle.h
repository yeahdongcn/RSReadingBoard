//
//  RSArticle.h
//  RSReadingBoardSample
//
//  Created by R0CKSTAR on 3/25/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSArticle : NSObject

@property (nonatomic, strong) UIColor  *color;

@property (nonatomic, strong) UIImage  *image;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *body;

@property (nonatomic, strong) NSArray  *clips;

@end
