import 'dart:async';
import 'dart:ffi';

import 'package:flutter/services.dart';

typedef void ZJSDKNativeViewCreatedCallback(ZjsdkFlutter controller);
typedef void ZJSDKNativeEventCallback(MethodCall call);

typedef AdCallback = void Function(String id, String msg);
typedef AdErrorCallback = void Function(String id, int code, String message);

class ZjsdkFlutter {
  static int _channelId = 0;
  static MethodChannel _methodChannel =
      new MethodChannel("com.zjsdk.adsdk/method");
  static void showSplashAd(String adId, int fetchDelay,
      {AdCallback? onAdLoad,
      AdCallback? onAdShow,
      AdCallback? onAdClick,
      AdCallback? onCountdownEnd,
      AdCallback? onAdClose,
      AdCallback? onError}) {
    _methodChannel.invokeMethod("showSplashAd",
        {"_channelId": ++_channelId, "adId": adId, "fetchDelay": fetchDelay});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "splashAdDidLoad":
          onAdLoad?.call("splashAdDidLoad", "");
          break;

        case "splashAdSuccessPresentScreen":
          onAdShow?.call("splashAdSuccessPresentScreen", "");
          break;

        case "splashAdClicked":
          onAdClick?.call("splashAdClicked", "");
          break;

        case "splashAdCountdownEnd":
          onCountdownEnd?.call("splashAdCountdownEnd", "");
          break;

        case "splashAdClosed":
          onAdClose?.call("splashAdClosed", "");
          break;

        case "splashAdError":
          onError?.call("splashAdError", event["error"]);
          break;
      }
    });
  }

  /// show reward video ad
  static void showRewardVideoAd(String adId, String userId,
      {AdCallback? onAdLoad,
      AdCallback? onAdShow,
      AdCallback? onReward,
      AdCallback? onAdClick,
      AdCallback? onVideoComplete,
      AdCallback? onAdClose,
      AdCallback? onError}) {
    _methodChannel.invokeMethod("showRewardVideoAd",
        {"_channelId": ++_channelId, "adId": adId, "userId": userId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "rewardVideoLoadSuccess":
          onAdLoad?.call("rewardVideoLoadSuccess", "");
          break;

        case "rewardVideoAdDidShow":
          onAdShow?.call("rewardVideoAdDidShow", "");
          break;

        case "rewardVideoDidRewardEffective":
          onReward?.call("rewardVideoDidRewardEffective", event["transId"]);
          break;

        case "rewardVideoAdDidClicked":
          onAdClick?.call("rewardVideoAdDidClicked", "");
          break;

        case "rewardVideoAdDidPlayFinish":
          onVideoComplete?.call("rewardVideoAdDidPlayFinish", "");
          break;

        case "rewardVideoAdDidClose":
          onAdClose?.call("rewardVideoAdDidClose", "");
          break;

        case "onError":
          onError?.call("rewardVideoAdError", event["error"]);
          break;
      }
    });
  }

  /// show interstitial ad
  static void showInterstitialAd(String adId,
      {AdCallback? onAdLoad,
      AdCallback? onAdShow,
      AdCallback? onAdClick,
      AdCallback? onAdClose,
      AdCallback? onAdDetailClose,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showInterstitialAd", {"_channelId": ++_channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "interstitialAdDidLoad":
          onAdLoad?.call("interstitialAdDidLoad", "");
          break;

        case "interstitialAdDidPresentScreen":
          onAdShow?.call("interstitialAdDidPresentScreen", "");
          break;

        case "interstitialAdDidClick":
          onAdClick?.call("interstitialAdDidClick", "");
          break;

        case "interstitialAdDidClose":
          onAdClose?.call("interstitialAdDidClose", "");
          break;

        case "interstitialAdDetailDidClose":
          onAdDetailClose?.call("interstitialAdDetailDidClose", "");
          break;

        case "interstitialAdError":
          onError?.call("interstitialAdError", event["error"]);
          break;
      }
    });
  }

  static void showH5Ad(String adId, String userID, String userName,
      String userAvatar, int userIntegral, String ext,
      {AdCallback? onAdLoad,
      AdCallback? onError,
      AdCallback? onRewardAdLoad,
      AdCallback? onRewardAdReward,
      AdCallback? onRewardAdClick,
      AdCallback? onRewardAdError}) {
    _methodChannel.invokeMethod("showH5Ad", {
      "_channelId": ++_channelId,
      "adId": adId,
      "userID": userID,
      "userName": userName,
      "userAvatar": userAvatar,
      "userIntegral": userIntegral,
      "ext": ext
    });

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "h5AdDidLoad":
          onAdLoad?.call("h5AdDidLoad", "");
          break;

        case "h5AdError":
          onError?.call("h5AdError", event["error"]);
          break;

        case "h5_rewardAdDidLoad":
          onRewardAdLoad?.call("h5_rewardAdDidLoad", "");
          break;

        case "h5_rewardAdRewardEffective":
          onRewardAdReward?.call(
              "h5_rewardAdRewardEffective", event["transId"]);
          break;

        case "h5_rewardAdRewardClick":
          onRewardAdClick?.call("h5_rewardAdRewardClick", "");
          break;

        case "h5_rewardAdRewardError":
          onRewardAdError?.call("h5_rewardAdRewardError", event["error"]);
          break;
      }
    });
  }

  //self.contentId
  static void showContentVideoListPage(String adId,
      {AdCallback? onAdLoad,
      AdCallback? onAdShow,
      AdCallback? onAdClick,
      AdCallback? onAdClose,
      AdCallback? onAdDetailClose,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showContentVideoListPage", {"_channelId": ++_channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "interstitialAdDidLoad":
          onAdLoad?.call("interstitialAdDidLoad", "");
          break;

        case "interstitialAdDidPresentScreen":
          onAdShow?.call("interstitialAdDidPresentScreen", "");
          break;

        case "interstitialAdDidClick":
          onAdClick?.call("interstitialAdDidClick", "");
          break;

        case "interstitialAdDidClose":
          onAdClose?.call("interstitialAdDidClose", "");
          break;

        case "interstitialAdDetailDidClose":
          onAdDetailClose?.call("interstitialAdDetailDidClose", "");
          break;

        case "interstitialAdError":
          onError?.call("interstitialAdError", event["error"]);
          break;
      }
    });
  }
}
