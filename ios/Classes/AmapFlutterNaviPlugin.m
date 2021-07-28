#import "AmapFlutterNaviPlugin.h"
#import "AMapFoundationKit.h"
#import "GPSNaviViewController.h"
#import "CompositeWithUserConfigViewController.h"

@implementation AmapFlutterNaviPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"amap_flutter_navi"
            binaryMessenger:[registrar messenger]];
  AmapFlutterNaviPlugin* instance = [[AmapFlutterNaviPlugin alloc] init];

  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"init" isEqualToString:call.method]) {
      NSString *key = call.arguments[@"iosKey"];
      [AMapServices sharedServices].apiKey = key;
  } else if([@"startNavi" isEqualToString:call.method]) {
      GPSNaviViewController *viewController = [[GPSNaviViewController alloc] init];
      NSArray *f = call.arguments[@"fromLatLng"];
      NSArray *t = call.arguments[@"toLatLng"];
      
      AMapNaviPoint *af = [AMapNaviPoint locationWithLatitude:[f[0] floatValue] longitude:[f[1] floatValue]];

      AMapNaviPoint *at = [AMapNaviPoint locationWithLatitude:[t[0] floatValue] longitude:[t[1] floatValue]];

      viewController.modalPresentationStyle = UIModalPresentationFullScreen;
      viewController.fNaviPoint = af;
      viewController.tNaviPoint = at;
      [[self viewControllerWithWindow:nil] presentViewController:viewController animated:YES completion:nil];

  } else if ([@"startNaviByEnd" isEqualToString:call.method]) {
      CompositeWithUserConfigViewController *viewController = [[CompositeWithUserConfigViewController alloc] init];
      viewController.modalPresentationStyle = UIModalPresentationFullScreen;
      NSArray *t = call.arguments[@"toLatLng"];
      NSString *name = call.arguments[@"name"];
      if (t != nil && name != nil) {
          viewController.name = name;
          AMapNaviPoint *at = [AMapNaviPoint locationWithLatitude:[t[0] floatValue] longitude:[t[1] floatValue]];
          viewController.tNaviPoint = at;
      }
      [[self viewControllerWithWindow:nil] presentViewController:viewController animated:YES completion:nil];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (UIViewController *)viewControllerWithWindow:(UIWindow *)window {
  UIWindow *windowToUse = window;
  if (windowToUse == nil) {
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
      if (window.isKeyWindow) {
        windowToUse = window;
        break;
      }
    }
  }

  UIViewController *topController = windowToUse.rootViewController;
  while (topController.presentedViewController) {
    topController = topController.presentedViewController;
  }
  return topController;
}

@end
