//
//  HackBottomSlideMenuViewController.m
//  Hack
//
//  Created by PFPL-mac2 on 1/9/15.
//  Copyright (c) 2015 Sun Jiakang. All rights reserved.
//

#import "HackBottomSlideMenuViewController.h"

#define FULLY_OPENED_CONSTANT -0.0


@interface HackBottomSlideMenuViewController (){
    UIPanGestureRecognizer *touchDragRecognizer;
    UITapGestureRecognizer *tapRecognizer;
    CGPoint initialTouchPoint;
    BOOL isUp;
    CGFloat initialContraintConstant;
    UIView *viewContainer;

}

@property (weak, nonatomic) IBOutlet UITableView *polyPointsTableview;
@property (strong , nonatomic) NSMutableArray *annotationArray;
@property (strong , nonatomic) UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *tapMenuImageview;
@property (nonatomic, retain) NSLayoutConstraint *topConstraint;
@end

@implementation HackBottomSlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    touchDragRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(touchDrag:)];
    touchDragRecognizer.delegate = self;
    [self.tapMenuImageview addGestureRecognizer:touchDragRecognizer];
}

#pragma mark -
#pragma mark - Initialization

- (id)initWithView:(UIView*)placeholderView withTbaleviewDataSource:(NSMutableArray*)sourceArray
{
    self = [super init];
    if (self) {
        self.annotationArray = sourceArray;
        self.placeholderView = placeholderView;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - Gesture Handler

- (void)touchDrag:(UIPanGestureRecognizer*)gesture
{
    // Check if this is the first touch
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        // Store the initial touch so when we change positions we do not snap
        initialTouchPoint = [gesture locationInView:gesture.view];
        [viewContainer bringSubviewToFront:gesture.view];
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint newCoord = [gesture locationInView:viewContainer];
        
        // Create the frame offsets to use our finger position in the view.
        float dY = newCoord.y - initialTouchPoint.y;
        
        if (dY == 0.00) {
            return;
        }
        
        isUp = YES;
        if (dY > 0.00) {
            isUp = NO;
        }
        
        self.topConstraint.constant -= dY;
        
        // Set to initial position if pan is below allowed range
        if (self.topConstraint.constant < initialContraintConstant) {
            self.topConstraint.constant = initialContraintConstant;
        }
        // Set to top most position if pan is above allowed range
        else if (self.topConstraint.constant > FULLY_OPENED_CONSTANT)  {
            self.topConstraint.constant = FULLY_OPENED_CONSTANT;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            // Re-layout for the modified constraint constant to take effect
            [viewContainer layoutIfNeeded];
        }completion:^(BOOL finished) {
            //            [self updateArrowImage];
        }];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        // Dock it to the left if pan direction is left
        if (isUp) {
            self.topConstraint.constant = FULLY_OPENED_CONSTANT;
        }
        // Dock it to the right if pan direction is right
        else {
            self.topConstraint.constant = initialContraintConstant;
        }
        [self makeConstraintsTakeEffect];
    }
}

- (void)touchTap:(UITapGestureRecognizer*)gesture
{
    // View is currently expanded more than halfway
    if ((self.topConstraint.constant <= viewContainer.frame.size.height * 0.5 && self.topConstraint.constant != FULLY_OPENED_CONSTANT)) {
        self.topConstraint.constant = FULLY_OPENED_CONSTANT;
        
    }
    // View is currently not expanded or expanded less than halfway
    else {
        self.topConstraint.constant = initialContraintConstant;
    }
    
    [self makeConstraintsTakeEffect];
}

#pragma mark - Update UI

- (void)slideToHide:(BOOL)shouldHide
{
    CGFloat updatedConstant;
    updatedConstant = shouldHide ? initialContraintConstant : FULLY_OPENED_CONSTANT;
    
    self.topConstraint.constant = updatedConstant;
    [self makeConstraintsTakeEffect];
}

- (void)makeConstraintsTakeEffect
{
    [UIView animateWithDuration:0.5  delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:0.6f options:UIViewAnimationOptionTransitionNone animations:^{
        [viewContainer layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
