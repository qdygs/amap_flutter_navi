//
//  CompositeWithUserConfigViewController.h
//  officialDemoNavi
//
//  Created by eidan on 2017/7/19.
//  Copyright © 2017年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface CompositeWithUserConfigViewController : UIViewController
@property (retain,nonatomic) AMapNaviPoint *tNaviPoint;
@property (nonatomic,assign) NSString *name;

@end
