#import "VungleAdsPlugin.h"

@implementation VungleAdsPlugin
VungleAds *vungleAds;
UIViewController *mVungleViewController;
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"vungle_ads"
                                     binaryMessenger:[registrar messenger]];
    VungleAdsPlugin* instance = [[VungleAdsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    
    NSLog(@"registerWithRegistrar");
    VungleRewardVerifyedStreamHandler* vungleRewardVerifyedStreamHandler = [[VungleRewardVerifyedStreamHandler alloc] init];
    FlutterEventChannel* eventChannel =
    [FlutterEventChannel eventChannelWithName:@"plugins.flutter.io/vungleAds"
                              binaryMessenger:[registrar messenger]];
    [eventChannel setStreamHandler:vungleRewardVerifyedStreamHandler];
    vungleAds=[[VungleAds alloc] init];
    mVungleViewController = [[[[UIApplication sharedApplication]delegate] window]rootViewController];
}


- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        [vungleAds init:call.arguments[@"appId"]];
    }else if ([@"loadPlacementWithID" isEqualToString:call.method]) {
        [vungleAds loadPlacementWithID:call.arguments[@"placementId"]];
    }else if ([@"isAdCachedForPlacementID" isEqualToString:call.method]) {
        [vungleAds isAdCachedForPlacementID:call.arguments[@"placementId"]];
    }else if ([@"playAd" isEqualToString:call.method]) {
        [vungleAds playAd:mVungleViewController placementID:call.arguments[@"placementId"]];
    }  else {
        result(FlutterMethodNotImplemented);
    }
}

@end

@implementation VungleRewardVerifyedStreamHandler

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
    NSLog(@"注册金币回调");
    [vungleAds addRewardVerifyedHandler:^(NSString * _Nonnull result) {
        NSLog(@"%@",result);
        eventSink(result);
    }];
    return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    return nil;
}

@end
