//
//  FavouriteViewController.m
//  Hack
//
//  Created by Sun Jiakang on 30/11/14.
//  Copyright (c) 2014 Sun Jiakang. All rights reserved.
//

#import "FavouriteViewController.h"

@interface FavouriteViewController ()
@property BOOL isMenuUp;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (strong , nonatomic) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UITableView *favouriteTableview;
@end

@implementation FavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isMenuUp = YES;
    self.imageArray = [[NSMutableArray alloc] init];
 //   [self.imageArray initWithObjects:[UIImage imageNamed:@"icon_33-copy_01.png"],[UIImage imageNamed:@"icon_33-copy_02.png"],[UIImage imageNamed:@"icon_33-copy_03.png"],[UIImage imageNamed:@"icon_33-copy_04.png"],[UIImage imageNamed:@"icon_33-copy_05.png"], nil];
        [self.imageArray addObject:[UIImage imageNamed:@"icon_33-copy_01.png"]];
        [self.imageArray addObject:[UIImage imageNamed:@"icon_33-copy_02.png"]];
        [self.imageArray addObject:[UIImage imageNamed:@"icon_33-copy_03.png"]];
        [self.imageArray addObject:[UIImage imageNamed:@"icon_33-copy_04.png"]];
        [self.imageArray addObject:[UIImage imageNamed:@"icon_33-copy_05.png"]];
    self.favouriteTableview.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMune:(id)sender {

    [self hiddenMenu];

}

-(void)hiddenMenu{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    CGRect rect = self.frontView.frame;
    //    CGRect rect1 = self.upperView.frame;
    if (self.isMenuUp){
        //       if(rect.origin.y >500 )
        rect.origin.y = self.frontView.frame.origin.y + 179;
        //        if(rect.origin.y >500 )
        //        rect1.origin.y = self.upperView.frame.origin.y + 179;
        
        self.isMenuUp = NO;
    }
    else{
        //        if(rect.origin.y < 400)
        rect.origin.y = self.frontView.frame.origin.y -179;
        //        rect1.origin.y = self.upperView.frame.origin.y -179;
        
        self.isMenuUp = YES;
    }
    self.frontView.frame = rect;
    //    self.upperView.frame = rect1;
    [UIView commitAnimations];
}
- (IBAction)backClick:(id)sender {
    [self hiddenMenu];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"favouriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *imageview = (UIImageView *)[cell viewWithTag:11];
    imageview.frame = cell.frame;
    imageview.image = [self.imageArray objectAtIndex:indexPath.row];
    return cell;
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
