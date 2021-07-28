/*
 * @Description: 高德地图导航
 * @Author: dmlzj
 * @Github: https://github.com/dmlzj
 * @Email: 284832506@qq.com
 * @Date: 2021-01-28 17:28:21
 * @LastEditors: dmlzj
 * @LastEditTime: 2021-02-01 13:44:28
 * @如果有bug，那肯定不是我的锅，嘤嘤嘤
 */
import 'dart:async';

import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:flutter/services.dart';

class AmapFlutterNavi {
  static const MethodChannel _channel =
      const MethodChannel('amap_flutter_navi');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future startNavi(LatLng fromLatLng, LatLng toLatLng) async {
    await _channel.invokeMethod('startNavi',
        {'fromLatLng': fromLatLng.toJson(), 'toLatLng': toLatLng.toJson()});
  }

  /// 不传入终点可以进入后自己输入，也可以传
  static Future startNaviByEnd(
      [LatLng toLatLng, String name]) async {
    if (toLatLng != null && name != null) {
      await _channel.invokeMethod('startNaviByEnd', {
        'toLatLng': toLatLng.toJson(),
        'name': name
      });
    } else {
      await _channel.invokeMethod('startNaviByEnd');
    }
  }

  static Future init(String iosKey) async {
    await _channel.invokeMethod('init', {'iosKey': iosKey});
  }
}
