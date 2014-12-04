//
//  UIBufferedImageView.h
//  Makko
//
//  Created by Tek yin Kwee on 5/18/12.
//  Copyright (c) 2012 nucleus302@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBufferedImageView : UIImageView
@property(nonatomic, assign) BOOL isLoaded;
@property(nonatomic, assign) CGSize imageSize;
@property(nonatomic, assign) CGFloat minimumZoomScale;

- (void)prepareViewWithImagePath:(UIImage *)imagePath;

- (void)loadImage;
- (void)unloadImage;


@end
