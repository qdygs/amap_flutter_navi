//
//  CompositeWithUserConfigViewController.m
//  officialDemoNavi
//
//  Created by eidan on 2017/7/19.
//  Copyright © 2017年 AutoNavi. All rights reserved.
//

#import "CompositeWithUserConfigViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "SpeechSynthesizer.h"

@interface CompositeWithUserConfigViewController () <AMapNaviCompositeManagerDelegate>

@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;

@end

@implementation CompositeWithUserConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.view.backgroundColor = [UIColor whiteColor];
    if (self.tNaviPoint != nil && self.name != nil) {
        AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:self.tNaviPoint name:self.name POIId:nil];  //传入终点
        [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    } else {
        [self.compositeManager presentRoutePlanViewControllerWithOptions:nil];  // 通过present的方式显示路线规划页面
    }
    
//    UIButton *btn = [self createBtn:@"传入终点" action:@selector(routePlanWithEndPoint) originY:100];
//    [self.view addSubview:btn];
//
//    UIButton *btn1 = [self createBtn:@"传入起终点、途径点" action:@selector(routePlanAction) originY:200];
//    [self.view addSubview:btn1];
//
//    UIButton *btn2 = [self createBtn:@"直接进入导航界面" action:@selector(startNaviDirectly) originY:300];
//    [self.view addSubview:btn2];
//
//    UIButton *btn3 = [self createBtn:@"传入自定义View" action:@selector(addCustomView) originY:400];
//    [self.view addSubview:btn3];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// init
- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
        _compositeManager.delegate = self;  // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    }
    return _compositeManager;
}

// 传入终点
- (void)routePlanWithEndPoint {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];  //传入终点
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}

// 传入起终点、途径点
- (void)routePlanAction {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeStart location:[AMapNaviPoint locationWithLatitude:40.080525 longitude:116.603039] name:@"北京首都机场" POIId:@"B000A28DAE"];     //传入起点，并且带高德POIId
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeWay location:[AMapNaviPoint locationWithLatitude:39.941823 longitude:116.426319] name:@"北京大学" POIId:@"B000A816R6"];            //传入途径点，并且带高德POIId
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:@"B000A8UIN8"];          //传入终点，并且带高德POIId
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}

// 直接进入导航界面
- (void)startNaviDirectly {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];  //传入终点
    [config setStartNaviDirectly:YES];  //直接进入导航界面
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}

// 传入自定义View
- (void)addCustomView {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];  //传入终点
    [config setStartNaviDirectly:YES];  //直接进入导航界面
    
    //传入 View 显示在界面之外的最底部
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), 90)];
    customView.backgroundColor = [UIColor lightGrayColor];
    [config addCustomBottomViewToNaviDriveView:customView];
    
    //传入 View 显示在界面的底部区域
    UIView *customView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) - 133, 46)];
    customView1.backgroundColor = [UIColor purpleColor];
    customView1.alpha = 0.5;
    [config addCustomViewToNaviDriveView:customView1];
    
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}

#pragma mark - Helper

- (UIButton *)createBtn:(NSString *)title action:(SEL)action originY:(CGFloat )originY {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) / 2, originY, 200, 45);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:53/255.0 green:117/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithRed:53/255.0 green:117/255.0 blue:255/255.0 alpha:1].CGColor;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark - AMapNaviCompositeManagerDelegate

// 发生错误时,会调用代理的此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 算路成功后的回调函数,路径规划页面的算路、导航页面的重算等成功后均会调用此方法
- (void)compositeManagerOnCalculateRouteSuccess:(AMapNaviCompositeManager *)compositeManager {
    NSLog(@"onCalculateRouteSuccess,%ld",(long)compositeManager.naviRouteID);
}

// 算路失败后的回调函数,路径规划页面的算路、导航页面的重算等失败后均会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"onCalculateRouteFailure error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 开始导航的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didStartNavi:(AMapNaviMode)naviMode {
    NSLog(@"didStartNavi,%ld",(long)naviMode);
}

// 当前位置更新回调
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager updateNaviLocation:(AMapNaviLocation *)naviLocation {
    NSLog(@"updateNaviLocation,%@",naviLocation);
}

// 导航到达目的地后的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didArrivedDestination:(AMapNaviMode)naviMode {
    NSLog(@"didArrivedDestination,%ld",(long)naviMode);
}

//// 以下注释掉的3个回调方法，如果需要自定义语音，可开启
//
//// SDK需要实时的获取是否正在进行导航信息播报，需要开发者根据实际播报情况返回布尔值
//- (BOOL)compositeManagerIsNaviSoundPlaying:(AMapNaviCompositeManager *)compositeManager {
//    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
//}
//
//// 导航播报信息回调函数
//- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType {
//    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
//    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
//}
//
//// 停止导航语音播报的回调函数，当导航SDK需要停止外部语音播报时，会调用此方法
//- (void)compositeManagerStopPlayNaviSound:(AMapNaviCompositeManager *)compositeManager {
//    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
//}

@end
