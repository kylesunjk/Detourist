//
//  ViewController.m
//  Hack
//
//  Created by Sun Jiakang on 29/11/14.
//  Copyright (c) 2014 Sun Jiakang. All rights reserved.
//
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "ViewController.h"
#import "AnnotationModel.h"
#import "MDDirectionService.h"
#import "Landmark.h"
#import "PMIAvatarBrowser.h"
@interface ViewController (){
//    GMSMapView *mapView_;
    CLLocationCoordinate2D fakeLocation1,fakeLocation2 , fakeLocation3 , fakeLocation4 , fakeLocation5 , fakeLocation6;
    AnnotationModel *model1 , *model2, *model3 , *model4 , *model5 ,*model6;
}


@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *annotionDetail;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (strong , nonatomic) NSMutableArray *textfieldArray;
@property(strong , nonatomic) CLLocationManager *locationManager;
@property(assign , nonatomic) CLLocationCoordinate2D curLocation;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *menuTabScrollView;
@property (weak, nonatomic) IBOutlet UITableView *menuLocationTableview;
@property (strong , nonatomic) NSMutableArray *annotationArray;
@property (assign , nonatomic) BOOL isMenuHidden;
@property (strong , nonatomic) NSMutableArray *polylineArray;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *menuImageview;
@property (assign , nonatomic) int numberCount;
@property (strong, nonatomic) NSMutableArray *waypoints;
@property (strong, nonatomic) NSMutableArray *waypointStrings1;
@property (strong, nonatomic) NSMutableArray *waypointStrings2;
@property (strong, nonatomic) NSMutableArray *waypointStrings3;
@property int numd;
@property BOOL isMenuUp;
@property BOOL isSearchViewVisable;
@property BOOL isTableviewSourceChanged;
@property int gainNumber;
@property int gotoWhichPage;
@property (weak, nonatomic) IBOutlet UIView *upperView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

//    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
 //   self.mapView = mapView_;
    self.mapView.delegate = self;
    
    // Creates a marker in the center of the map
    self.gainNumber = 0;
   [self getMyCurrentLocation];
    self.isTableviewSourceChanged = NO;
    self.isMenuHidden = YES;
    self.isMenuUp = YES;
    self.menuLocationTableview.separatorStyle = NO;
    self.isSearchViewVisable = YES;
    self.annotationArray = [[NSMutableArray alloc] init];
    self.navigationController.navigationBarHidden = YES;
    self.waypoints = [[NSMutableArray alloc] init];
    self.waypointStrings1 = [[NSMutableArray alloc] init];
    self.waypointStrings2 = [[NSMutableArray alloc] init];
    self.waypointStrings3 = [[NSMutableArray alloc] init];
    self.polylineArray = [[NSMutableArray alloc] init];
    fakeLocation1.latitude=1.2987429;
    fakeLocation1.longitude=103.8545421;
    model1 = [[AnnotationModel alloc] init];
    model1.coordinate2D = fakeLocation1;
    model1.title1 =@"Bugis Junction Towers";
    model1.title2 =@"230 Victoria St";
    model1.title3 =@"188024";
    model1.image = [UIImage imageNamed:@"bugis junction.jpeg"];
  
    self.numberCount = 0;
    fakeLocation2.latitude=1.2953964;
    fakeLocation2.longitude=103.8549283;
    model2 = [[AnnotationModel alloc] init];
    model2.coordinate2D = fakeLocation2;
    model2.title1 =@"Lavender";
    model2.title2 =@"";
    model2.title3 =@"";
    model2  .image = [UIImage imageNamed:@"Lavender mrt.jpeg"];
    
    fakeLocation3.latitude=1.2941468;
    fakeLocation3.longitude=103.8554969;
    model3 = [[AnnotationModel alloc] init];
    model3.coordinate2D = fakeLocation3;
    model3.title1 =@"Suntec Singapore Convention & Exhibition Centre";
    model3.title2 =@"1 Raffles Boulevard Suntec City Singapore";
    model3.title3 =@"039593";
    model3.image = [UIImage imageNamed:@"suntect.jpg"];
    
    fakeLocation4.latitude=1.2948364;
    fakeLocation4.longitude=103.8539035;
    model4 = [[AnnotationModel alloc] init];
    model4.coordinate2D = fakeLocation4;
    model4.title1 =@"Suntec Singapore Convention & Exhibition Centre";
    model4.title2 =@"1 Raffles Boulevard Suntec City Singapore";
    model4.title3 =@"039593";
    model4.image = [UIImage imageNamed:@"suntect.jpg"];
    
    fakeLocation5.latitude=1.2885358;
    fakeLocation5.longitude=103.8599017;
    model5 = [[AnnotationModel alloc] init];
    model5.coordinate2D = fakeLocation5;
    model5.title1 =@"Suntec Singapore Convention & Exhibition Centre";
    model5.title2 =@"1 Raffles Boulevard Suntec City Singapore";
    model5.title3 =@"039593";
    model5.image = [UIImage imageNamed:@"suntect.jpg"];
    
    fakeLocation6.latitude=1.2874631;
    fakeLocation6.longitude=103.8530138;
    model6 = [[AnnotationModel alloc] init];
    model6.coordinate2D = fakeLocation6;
    model6.title1 =@"Suntec Singapore Convention & Exhibition Centre";
    model6.title2 =@"1 Raffles Boulevard Suntec City Singapore";
    model6.title3 =@"039593";
    model6.image = [UIImage imageNamed:@"suntect.jpg"];
    self.numd = 0;

    self.textfieldArray = [[NSMutableArray alloc] initWithObjects:self.textfield1,self.textfield2,self.textfield3, nil];
