import 'dart:async';

import 'package:flutter/services.dart';

class VungleAds {
  static const MethodChannel _channel =
      const MethodChannel('vungle_ads');

  static const EventChannel _vungleAdEventChannel =
  EventChannel('plugins.flutter.io/vungleAds');
  static Stream<String> _vungleAdEvents;

  /// A broadcast stream of events from the device gyroscope.
  static Stream<String> get vungleAdEvents {
    if (_vungleAdEvents == null) {
      _vungleAdEvents = _vungleAdEventChannel
          .receiveBroadcastStream()
          .map((dynamic event) => event.toString());
    }
    return _vungleAdEvents;
  }

  static init(String appId) async {
    final Map<String, dynamic> params = {};
    params['appId'] = appId;
    await _channel.invokeMethod('init', params);
  }

  static loadPlacementWithID(String placementId) async {
    final Map<String, dynamic> params = {};
    params['placementId'] = placementId;
    await _channel.invokeMethod('loadPlacementWithID', params);
  }

  static playAd(String placementId) async {
    final Map<String, dynamic> params = {};
    params['placementId'] = placementId;
    await _channel.invokeMethod('playAd',params);
  }

  static isAdCachedForPlacementID(String placementId) async{
    final Map<String, dynamic> params = {};
    params['placementId'] = placementId;
    return await _channel.invokeMethod('isAdCachedForPlacementID',params);
  }
}
