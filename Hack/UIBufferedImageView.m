//
//  UIBufferedImageView.m
//  Makko
//
//  Created by Tek yin Kwee on 5/18/12.
//  Copyright (c) 2012 nucleus302@gmail.com. All rights reserved.
//

#import "UIBufferedImageView.h"
#import "Functions.h"

@implementation UIBufferedImageView {
    UIImage *imageLink;
}
@synthesize isLoaded = _isLoaded;
@synthesize imageSize;
@synthesize minimumZoomScale = _minimumZoomScale;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareViewWithImagePath:(UIImage *)imagePath {
    imageLink = imagePath;
    imageSize = imageLink.size;
}

- (void)loadImage {
    if (![self isLoaded]) {
        [self setIsLoaded:YES];
        [self setImage:imageLink];
        [self setBounds:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    }
}

- (void)unloadImage {
    if ([self isLoaded]) {
        [self setIsLoaded:NO];
        // [self setImage:[UIImage imageNamed:@"comicPlaceholder.jpg"]];
        [self setBounds:CGRectMake(0, 0, 768, 1024)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