//    GMSMarker *marker1 = [[GMSMarker alloc] init];
//    marker1.position = fakeLocation1;
//    marker1.map = self.mapView;
//    
//    GMSMarker *marker2 = [[GMSMarker alloc] init];
//    marker2.position = fakeLocation2;
//    marker2.map = self.mapView;
//    
//    GMSMarker *marker3 = [[GMSMarker alloc] init];
//    marker3.position = fakeLocation3;
//    marker3.map = self.mapView;
    
    [self.annotationArray addObject:model1];
    [self.annotationArray addObject:model4];
    [self.annotationArray addObject:model2];
    [self.annotationArray addObject:model3];
    [self.annotationArray addObject:model6];
    [self.annotationArray addObject:model5];
    
    for (AnnotationModel *model in self.annotationArray) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = model.coordinate2D;
        if (self.numberCount%4==0) {
            [marker setIcon:[UIImage imageNamed:@"Vector Smart Object copy 10.png"]];
        }
        else if (self.numberCount%4==1) {
            [marker setIcon:[UIImage imageNamed:@"Vector Smart Object copy.png"]];
        }
        else if (self.numberCount%4==2) {
            [marker setIcon:[UIImage imageNamed:@"Vector Smart Object1 copy.png"]];
        }
        else if (self.numberCount%4==3) {
            [marker setIcon:[UIImage imageNamed:@"Vector Smart Object2 copy.png"]];
        }
        self.numberCount++;
        marker.map = self.mapView;
    }
    [self.menuLocationTableview reloadData];
    [self.menuLocationTableview setEditing:YES animated:YES];
//    [self loadRoute];
//    for (int i = 0; i <=5 ; i++) {
//        AnnotationModel *anntation = [[AnnotationModel alloc] init];
//        anntation.title1 = [NSString stringWithFormat:@"%d",i];
//        anntation.title2 = [NSString stringWithFormat:@"%d",i];
//        anntation.title3 = [NSString stringWithFormat:@"%d",i];
//        anntation.image = @"apple1.jpeg";
//        [self.annotationArray addObject:anntation];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self addMenuVIewToMainview];
    [self.view bringSubviewToFront:self.titleView];
    [self.view bringSubviewToFront:self.menuView];
    [self.view bringSubviewToFront:self.searchView];
    [self.view bringSubviewToFront:self.upperView];
    [self.view bringSubviewToFront:self.menuImageview];
}

- (IBAction)getMypoints:(id)sender {
//    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
//    [locationManager startUpdatingLocation];
//    CLLocation *location = [locationManager location];
//    CLLocationCoordinate2D currentLocation = [location coordinate];
//    AnnotationModel *model = [[AnnotationModel alloc] init];
//    model.coordinate2D = currentLocation;
//    GMSGeocoder *geocoder = [[GMSGeocoder alloc]init];
//    [geocoder reverseGeocodeCoordinate:currentLocation completionHandler:^(GMSReverseGeocodeResponse *geocoderResponse, NSError *error) {
//        GMSAddress *gmAddress = [geocoderResponse firstResult];
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = gmAddress.coordinate;
//        marker.title = [NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
//        marker.snippet = gmAddress.country;
//        marker.map = self.mapView;
//        
//        model.title1 =[NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
//        model.title2 =gmAddress.country;
//        [self.annotationArray addObject:model];
//        [self.menuLocationTableview reloadData];
//        [self.mapView animateToLocation:currentLocation];
//
//    }];

    
//    [self loadRoute];
}

