//
//  GPSNaviViewController.h
//  AMapNaviKit
//
//  Created by liubo on 7/29/16.
//  Copyright © 2016 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface GPSNaviViewController : UIViewController

@property (nonatomic, strong) AMapNaviDriveView *driveView;

@property (retain,nonatomic) AMapNaviPoint *fNaviPoint;
@property (retain,nonatomic) AMapNaviPoint *tNaviPoint;

@end
