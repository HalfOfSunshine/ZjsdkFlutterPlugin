import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

/// Widget for NativeExpress ad
class NativeExpressAdView extends StatelessWidget {
  final String adId;
  final double width;
  final double height;
  final Color? adBackgroundColor;

  final AdCallback? onAdLoad;
  final AdCallback? onAdShow;
  final AdCallback? onAdClick;
  final AdCallback? onAdDislike;
  final AdCallback? onError;
  final AdExtraCallback? onAdRenderSuccess;
  final AdCallback? onAdRenderFail;

// nativeExpressAdViewDidLoad
// nativeExpressAdViewWillShow
// nativeExpressAdDidClick

// nativeExpressAdDislike

// nativeExpressAdDidLoadFail
// nativeExpressAdRenderFail

// nativeExpressAdRenderSuccess
  NativeExpressAdView(
      {Key? key,
      required this.adId,
      required this.width,
      required this.height,
      this.adBackgroundColor,
      this.onAdLoad,
      this.onAdShow,
      this.onAdClick,
      this.onAdDislike,
      this.onAdRenderSuccess,
      this.onAdRenderFail,
      this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget nativeExpress;
    if (defaultTargetPlatform == TargetPlatform.android) {
      nativeExpress = AndroidView(
        viewType: 'com.zjad.adsdk/nativeExpress',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
          "adBackgroundColor": adBackgroundColor?.value,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      nativeExpress = UiKitView(
        viewType: 'com.zjad.adsdk/nativeExpress',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
          "adBackgroundColor": adBackgroundColor?.value,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      nativeExpress = Text("Not supported");
    }
    return Container(
      width: width,
      height: height,
      child: nativeExpress,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/native_express_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
      switch (event["event"]) {
        case "nativeExpressAdViewDidLoad":
          onAdLoad?.call("nativeExpressAdViewDidLoad", "");
          break;
        case "nativeExpressAdViewWillShow":
          onAdShow?.call("nativeExpressAdViewWillShow", "");
          break;
        case "nativeExpressAdRenderFail":
          onAdRenderFail?.call("nativeExpressAdRenderFail", "");
          break;
        case "nativeExpressAdDidClick":
          onAdClick?.call("nativeExpressAdDidClick", "");
          break;

        case "nativeExpressAdDislike":
          onAdDislike?.call("nativeExpressAdDislike", "");
          break;

        case "nativeExpressAdDidLoadFail":
          onError?.call("nativeExpressAdDidLoadFail", event["error"]);
          break;

        case "nativeExpressAdRenderSuccess":
          onAdRenderSuccess?.call("nativeExpressAdRenderSuccess", "",
              extraMap: event['extraMap']);
          break;
      }
    });
  }
}