-(void)getMyCurrentLocation{
    if (self.locationManager==nil)
    {
        self.locationManager =[[CLLocationManager alloc] init];
        
    }
    if (IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager.delegate=self;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter=10.0f;
        [self.locationManager startUpdatingLocation];
    }
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

}


-(void)addMenuVIewToMainview{
//    [self.menuView setCenter:CGPointMake(307, 1032)];
//    [self.view addSubview:self.menuView];
}

- (IBAction)menuButtonClicked:(id)sender {

    [self setViewMovedUp:self.isMenuHidden];
//    if (self.isTableviewSourceChanged) {
        [self loadRoute];
        self.isTableviewSourceChanged = NO;
//    }
}
- (IBAction)gotoNextPage:(UIButton *)sender {
    if (sender.tag ==11) {
        [self hiddenUppMenu];
        [self performSegueWithIdentifier:@"gotoFav" sender:self];
    }
    else{
        [self hiddenUppMenu];
        [self performSegueWithIdentifier:@"gotoBookmark" sender:self];
    }
    
}



- (void)setViewMovedUp:(BOOL)movedUp{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    CGRect rect = self.menuView.frame;
    if (movedUp){
        if(rect.origin.y >500 )
            rect.origin.y = self.menuView.frame.origin.y - 510;
        self.isMenuHidden = NO;
    }
    else{
        if(rect.origin.y < 400)
            rect.origin.y = self.menuView.frame.origin.y + 510;
        self.isMenuHidden = YES;
    }
    self.menuView.frame = rect;
    [UIView commitAnimations];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"newLocation:%@",[newLocation description]);
    
    //保存新位置
    self.curLocation=newLocation.coordinate;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations objectAtIndex:0];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:16];
    self.mapView.camera =camera;
    
    //GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = location.coordinate;
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = self.mapView;
    self.curLocation = location.coordinate;
    [self.locationManager stopUpdatingLocation];

}

-(void)mapView:(GMSMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:userLocation.location.coordinate.latitude
                                                            longitude:userLocation.location.coordinate.longitude
                                                                 zoom:6];
    
    mapView.camera =camera;
    
    //GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    
    
    [self.locationManager stopUpdatingLocation];
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    
    [self.annotionDetail setHidden:NO];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:marker.position zoom:16];
    self.mapView.camera =camera;
    return YES;
}

-(void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay{
    [self.annotionDetail setHidden:YES];
}


-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    
    if (self.numd == 0) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = fakeLocation1;
//        marker.title = [NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
//        marker.snippet = gmAddress.country;
        marker.map = self.mapView;
        self.numd ++;
    }
    else if(self.numd ==1){
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = fakeLocation2;
        //        marker.title = [NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
        //        marker.snippet = gmAddress.country;
        marker.map = self.mapView;
    }
//    GMSGeocoder *geocoder = [[GMSGeocoder alloc]init];

//    [geocoder reverseGeocodeCoordinate:fakeLocation1 completionHandler:^(GMSReverseGeocodeResponse *geocoderResponse, NSError *error) {
//       GMSAddress *gmAddress = [geocoderResponse firstResult];
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = gmAddress.coordinate;
//        marker.title = [NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
//        marker.snippet = gmAddress.country;
//        marker.map = self.mapView;
//
//        AnnotationModel *model = [[AnnotationModel alloc] init];
//        model.coordinate2D = gmAddress.coordinate;
//        model.title1 =[NSString stringWithFormat:@"%@ %@ %@",gmAddress.thoroughfare,gmAddress.locality,gmAddress.postalCode];
//        model.title2 =gmAddress.country;
//        
//        [self.annotationArray addObject:model];
//        [self.menuLocationTableview reloadData];
//        [self.mapView animateToLocation:gmAddress.coordinate];
//
//    }];
}

