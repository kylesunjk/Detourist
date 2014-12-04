//
//  Created by tekyinkwee on 8/29/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>
#import "Functions.h"

@implementation Functions {

}

+ (void)hideTabBar:(UITabBarController *)tabBarController duration:(NSTimeInterval)duration {
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    float fHeight = screenRect.size.height;
    if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        fHeight = screenRect.size.width;
    }

    for (UIView *view in tabBarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];
}


+ (void)showTabBar:(UITabBarController *)tabBarController duration:(NSTimeInterval)duration {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - 49.0;

    if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        fHeight = screenRect.size.width - 49.0;
    }

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    for (UIView *view in tabBarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];
}

+ (BOOL)createFolder:(NSString *)folderPath {
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:&error];
    if (error != nil) {
        NSLog(@"Error: %@", [error localizedDescription]);
        return NO;
    } else {
        return YES;
    }
}

+ (UIBarButtonItem *)createButtonWithTitle:(NSString *)title delegate:(id)delegate selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"bar_button_bg.png"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [button.layer setCornerRadius:4.0f];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    button.frame = CGRectMake(0.0, 100.0, 60.0, 30.0);
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)createButtonWithImage:(UIImage *)image delegate:(id)delegate selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"bar_button_bg.png"] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [button.layer setCornerRadius:4.0f];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    button.frame = CGRectMake(0.0, 100.0, image.size.width + 10, 30.0);
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (CGSize)getSizeFromImage:(NSString *)imagePath {
    NSURL *imageFileURL = [NSURL fileURLWithPath:imagePath];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef) imageFileURL, NULL);
    if (imageSource == NULL) {
        // Error loading image
        return CGSizeMake(0, 0);
    }

    CGFloat width = 0.0f, height = 0.0f;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    if (imageProperties != NULL) {
        CFNumberRef widthNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
        if (widthNum != NULL) {
            CFNumberGetValue(widthNum, kCFNumberFloatType, &width);
        }

        CFNumberRef heightNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        if (heightNum != NULL) {
            CFNumberGetValue(heightNum, kCFNumberFloatType, &height);
        }

        CFRelease(imageProperties);
    }

    return CGSizeMake(width, height);
}

+ (void)customizeNavigationController:(UINavigationController *)navController {
    UINavigationBar *navBar = [navController navigationBar];
    [navBar setTintColor:kSCNavBarColor];

    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) { // iOS 5 run this
        [navBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    }
//    else {
//        UIImageView *imageView = (UIImageView *) [navBar viewWithTag:kSCNavBarImageTag];
//        if (imageView == nil) {
//            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_bar.png"]];
//            [imageView setTag:kSCNavBarImageTag];
//            [navBar insertSubview:imageView atIndex:0];
//        }
//    }
}

+ (CGRect)getRect:(id)object {
    if ([object isKindOfClass:[UIView class]]) {
        return [Functions getOrientedRect:[(UIView *) object frame]];
    } else
        return CGRectZero;
}

+ (CGRect)getOrientedRect:(CGRect)rect {
    if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        return rect;
    } else {
        CGFloat temp = rect.size.width;
        rect.size.width = rect.size.height;
        rect.size.height = temp;

        return rect;
    }
}

+ (CGSize)getOrientedSize:(CGSize)size {
    if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        return size;
    } else {
        CGFloat temp = size.width;
        size.width = size.height;
        size.height = temp;

        return size;
    }
}

+ (NSDate *)getDateOnSystemTimezone {
    NSDate *sourceDate = [NSDate date];

    NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];

    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return destinationDate;
}

+ (double)getCurrentTimeMillis {
    return floor([[NSDate date] timeIntervalSince1970] * 1000);
}

+ (UIAlertView *)createAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];

    if (alert != nil) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

        indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 45);
        [indicator startAnimating];
        [alert addSubview:indicator];
    }
    return alert;
}

+ (void)setLabelHeightToFit:(UILabel *)label {
    [label setNumberOfLines:0];
    [label setLineBreakMode:UILineBreakModeWordWrap];

    float height = [label.text sizeWithFont:label.font
                          constrainedToSize:CGSizeMake(label.bounds.size.width, 99999)
                              lineBreakMode:UILineBreakModeWordWrap].height;

    CGRect frame = label.frame;
    frame.size.height = height;
    label.frame = frame;
}


@end