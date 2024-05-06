import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zjsdk_flutter/zjsdk_flutter.dart';

/// Widget for banner ad
class BannerAdView extends StatelessWidget {
  final String adId;
  final double width;
  final double height;
  final AdCallback? onAdLoad;
  final AdCallback? onAdShow;
  final AdCallback? onAdClick;
  final AdCallback? onAdClose;
  final AdCallback? onError;
  final AdCallback? onAdDetailClose;

  BannerAdView(
      {Key ?key,
      required this.adId,
      required this.width,
      required this.height,
      this.onAdLoad,
      this.onAdShow,
      this.onAdClick,
      this.onAdClose,
      this.onAdDetailClose,
      this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget banner;
    if (defaultTargetPlatform == TargetPlatform.android) {
      banner = AndroidView(
        viewType: 'com.zjad.adsdk/banner',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      banner = UiKitView(
        viewType: 'com.zjad.adsdk/banner',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      banner = Text("Not supported");
    }

    return Container(
      width: width,
      height: height,
      child: banner,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel = EventChannel("com.zjsdk.adsdk/banner_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
      switch (event["event"]) {
        case "bannerAdViewDidLoad":
          onAdLoad?.call("bannerAdViewDidLoad","");
          break;

        case "bannerAdViewWillBecomVisible":
          onAdShow?.call("bannerAdViewWillBecomVisible","");
          break;

        case "bannerAdViewDidClick":
          onAdClick?.call("bannerAdViewDidClick","");
          break;

        case "bannerAdViewDislike":
          onAdClose?.call("bannerAdViewDislike","");
          break;

        case "bannerAdDidLoadFail":
          onError?.call("bannerAdDidLoadFail", event["error"]);
          break;

        case "bannerAdViewDidCloseOtherController":
          onAdDetailClose?.call("bannerAdViewDidCloseOtherController","");
          break;
      }
    });
  }
}
