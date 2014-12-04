//
//  Created by tekyinkwee on 8/29/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define NETWORK_NO_INTERNET 0
#define NETWORK_CONNECTED_WWAN 1
#define NETWORK_CONNECTED_WIFI 2

#define kSCNavBarImageTag 6183746
#define kSCNavBarColor [UIColor colorWithRed:110.0/255 green:206.0/255 blue:62.0/255 alpha:1.0]

#define IS_PHONE [[UIDevice currentDevice].model rangeOfString:@"iPhone"].location!=NSNotFound || [[UIDevice currentDevice].model rangeOfString:@"iPod"].location!=NSNotFound

@interface Functions : NSObject

+ (void)hideTabBar:(UITabBarController *)tabBarController duration:(NSTimeInterval)duration;

+ (void)showTabBar:(UITabBarController *)tabBarController duration:(NSTimeInterval)duration;

+ (BOOL)createFolder:(NSString *)folderPath;

+ (UIBarButtonItem *)createButtonWithTitle:(NSString *)title delegate:(id)delegate selector:(SEL)selector;

+ (UIBarButtonItem *)createButtonWithImage:(UIImage *)image delegate:(id)delegate selector:(SEL)selector;

+ (CGSize)getSizeFromImage:(NSString *)imagePath;

+ (void)customizeNavigationController:(UINavigationController *)navController;

+ (CGRect)getRect:(id)object;

+ (CGRect)getOrientedRect:(CGRect)rect;

+ (CGSize)getOrientedSize:(CGSize)size;

+ (NSDate *)getDateOnSystemTimezone;

+ (double)getCurrentTimeMillis;

+ (UIAlertView *)createAlertViewWithTitle:(NSString *)title message:(NSString *)message;

+ (void)setLabelHeightToFit:(UILabel *)label;


@end