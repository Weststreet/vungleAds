//
//  VungleAds.h
//  Runner
//
//  Created by sunxy on 2019/8/7.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VungleSDK/VungleSDK.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^completionHandler)(NSString* result);
@interface VungleAds : NSObject <VungleSDKDelegate>
- (void)init:(NSString*)appid;
- (BOOL)loadPlacementWithID:(NSString *)placementID;
- (BOOL)isAdCachedForPlacementID:(nonnull NSString *)placementID;
- (BOOL)playAd:(UIViewController *)controller placementID:(nullable NSString *)placementID;
-(void) addRewardVerifyedHandler:(completionHandler)handler;
@property VungleSDK* sdk;
@property (nonatomic, strong) completionHandler completionHandlers;
@end

NS_ASSUME_NONNULL_END
