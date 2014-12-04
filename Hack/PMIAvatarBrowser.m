//
//  PMIAvatarBrowser.m
//  PMI_Retailer
//
//  Created by Sun Jiakang on 15/6/14.
//  Copyright (c) 2014 Massive Infinity. All rights reserved.
//

#import "PMIAvatarBrowser.h"
#import "UIImageScroll.h"

static CGRect oldframe;

#define MAPWIDTH 1280
#define MAPHEIGHT 2040
@implementation PMIAvatarBrowser




+(void)showImage:(UIImage *)avatarImageView{
    
    UIImage *image=avatarImageView;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

/*
    UIScrollView *myScroll = [[UIScrollView alloc] init];
    myScroll.frame = backgroundView.bounds; //scroll view occupies full parent view!
    //specify CGRect bounds in place of self.view.bounds to make it as a portion of parent view!
    
    myScroll.contentSize = CGSizeMake(MAPWIDTH, MAPHEIGHT);   //scroll view size
    myScroll.backgroundColor = [UIColor blueColor];
    myScroll.showsVerticalScrollIndicator = YES;    // to hide scroll indicators!
    myScroll.showsHorizontalScrollIndicator = YES; //by default, it shows!
    myScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    myScroll.scrollEnabled = TRUE;
    myScroll.bounces = FALSE;;
    //myScroll.bouncesZoom = FALSE;
    //myScroll.minimumZoomScale = 1.0;
    //myScroll.maximumZoomScale = 5.0;
    myScroll.delegate = self;
    
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor redColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    
    
    CGSize boundsSize = myScroll.contentSize;
    CGRect contentsFrame = backgroundView.frame;
    
    
    NSLog(@" content frame width %f", contentsFrame.size.width);
    NSLog(@" boundsSize width %f", boundsSize.width);
    if (contentsFrame.size.width < boundsSize.width) {
        NSLog(@" inside width");
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
        NSLog(@"width origin x %f", contentsFrame.origin.x);
    } else {
        NSLog(@"else width");
        contentsFrame.origin.x = 0.0f;
    }
    
    
    NSLog(@" content frame height %f", contentsFrame.size.height);
    NSLog(@" boundsSize height %f", boundsSize.height);

    if (contentsFrame.size.height < boundsSize.height) {
         NSLog(@" inside height");
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        NSLog(@"else height");
        contentsFrame.origin.y = 0.0f;
    }
    
    myScroll.frame = contentsFrame;
    
    
    [myScroll addSubview:imageView];*/

    UIImageScroll *scroll = [[UIImageScroll alloc] initWithImagePath:image frame:backgroundView.frame];

    [backgroundView addSubview:scroll];
    [window addSubview:backgroundView];
/*
    //added by kris for image zoom function

    UIPinchGestureRecognizer *recognizer=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(HandlePinch:)];
    [myScroll addGestureRecognizer: recognizer];
                          */
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
                            /*
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
     
              */
}


+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

//added by kris for image zoom function
+(void)HandlePinch:(UIPinchGestureRecognizer*)recognizer{
    if ([recognizer state] == UIGestureRecognizerStateEnded) {
        UIImageView *imageView=(UIImageView*)[recognizer.view viewWithTag:1];
        
                NSLog(@"======== Scale Applied ===========");
        if ([recognizer scale]<1.0f) {
            [recognizer setScale:1.0f];
        }
        CGAffineTransform transform = CGAffineTransformMakeScale([recognizer scale],  [recognizer scale]);
        imageView.transform = transform;
    }
}



/*
+ (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    //set the scrolling bounds
    scrollView.contentSize= CGSizeMake(MAPWIDTH*scale, MAPHEIGHT*scale);
    NSLog(@"scale: %f", scale);
    NSLog(@"content width: %f", scrollView.contentSize.width);
    NSLog(@"content height: %f", scrollView.contentSize.height);
    NSLog(@"frame width %f", scrollView.frame.size.width);
    NSLog(@"frame height %f", scrollView.frame.size.height);
}
*/

@end
