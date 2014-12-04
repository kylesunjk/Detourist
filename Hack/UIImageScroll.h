//
// Created by nucleus302 on 5/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UIBufferedImageView;


@interface UIImageScroll : UIScrollView <UIScrollViewDelegate>


@property(nonatomic, strong) UIBufferedImageView *mImageView;

- (UIImageScroll *)initWithImagePath:(UIImage *)image frame:(CGRect)rect;

- (void)resetState;

- (BOOL)isLoaded;

- (void)loadImage;

- (void)unloadImage;

- (void)resetStateWithOrientation;
@end