//
//  VungleAds.m
//  Runner
//
//  Created by sunxy on 2019/8/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "VungleAds.h"

@implementation VungleAds
- (void)init:(NSString*)appid {
    NSError* error;
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk startWithAppId:appid error:&error];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
}

- (BOOL)loadPlacementWithID:(NSString *)placementID{
     NSError *error;
    return [self.sdk loadPlacementWithID:placementID error:&error];
}

- (BOOL)isAdCachedForPlacementID:(nonnull NSString *)placementID{
     return [self.sdk isAdCachedForPlacementID:placementID];
}

- (BOOL)playAd:(UIViewController *)controller placementID:(nullable NSString *)placementID userId:(nullable NSString *)userId {
             NSLog(@"-->> Delegate Callback: uid: %@", userId);

     NSError *error;
     NSDictionary *options = @{
                               VunglePlayAdOptionKeyUser: userId,
                               VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"关闭视频将会失去奖励，确认关闭视频？",
                               VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"关闭",
                               VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"继续观看",
                               VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"注意!"};

    return [self.sdk playAd:controller options:options placementID:placementID error:&error];
}

-(void) addRewardVerifyedHandler:(completionHandler)handler {
    self.completionHandlers=handler;
}

#pragma mark - VungleSDKDelegate Methods

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID error:(NSError *)error {
    if (isAdPlayable) {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: %@", placementID);
    } else {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT available for Placement ID: %@", placementID);
    }
    
    
}

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillShowAdForPlacementID");
    
   
}

- (void)vungleWillCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillCloseAdWithViewInfo completedView=%@",info.completedView);
    if([info.completedView intValue]==1){
        if(self.completionHandlers!=nil){
            NSLog(@"奖励开始回调");
            self.completionHandlers(@"恭喜你，获取金币成功");
        }else{
            NSLog(@"注册回调失败");
        }
    }else{
        NSLog(@"没有达到奖励条件");
    }
}

- (void)vungleDidCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleDidCloseAdWithViewInfo");
    
    
    if (info) {
        NSLog(@"Info about ad viewed: %@", info);
    }
    
}

- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    
}
@end
