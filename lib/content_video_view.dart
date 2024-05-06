import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class ContentVideoListPageView extends StatelessWidget {
  final String adId;
  final double width;
  final double height;
  final AdCallback? onVideoDidStartPlay;
  final AdCallback? onVideoDidPause;
  final AdCallback? onVideoDidResume;
  final AdCallback? onVideoDidEndPlay;
  final AdCallback? onVideoDidFailedToPlay;
  final AdCallback? onContentDidFullDisplay;
  final AdCallback? onContentDidEndDisplay;
  final AdCallback? onContentDidPause;
  final AdCallback? onContentDidResume;

  ContentVideoListPageView(
      {Key? key,
      required this.adId,
      required this.width,
      required this.height,
      this.onVideoDidStartPlay,
      this.onVideoDidPause,
      this.onVideoDidResume,
      this.onVideoDidEndPlay,
      this.onVideoDidFailedToPlay,
      this.onContentDidFullDisplay,
      this.onContentDidEndDisplay,
      this.onContentDidPause,
      this.onContentDidResume})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contentVideoList;
    if (defaultTargetPlatform == TargetPlatform.android) {
      contentVideoList = AndroidView(
        viewType: 'com.zjad.adsdk/contentVideoList',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      contentVideoList = UiKitView(
        viewType: 'com.zjad.adsdk/contentVideoList',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      contentVideoList = Text("Not supported");
    }

    return Container(
      width: width,
      height: height,
      child: contentVideoList,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/content_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
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
          onVideoDidFailedToPlay?.call("videoDidFailedToPlay", event["error"]);
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
}

/// Widget for banner ad
class ContentVideoFeedPageView extends StatelessWidget {
  final String? adId;
  final double? width;
  final double? height;
  final AdCallback? onVideoDidStartPlay;
  final AdCallback? onVideoDidPause;
  final AdCallback? onVideoDidResume;
  final AdCallback? onVideoDidEndPlay;
  final AdCallback? onVideoDidFailedToPlay;
  final AdCallback? onContentDidFullDisplay;
  final AdCallback? onContentDidEndDisplay;
  final AdCallback? onContentDidPause;
  final AdCallback? onContentDidResume;

  ContentVideoFeedPageView(
      {Key? key,
      this.adId,
      this.width,
      this.height,
      this.onVideoDidStartPlay,
      this.onVideoDidPause,
      this.onVideoDidResume,
      this.onVideoDidEndPlay,
      this.onVideoDidFailedToPlay,
      this.onContentDidFullDisplay,
      this.onContentDidEndDisplay,
      this.onContentDidPause,
      this.onContentDidResume})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contentVideoFeed;
    if (defaultTargetPlatform == TargetPlatform.android) {
      contentVideoFeed = AndroidView(
        viewType: 'com.zjad.adsdk/contentVideoFeed',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      contentVideoFeed = UiKitView(
        viewType: 'com.zjad.adsdk/contentVideoFeed',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      contentVideoFeed = Text("Not supported");
    }

    return Container(
      width: width,
      height: height,
      child: contentVideoFeed,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/content_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
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
          onVideoDidFailedToPlay?.call("videoDidFailedToPlay", event["error"]);
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
}

class ContentVideoHorizontalPageView extends StatelessWidget {
  final String? adId;
  final double? width;
  final double? height;
  final AdCallback? onVideoDidStartPlay;
  final AdCallback? onVideoDidPause;
  final AdCallback? onVideoDidResume;
  final AdCallback? onVideoDidEndPlay;
  final AdCallback? onVideoDidFailedToPlay;
  final AdCallback? onContentDidFullDisplay;
  final AdCallback? onContentDidEndDisplay;
  final AdCallback? onContentDidPause;
  final AdCallback? onContentDidResume;
  final AdCallback? onHorizontalextFeedDetailDidEnter;
  final AdCallback? onHorizontalextFeedDetailDidLeave;
  final AdCallback? onHorizontalextFeedDetailDidAppear;
  final AdCallback? onHorizontalextFeedDetailDidDisappear;

  ContentVideoHorizontalPageView({
    Key? key,
    this.adId,
    this.width,
    this.height,
    this.onVideoDidStartPlay,
    this.onVideoDidPause,
    this.onVideoDidResume,
    this.onVideoDidEndPlay,
    this.onVideoDidFailedToPlay,
    this.onContentDidFullDisplay,
    this.onContentDidEndDisplay,
    this.onContentDidPause,
    this.onContentDidResume,
    this.onHorizontalextFeedDetailDidEnter,
    this.onHorizontalextFeedDetailDidLeave,
    this.onHorizontalextFeedDetailDidAppear,
    this.onHorizontalextFeedDetailDidDisappear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contentVideoHorizontal;
    if (defaultTargetPlatform == TargetPlatform.android) {
      contentVideoHorizontal = AndroidView(
        viewType: 'com.zjad.adsdk/contentVideoHorizontalPage',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      contentVideoHorizontal = UiKitView(
        viewType: 'com.zjad.adsdk/contentVideoHorizontal',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      contentVideoHorizontal = Text("Not supported");
    }

    return Container(
      width: width,
      height: height,
      child: contentVideoHorizontal,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/content_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
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
          onVideoDidFailedToPlay?.call("videoDidFailedToPlay", event["error"]);
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
        case "onHorizontalextFeedDetailDidEnter":
          onContentDidResume?.call("onHorizontalextFeedDetailDidEnter", "");
          break;
        case "onHorizontalextFeedDetailDidLeave":
          onContentDidResume?.call("onHorizontalextFeedDetailDidLeave", "");
          break;
        case "onHorizontalextFeedDetailDidAppear":
          onContentDidResume?.call("onHorizontalextFeedDetailDidAppear", "");
          break;
        case "onHorizontalextFeedDetailDidDisappear":
          onContentDidResume?.call("onHorizontalextFeedDetailDidDisappear", "");
          break;
      }
    });
  }
}

class ContentVideoImageTextPageView extends StatelessWidget {
  final String? adId;
  final double? width;
  final double? height;
  final AdCallback? onVideoDidStartPlay;
  final AdCallback? onVideoDidPause;
  final AdCallback? onVideoDidResume;
  final AdCallback? onVideoDidEndPlay;
  final AdCallback? onVideoDidFailedToPlay;
  final AdCallback? onContentDidFullDisplay;
  final AdCallback? onContentDidEndDisplay;
  final AdCallback? onContentDidPause;
  final AdCallback? onContentDidResume;

  final AdCallback? onHorizontalextFeedDetailDidEnter;
  final AdCallback? onHorizontalextFeedDetailDidLeave;
  final AdCallback? onHorizontalextFeedDetailDidAppear;
  final AdCallback? onHorizontalextFeedDetailDidDisappear;

  final AdCallback? onImageTextDetailDidEnter;
  final AdCallback? onImageTextDetailDidLeave;
  final AdCallback? onImageTextDetailDidAppear;
  final AdCallback? onImageTextDetailDidDisappear;
  final AdCallback? onImageTextDetailDidLoadFinish;
  final AdCallback? onImageTextDetailDidScroll;
  ContentVideoImageTextPageView(
      {Key? key,
      this.adId,
      this.width,
      this.height,
      this.onVideoDidStartPlay,
      this.onVideoDidPause,
      this.onVideoDidResume,
      this.onVideoDidEndPlay,
      this.onVideoDidFailedToPlay,
      this.onContentDidFullDisplay,
      this.onContentDidEndDisplay,
      this.onContentDidPause,
      this.onContentDidResume,
      this.onHorizontalextFeedDetailDidEnter,
      this.onHorizontalextFeedDetailDidLeave,
      this.onHorizontalextFeedDetailDidAppear,
      this.onHorizontalextFeedDetailDidDisappear,
      this.onImageTextDetailDidEnter,
      this.onImageTextDetailDidLeave,
      this.onImageTextDetailDidAppear,
      this.onImageTextDetailDidDisappear,
      this.onImageTextDetailDidLoadFinish,
      this.onImageTextDetailDidScroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contentVideoImageText;
    if (defaultTargetPlatform == TargetPlatform.android) {
      contentVideoImageText = AndroidView(
        viewType: 'com.zjad.adsdk/contentVideoImageTextPage',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      contentVideoImageText = UiKitView(
        viewType: 'com.zjad.adsdk/contentVideoImageText',
        creationParams: {
          "adId": adId,
          "width": width,
          "height": height,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      contentVideoImageText = Text("Not supported");
    }

    return Container(
      width: width,
      height: height,
      child: contentVideoImageText,
    );
  }

  void _onPlatformViewCreated(int id) {
    EventChannel eventChannel =
        EventChannel("com.zjsdk.adsdk/content_video_event_$id");
    eventChannel.receiveBroadcastStream().listen((event) {
      print('Flutter.Listen--------');
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
          onVideoDidFailedToPlay?.call("videoDidFailedToPlay", event["error"]);
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

        case "onHorizontalextFeedDetailDidEnter":
          onContentDidResume?.call("onHorizontalextFeedDetailDidEnter", "");
          break;
        case "onHorizontalextFeedDetailDidLeave":
          onContentDidResume?.call("onHorizontalextFeedDetailDidLeave", "");
          break;
        case "onHorizontalextFeedDetailDidAppear":
          onContentDidResume?.call("onHorizontalextFeedDetailDidAppear", "");
          break;
        case "onHorizontalextFeedDetailDidDisappear":
          onContentDidResume?.call("onHorizontalextFeedDetailDidDisappear", "");
          break;
        case "onImageTextDetailDidEnter":
          onContentDidResume?.call("onImageTextDetailDidEnter", "");
          break;
        case "onImageTextDetailDidLeave":
          onContentDidResume?.call("onImageTextDetailDidLeave", "");
          break;
        case "onImageTextDetailDidAppear":
          onContentDidResume?.call("onImageTextDetailDidAppear", "");
          break;
        case "onImageTextDetailDidDisappear":
          onContentDidResume?.call("onImageTextDetailDidDisappear", "");
          break;
        case "onImageTextDetailDidLoadFinish":
          onContentDidResume?.call("onImageTextDetailDidLoadFinish", "");
          break;
        case "onImageTextDetailDidScroll":
          onContentDidResume?.call("onImageTextDetailDidScroll", "");
          break;
      }
    });
  }
}
