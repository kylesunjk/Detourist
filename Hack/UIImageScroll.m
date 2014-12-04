//
// Created by nucleus302 on 5/4/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIImageScroll.h"
#import "UIBufferedImageView.h"

#define ZOOM_STEP 1.5

@implementation UIImageScroll {
    CGFloat desiredZoomScale;
}

@synthesize mImageView;

- (UIImageScroll *)initWithImagePath:(UIImage *)image frame:(CGRect)rect {
    self = [super initWithFrame:rect];
    [self setDelegate:self];

    mImageView = [[UIBufferedImageView alloc] initWithImage:image];
    [mImageView prepareViewWithImagePath:image];
    [mImageView loadImage];

    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:mImageView];

    if ([self frame].size.width < [self frame].size.height) { // frame is portrait
        if ([mImageView imageSize].height > [mImageView imageSize].width)
            [self setMinimumZoomScale:[self frame].size.height / [mImageView imageSize].height];
        else
            [self setMinimumZoomScale:[self frame].size.width / [mImageView imageSize].width];
        desiredZoomScale = [self minimumZoomScale];
    } else { // frame is landscape
        if ([mImageView imageSize].height > [mImageView imageSize].width)
            [self setMinimumZoomScale:[self frame].size.height / [mImageView imageSize].height];
        else
            [self setMinimumZoomScale:[self frame].size.width / [mImageView imageSize].width];
        desiredZoomScale = [self frame].size.width / [mImageView imageSize].width;
    }
    [self setZoomScale:desiredZoomScale];
    [self setMaximumZoomScale:2 * [self minimumZoomScale]];
    [self setPagingEnabled:false];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [doubleTap setNumberOfTapsRequired:2];

//    [self addGestureRecognizer:singleTap];
    [self addGestureRecognizer:doubleTap];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = mImageView.frame;

    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;

    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;

    mImageView.frame = frameToCenter;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return mImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale + 0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateHud" object:nil userInfo:nil];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"double touch");
    float newScale = [self zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:self]];
    [self zoomToRect:zoomRect animated:YES];

}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {

    CGRect zoomRect;

    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width = [self frame].size.width / scale;

    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);

    return zoomRect;
}

- (void)resetState {
    [self setZoomScale:desiredZoomScale];
    [self setContentOffset:CGPointMake(0, 0)];
}

- (BOOL)isLoaded {
    return YES;
}

- (void)loadImage {
    [[self mImageView] loadImage];
    [self setContentOffset:CGPointMake(0, 0)];
}

- (void)unloadImage {
    [[self mImageView] unloadImage];
    [self setZoomScale:1];
}

- (void)resetStateWithOrientation {
    if ([self frame].size.width < [self frame].size.height) { // frame is portrait
        if ([mImageView imageSize].height > [mImageView imageSize].width)
            [self setMinimumZoomScale:[self frame].size.height / [mImageView imageSize].height];
        else
            [self setMinimumZoomScale:[self frame].size.width / [mImageView imageSize].width];
        desiredZoomScale=[self minimumZoomScale];
    } else { // frame is landscape
        if ([mImageView imageSize].height > [mImageView imageSize].width)
            [self setMinimumZoomScale:[self frame].size.height / [mImageView imageSize].height];
        else
            [self setMinimumZoomScale:[self frame].size.width / [mImageView imageSize].width];

        desiredZoomScale=[self frame].size.width / [mImageView imageSize].width;
    }
    [self setZoomScale:desiredZoomScale];
    [self setMaximumZoomScale:2 * [self minimumZoomScale]];
    [self scrollRectToVisible:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height) animated:NO];

}
@end