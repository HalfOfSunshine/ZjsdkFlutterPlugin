import 'package:flutter/services.dart';

typedef void ZJSDKNativeViewCreatedCallback(ZjsdkFlutter controller);
typedef void ZJSDKNativeEventCallback(MethodCall call);

typedef MsgCallback = void Function(String msg);
typedef AdCallback = void Function(String id, String msg);
typedef AdErrorCallback = void Function(String id, int code, String message);
typedef AdExtraCallback = void Function(String id, String msg, {Map? extraMap});

class ZjsdkFlutter {
  static int _channelId = 8080;
  static MethodChannel _methodChannel =
      new MethodChannel("com.zjsdk.adsdk/method");
  static void initZJMethodChannel(MsgCallback? onMethodChannelCreated) {
    _methodChannel.invokeMethod("createZJMethodChannel", {
      "_channelId": _channelId,
    });
    EventChannel rewardEventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    rewardEventChannel.receiveBroadcastStream().listen((event) {
      print("event====" + event["event"]);

      switch (event["event"]) {
        case "methodChannelCreated":
          onMethodChannelCreated?.call("iOS->flutter事件通道建立成功");
          break;
      }
    });
  }

  static void registerAppId(String appId, {AdCallback? onCallback}) {
    _methodChannel.invokeMethod("registerAppId", {"appId": appId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "success":
          onCallback?.call("success", event["info"].toString());
          break;
        case "fail":
          onCallback?.call("fail", event["info"].toString());
          break;
      }
    });
  }

  static void showSplashAd(String adId, int fetchDelay,
      {AdCallback? onAdLoad,
      AdCallback? onAdShow,
      AdCallback? onAdClick,
      AdCallback? onCountdownEnd,
      AdCallback? onAdClose,
      AdCallback? onError}) {
    _methodChannel.invokeMethod("showSplashAd",
        {"_channelId": _channelId, "adId": adId, "fetchDelay": fetchDelay});

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
        {"_channelId": _channelId, "adId": adId, "userId": userId});
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

        case "rewardVideoAdError":
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
        "showInterstitialAd", {"_channelId": _channelId, "adId": adId});

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
      "_channelId": _channelId,
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
      {AdCallback? onVideoDidStartPlay,
      AdCallback? onVideoDidPause,
      AdCallback? onVideoDidResume,
      AdCallback? onVideoDidEndPlay,
      AdCallback? onContentDidFullDisplay,
      AdCallback? onContentDidEndDisplay,
      AdCallback? onContentDidPause,
      AdCallback? onContentDidResume,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showContentVideoListPage", {"_channelId": _channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "videoDidStartPlay":
          onVideoDidStartPlay?.call("videoDidStartPlay", "");
          break;

        case "videoDidPause":
          onVideoDidPause?.call("videoDidPause", "");
          break;

        case "videoDidResume":
          onVideoDidResume?.call("videoDidResume", "");
          break;

        case "videoDidEndPlay":
          onVideoDidEndPlay?.call("videoDidEndPlay", "");
          break;

        case "videoDidFailedToPlay":
          onError?.call("videoDidFailedToPlay", event["error"]);
          break;

        case "contentDidFullDisplay":
          onContentDidFullDisplay?.call("contentDidFullDisplay", "");
          break;

        case "contentDidEndDisplay":
          onContentDidEndDisplay?.call("contentDidEndDisplay", "");
          break;

        case "contentDidPause":
          onContentDidPause?.call("contentDidPause", "");
          break;

        case "contentDidResume":
          onContentDidResume?.call("contentDidResume", "");
          break;
      }
    });
  }

  static void showContentVideoFeedPage(String adId,
      {AdCallback? onVideoDidStartPlay,
      AdCallback? onVideoDidPause,
      AdCallback? onVideoDidResume,
      AdCallback? onVideoDidEndPlay,
      AdCallback? onContentDidFullDisplay,
      AdCallback? onContentDidEndDisplay,
      AdCallback? onContentDidPause,
      AdCallback? onContentDidResume,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showContentVideoFeedPage", {"_channelId": _channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "videoDidStartPlay":
          onVideoDidStartPlay?.call("videoDidStartPlay", "");
          break;

        case "videoDidPause":
          onVideoDidPause?.call("videoDidPause", "");
          break;

        case "videoDidResume":
          onVideoDidResume?.call("videoDidResume", "");
          break;

        case "videoDidEndPlay":
          onVideoDidEndPlay?.call("videoDidEndPlay", "");
          break;

        case "videoDidFailedToPlay":
          onError?.call("videoDidFailedToPlay", event["error"]);
          break;

        case "contentDidFullDisplay":
          onContentDidFullDisplay?.call("contentDidFullDisplay", "");
          break;

        case "contentDidEndDisplay":
          onContentDidEndDisplay?.call("contentDidEndDisplay", "");
          break;

        case "contentDidPause":
          onContentDidPause?.call("contentDidPause", "");
          break;

        case "contentDidResume":
          onContentDidResume?.call("contentDidResume", "");
          break;
      }
    });
  }

  static void showContentVideoHorizontal(String adId,
      {AdCallback? onVideoDidStartPlay,
      AdCallback? onVideoDidPause,
      AdCallback? onVideoDidResume,
      AdCallback? onVideoDidEndPlay,
      AdCallback? onContentDidFullDisplay,
      AdCallback? onContentDidEndDisplay,
      AdCallback? onContentDidPause,
      AdCallback? onContentDidResume,
      AdCallback? onHorizontalFeedDetailDidEnter,
      AdCallback? onHorizontalFeedDetailDidLeave,
      AdCallback? onHorizontalFeedDetailDidAppear,
      AdCallback? onHorizontalFeedDetailDidDisappear,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showContentVideoHorizontal", {"_channelId": _channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "videoDidStartPlay":
          onVideoDidStartPlay?.call("videoDidStartPlay", "");
          break;

        case "videoDidPause":
          onVideoDidPause?.call("videoDidPause", "");
          break;

        case "videoDidResume":
          onVideoDidResume?.call("videoDidResume", "");
          break;

        case "videoDidEndPlay":
          onVideoDidEndPlay?.call("videoDidEndPlay", "");
          break;

        case "videoDidFailedToPlay":
          onError?.call("videoDidFailedToPlay", event["error"]);
          break;

        case "contentDidFullDisplay":
          onContentDidFullDisplay?.call("contentDidFullDisplay", "");
          break;

        case "contentDidEndDisplay":
          onContentDidEndDisplay?.call("contentDidEndDisplay", "");
          break;

        case "contentDidPause":
          onContentDidPause?.call("contentDidPause", "");
          break;

        case "contentDidResume":
          onContentDidResume?.call("contentDidResume", "");
          break;

        case "horizontalFeedDetailDidEnter":
          onHorizontalFeedDetailDidEnter?.call(
              "horizontalFeedDetailDidEnter", "");
          break;

        case "horizontalFeedDetailDidLeave":
          onHorizontalFeedDetailDidLeave?.call(
              "horizontalFeedDetailDidLeave", "");
          break;

        case "horizontalFeedDetailDidAppear":
          onHorizontalFeedDetailDidAppear?.call(
              "horizontalFeedDetailDidAppear", "");
          break;

        case "horizontalFeedDetailDidDisappear":
          onHorizontalFeedDetailDidDisappear?.call(
              "horizontalFeedDetailDidDisappear", "");
          break;
      }
    });
  }

  static void showContentVideoImageText(String adId,
      {AdCallback? onVideoDidStartPlay,
      AdCallback? onVideoDidPause,
      AdCallback? onVideoDidResume,
      AdCallback? onVideoDidEndPlay,
      AdCallback? onContentDidFullDisplay,
      AdCallback? onContentDidEndDisplay,
      AdCallback? onContentDidPause,
      AdCallback? onContentDidResume,
      AdCallback? onHorizontalFeedDetailDidEnter,
      AdCallback? onHorizontalFeedDetailDidLeave,
      AdCallback? onHorizontalFeedDetailDidAppear,
      AdCallback? onHorizontalFeedDetailDidDisappear,
      AdCallback? onImageTextDetailDidEnter,
      AdCallback? onImageTextDetailDidLeave,
      AdCallback? onImageTextDetailDidAppear,
      AdCallback? onImageTextDetailDidDisappear,
      AdCallback? onImageTextDetailDidLoadFinish,
      AdCallback? onImageTextDetailDidScroll,
      AdCallback? onError}) {
    _methodChannel.invokeMethod(
        "showContentVideoImageText", {"_channelId": _channelId, "adId": adId});

    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "videoDidStartPlay":
          onVideoDidStartPlay?.call("videoDidStartPlay", "");
          break;

        case "videoDidPause":
          onVideoDidPause?.call("videoDidPause", "");
          break;

        case "videoDidResume":
          onVideoDidResume?.call("videoDidResume", "");
          break;

        case "videoDidEndPlay":
          onVideoDidEndPlay?.call("videoDidEndPlay", "");
          break;

        case "videoDidFailedToPlay":
          onError?.call("videoDidFailedToPlay", event["error"]);
          break;

        case "contentDidFullDisplay":
          onContentDidFullDisplay?.call("contentDidFullDisplay", "");
          break;

        case "contentDidEndDisplay":
          onContentDidEndDisplay?.call("contentDidEndDisplay", "");
          break;

        case "contentDidPause":
          onContentDidPause?.call("contentDidPause", "");
          break;

        case "contentDidResume":
          onContentDidResume?.call("contentDidResume", "");
          break;

        case "horizontalFeedDetailDidEnter":
          onHorizontalFeedDetailDidEnter?.call(
              "horizontalFeedDetailDidEnter", "");
          break;

        case "horizontalFeedDetailDidLeave":
          onHorizontalFeedDetailDidLeave?.call(
              "horizontalFeedDetailDidLeave", "");
          break;

        case "horizontalFeedDetailDidAppear":
          onHorizontalFeedDetailDidAppear?.call(
              "horizontalFeedDetailDidAppear", "");
          break;

        case "horizontalFeedDetailDidDisappear":
          onHorizontalFeedDetailDidDisappear?.call(
              "horizontalFeedDetailDidDisappear", "");
          break;

        case "imageTextDetailDidEnter":
          onImageTextDetailDidEnter?.call("imageTextDetailDidEnter", "");
          break;

        case "horizontalFeedDetailDidLeave":
          onHorizontalFeedDetailDidLeave?.call(
              "horizontalFeedDetailDidLeave", "");
          break;

        case "horizontalFeedDetailDidAppear":
          onHorizontalFeedDetailDidAppear?.call(
              "horizontalFeedDetailDidAppear", "");
          break;

        case "horizontalFeedDetailDidDisappear":
          onHorizontalFeedDetailDidDisappear?.call(
              "horizontalFeedDetailDidDisappear", "");
          break;

        case "imageTextDetailDidEnter":
          onImageTextDetailDidEnter?.call("imageTextDetailDidEnter", "");
          break;

        case "imageTextDetailDidLeave":
          onImageTextDetailDidLeave?.call("imageTextDetailDidLeave", "");
          break;

        case "imageTextDetailDidAppear":
          onImageTextDetailDidAppear?.call("imageTextDetailDidAppear", "");
          break;

        case "imageTextDetailDidDisappear":
          onImageTextDetailDidDisappear?.call(
              "imageTextDetailDidDisappear", "");
          break;

        case "imageTextDetailDidLoadFinish":
          onImageTextDetailDidLoadFinish?.call(
              "imageTextDetailDidLoadFinish", "");
          break;

        case "imageTextDetailDidScroll":
          onImageTextDetailDidScroll?.call("imageTextDetailDidScroll", "");
          break;
      }
    });
  }
}