-(void)loadRoute{
//  
//    if (self.annotationArray.count>=2) {
//        
//        for (AnnotationModel *model in self.annotationArray) {
    
    for (GMSPolyline *polyline in self.polylineArray) {
        polyline.map = nil;
    }
    [self.polylineArray removeAllObjects];
    self.waypointStrings1 = [[NSMutableArray alloc] init];
    self.waypointStrings2 = [[NSMutableArray alloc] init];
    self.waypointStrings3 = [[NSMutableArray alloc] init];
    NSString *currentPostString = [NSString stringWithFormat:@"%f,%f",model1.coordinate2D.latitude,model1.coordinate2D.longitude];
//
//    
    NSString *startPositionString1 = [NSString stringWithFormat:@"%f,%f",model5.coordinate2D.latitude,model5.coordinate2D.longitude];
//
//    NSString *startPositionString2 = [NSString stringWithFormat:@"%f,%f",model2.coordinate2D.latitude,model2.coordinate2D.longitude];
//    
//    NSString *startPositionString3 = [NSString stringWithFormat:@"%f,%f",model4.coordinate2D.latitude,model4.coordinate2D.longitude];
// //           for(Landmark *landmark in self.landmarksOnRoute){
//    [self.waypointStrings1 addObject:currentPostString];
//    [self.waypointStrings1 addObject:startPositionString1];
//    [self.waypointStrings1 addObject:startPositionString2];
//    [self.waypointStrings1 addObject:startPositionString3];
//    
    [self.waypointStrings2 addObject:currentPostString];
    [self.waypointStrings2 addObject:startPositionString1];
//
//    [self.waypointStrings3 addObject:startPositionString1];
//    [self.waypointStrings3 addObject:currentPostString];
    
    for (AnnotationModel *model  in self.annotationArray) {
        NSString *currentPostString = [NSString stringWithFormat:@"%f,%f",model.coordinate2D.latitude,model.coordinate2D.longitude];
        [self.waypointStrings1 addObject:currentPostString];
    }
    
    
  //          }
//            if (self.waypointStrings.count > 1) {
//    for (int i=0; i<3; i++) {
        NSDictionary *query = @{ @"sensor" : @"false",
                                 @"waypoints" : self.waypointStrings1 };
        MDDirectionService *mds = [[MDDirectionService alloc] init];
        SEL selector = @selector(addDirections:withColor:);
        [mds setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    NSDictionary *query2 = @{ @"sensor" : @"false",
                             @"waypoints" : self.waypointStrings2 };
    mds = [[MDDirectionService alloc] init];
//    SEL selector = @selector(addDirections:withColor:);
    [mds setDirectionsQuery:query2
               withSelector:selector
               withDelegate:self];
//    NSDictionary *query3 = @{ @"sensor" : @"false",
//                             @"waypoints" : self.waypointStrings3 };
//    mds = [[MDDirectionService alloc] init];
////    SEL selector = @selector(addDirections:withColor:);
//    [mds setDirectionsQuery:query3
//               withSelector:selector
//               withDelegate:self];
//    }

//            }else{
//                NSLog(@"No route created, only %lu", (unsigned long)self.waypoints.count);
//            }

//        }
        //        [self addMapAnnotation];

 //   }
    
}
- (IBAction)showUppMenu:(id)sender {
    [self hiddenUppMenu];
    
}


-(void)hiddenUppMenu{
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
- (IBAction)hiddenThePop:(id)sender {
    [self.annotionDetail setHidden:YES];
}

-(void)addDirections:(NSDictionary *)json withColor:(int)i{
    if ([[json valueForKey:@"status"] isEqualToString:@"OK"]) {
        NSDictionary *routes = json[@"routes"][0];
        NSDictionary *route = routes[@"overview_polyline"];
        NSString *overview_route = route[@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        if (self.numd%2 == 0) {
 //           polyline.strokeColor = [UIColor colorWithRed:6/255 green:142/255 blue:190/255 alpha:1.0];
            polyline.strokeColor = [UIColor blueColor];
            self.numd++;
        }
        else {
 //           polyline.strokeColor = [UIColor colorWithRed:195/255 green:194/255 blue:192/255 alpha:1.0];
            polyline.strokeColor = [UIColor grayColor];
            self.numd++;
        }
//        else{
//            polyline.strokeColor = [UIColor blueColor];
//            self.numd++;
//        }
//        polyline.strokeColor = [UIColor colorWithRed:arc4random() % 255 green:arc4random() % 255 blue:arc4random() % 255 alpha:1.0];
        polyline.strokeWidth = 8;
        polyline.map = self.mapView;
        [self.polylineArray addObject:polyline];
    }else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[json valueForKey:@"status"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }
}

//-(void)addMapAnnotation{
//    for(Landmark *landmark in self.landmarksOnRoute){
//        GMSMarker *landmarkMarker = [GMSMarker markerWithPosition:[landmark.getcoordinateObject MKCoordinateValue]];
//        landmarkMarker.title = landmark.getTitle;
//        landmarkMarker.map = _mapView;
//        self.view = _mapView;
//    }
//}

//- (IBAction)getRoute:(id)sender {
//    [self loadRoute];
//}

- (IBAction)goButtonClicked:(id)sender {
    [self makeSearchviewFadeinOrFadeOut];
    for (UITextField *textfield in self.textfieldArray) {
        [textfield resignFirstResponder];
    }
    [self loadRoute];
    
}

-(void)makeSearchviewFadeinOrFadeOut{
    if (self.isSearchViewVisable) {
        // 淡出移除当前View
        self.searchView.alpha= 0.9f;
        [UIView beginAnimations:@"fadeIn" context:nil];
        [UIView setAnimationDuration:0.5];
        //    [self.view removeFromSuperview];
        self.searchView.alpha = 0.0f;
        [UIView commitAnimations];
        self.isSearchViewVisable = NO;
    }
    else{
        // 淡入显示新View
        self.searchView.alpha = 0.0f;
        [UIView beginAnimations:@"fadeIn" context:nil];
//        [self.view. addSubview:subview];
        [UIView setAnimationDuration:1.0];
        self.searchView.alpha = 0.9f;
        [UIView commitAnimations];
        self.isSearchViewVisable = YES;
    }
    

    
    
}
- (IBAction)showSearchview:(id)sender {
    [self makeSearchviewFadeinOrFadeOut];
}

//#tableview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.annotationArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"annotationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    cell.delegate=self;
//    AnnotationModel *thisObject = [[AnnotationModel alloc] init];
//    thisObject = [self.annotationArray objectAtIndex:indexPath.row];
//    UILabel *label1 = (UILabel *)[cell viewWithTag:11];
//    UILabel *label2 = (UILabel *)[cell viewWithTag:12];
//    UILabel *label3 = (UILabel *)[cell viewWithTag:13];
//    
    UIImageView *image1 = (UIImageView *)[cell viewWithTag:10];
//    
//    [label1 setText:thisObject.title1];
//    [label2 setText:thisObject.title2];
//    [label3 setText:thisObject.title3];
    switch (indexPath.row) {
        case 0:
             [image1 setImage:[UIImage imageNamed:@"mapInfo_01"]];
            break;
        case 1:
            [image1 setImage:[UIImage imageNamed:@"mapInfo_02"]];
            break;
        case 2:
            [image1 setImage:[UIImage imageNamed:@"mapInfo_03"]];
            break;
        case 3:
           [image1 setImage:[UIImage imageNamed:@"mapInfo_04"]];
            break;
        case 4:
            [image1 setImage:[UIImage imageNamed:@"mapInfo_03"]];
            break;
        case 5:
            [image1 setImage:[UIImage imageNamed:@"mapInfo_02"]];
            break;
        default:
            break;
    }
   
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (IBAction)showFullImage:(id)sender {
    [PMIAvatarBrowser showImage:[UIImage imageNamed:@"galleryOverlay.jpg"]];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=0&&indexPath.row!=self.annotationArray.count-1) {
            return YES;
    }
    return NO;

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row !=0 && indexPath.row!=self.annotationArray.count -1) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleNone;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (sourceIndexPath.row!=0&&sourceIndexPath.row!=self.annotationArray.count-1 && destinationIndexPath.row!=0&&destinationIndexPath.row!=self.annotationArray.count-1) {
        NSInteger fromRow = [sourceIndexPath row];
        
        NSInteger toRow = [destinationIndexPath row];
        
        id object = [self.annotationArray objectAtIndex:fromRow];
        
        [self.annotationArray removeObjectAtIndex:fromRow];
        
        [self.annotationArray insertObject:object atIndex:toRow];
        
        self.isTableviewSourceChanged = YES;
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"already added into favourite" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alter show];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}
//#pragma mark - JEECellCollectDelegate
//- (void)collectCellAtIndex:(NSIndexPath *)index
//{
//    [self.annotationArray removeObjectAtIndex:index.row];
//    [self.menuLocationTableview reloadData];
//}
//
//- (void)cancleCollectAtIndex:(NSIndexPath *)index
//{
// //   [_collectIndexArray removeObject:index];
//}
@end
