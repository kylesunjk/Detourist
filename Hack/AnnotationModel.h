//
//  AnnotationModel.h
//  Hack
//
//  Created by Sun Jiakang on 29/11/14.
//  Copyright (c) 2014 Sun Jiakang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface AnnotationModel : NSObject
@property (strong , nonatomic) NSString *title1;
@property (strong , nonatomic) NSString *title2;
@property (strong , nonatomic) NSString *title3;

@property (strong , nonatomic) UIImage *image;
@property (assign , nonatomic) CLLocationCoordinate2D coordinate2D;
@end
