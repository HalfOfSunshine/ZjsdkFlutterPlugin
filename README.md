---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: true

print_background: true
---

# ZJSDK_iOS_Flutter使用文档 {ignore=true}
| 最新版本更新日志 | 修订日期  | 修订说明       |
| ---------------- | --------- | -------------- |
|v2.5.3.0|2023-02-22|1，新增视频内容广告样式，<br>2，增加视频内容四种样式插件<br>3，XCode14下视频内容接入方式更新，详见[2.6.1、ZJContentPage接入注意事项](#291-font-colorredzjcontentpage接入注意事项font)|

## <span id="jump1">一、iOS SDK接入说明</span>

### <span id="jump1.1">1.1、工程设置导入framework</span>

#### <span id="jump1.1.1">1.1.1、申请应用的AppID</span>

```
请找运营人员获取应用ID和广告位ID。
```

#### <span id="jump1.1.2">1.1.2、导入framework</span>
**1. pubspec.yaml接入方式**
**复杂度：** ★☆☆
**优缺点：** 桥接已写好，开发者只需导入package即可。
**适用：** 适用于大多数flutter开发者，集成、使用简单，省时省力。
```
  zjsdk_flutter: ^0.1.2
```
**2. CocoaPods接入方式**
通过CocoaPods接入后，需实现原生与flutter之间的桥接

**复杂度：** ★★☆
**优缺点：** 通过原生调用接口，更为灵活。但是需要混编，各种借口调用需要桥接，费时费力。
**适用：** 适用于pub导入方式所开放的接口 满足不了需求，且有原生开发，与flutter混编经验的，时间预算更多一些的开发者
```
#完整的SDK
pod 'ZJSDK'

#如需模块拆分导入，请导入ZJSDKModuleDSP
pod 'ZJSDK/ZJSDKModuleDSP'

pod 'ZJSDK/ZJSDKModuleGDT'#优量汇广告
pod 'ZJSDK/ZJSDKModuleCSJ'#穿山甲广告
pod 'ZJSDK/ZJSDKModuleKS'#快手广告
pod 'ZJSDK/ZJSDKModuleMTG'#MTG广告
pod 'ZJSDK/ZJSDKModuleSIG' #Sigmob广告
pod 'ZJSDK/ZJSDKModuleYM'  #云码广告，
```

**3.手动方式**
**复杂度：** ★★★
**优缺点：** 需要手动集成，复杂度较高，不推荐。
**适用：** 与项目中其他原生库冲突，比如有集成快手短视频时，或者需要接入视频内容(ZJContentPage)广告时使用此方式。

1.获取 framework 文件后直接将 {ZJSDK}文件拖入工程即可

2.<font color=#FF0000>前往项目的Build Setting中的Enable Bitcode设置为NO</font>

3.<font color=#FF0000>前往项目的Build Phases，创建Copy Files，修改Destination为Frameworks，Name中添加KSAdSDK.framework</font>

4.为了方便模拟器调试，KSAdSDK 带有x86_64,i386架构，上架App store需要移除对应的这两个架构，请参考:（https://stackoverflow.com/questions/30547283/submit-to-app-store-issues-unsupported-architecture-x86）

*升级SDK的同学必须同时更新framework和bundle文件，否则可能出现部分页面无法展示的问题，老版本升级的同学需要重新引入ZJSDK.framework

*拖入完请确保Copy Bundle Resources中有BUAdSDK.bundle，ZJSDKBundle.bundle否则可能出现icon图片加载不出来的情况。

### <span id="jump1.2">1.2、Xcode编译选项设置</span>

#### <span id="jump1.1.2.1">1.2.1、添加权限</span>

- 工程plist文件设置，点击右边的information Property List后边的 "+" 展开

添加 App Transport Security Settings，先点击左侧展开箭头，再点右侧加号，Allow Arbitrary Loads 选项自动加入，修改值为 YES。 SDK API 已经全部支持HTTPS，但是广告主素材存在非HTTPS情况。

```
<key>NSAppTransportSecurity</key>
  <dict>
     <key>NSAllowsArbitraryLoads</key>
   <true/>
</dict>
```

- Build Settings中Other Linker Flags 增加参数-ObjC，字母o和c大写。

#### <span id="jump1.2.2">1.2.2、运行环境配置</span>

- 支持系统 iOS 9.X 及以上;
- SDK编译环境 Xcode 11;
- 支持架构： x86-64, armv7, arm64,i386

**添加依赖库**

工程需要在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库

- StoreKit.framework

- MobileCoreServices.framework

- WebKit.framework

- MediaPlayer.framework

- CoreMedia.framework

- CoreLocation.framework

- AVFoundation.framework

- CoreTelephony.framework

- SystemConfiguration.framework

- AdSupport.framework

- CoreMotion.framework

- Accelerate.framework

- libresolv.9.tbd

- libc++.tbd

- libz.tbd

- libsqlite3.tbd

- libbz2.tbd

- libxml2.tbd

- QuartzCore.framework

- Security.framework

  如果以上依赖库增加完仍旧报错，请添加ImageIO.framework。

  SystemConfiguration.framework、CoreTelephony.framework、Security.framework是为了统计app信息使用

#### <span id="jump1.2.3">1.2.3、位置权限</span>

SDK 不会主动获取应用位置权限，当应用本身有获取位置权限逻辑时，需要在应用的 info.plist 添加相应配置信息，避免 App Store 审核被拒：

// 应用根据实际情况配置

```
  Privacy - Location When In Use Usage Description
  Privacy - Location Always and When In Use Usage Description
  Privacy - Location Always Usage Description
  Privacy - Location Usage Description
```


### <span id="jump1.3">1.3、初始化SDK</span>



开发者需要在AppDelegate#application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法中调用以下代码来初始化sdk。

flutter项目初始化 参考demo的AppDelegate
1.通过pub集成
```
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // 初始化ZJSDK
  [ZJAdSDK registerAppId:@"zj_20201014iOSDEMO"];
  // 注册flutter插件
  [GeneratedPluginRegistrant registerWithRegistry:self];
}

```

2.通过其他方式集成
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //初始化ZJSDK
  [ZJAdSDK registerAppId:@"zj_20201014iOSDEMO"];

  // 注册 flutter 插件
  [ZJAdPlugin registerWithRegistry:self];

  return YES;
}

- (NSObject<FlutterPluginRegistrar>*)registrarForPlugin:(NSString*)pluginKey {
    UIViewController* rootViewController = self.window.rootViewController;
  if ([rootViewController isKindOfClass:[FlutterViewController class]]) {
    return [[(FlutterViewController*)rootViewController pluginRegistry] registrarForPlugin:pluginKey];
  } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
     FlutterViewController *flutterVC = [rootViewController.childViewControllers firstObject];
      if ([flutterVC isKindOfClass:[FlutterViewController class]]) {
        return [[flutterVC pluginRegistry] registrarForPlugin:pluginKey];
      }
  }
  return nil;
}


```



## <span id="jump2">二、加载广告</span>

### <span id="jump2.1">2.1、接入开屏广告(SplashAd)</span>

- 类型说明： 开屏广告主要是 APP 启动时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### <span id="jump2.1.1">2.1.1、开屏广告调用</span>

```
  static void showSplashAd(String adId,int fetchDelay,
      {AdCallback onAdLoad,
      AdCallback onAdShow,
      AdCallback onAdClick,
      AdCallback onCountdownEnd,
      AdCallback onAdClose,
      AdCallback onError}) {
    _methodChannel.invokeMethod(
        "showSplashAd", {"_channelId": ++_channelId, "adId": adId,"fetchDelay":fetchDelay});

    EventChannel eventChannel = EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "splashAdDidLoad":
          onAdLoad?.call("splashAdDidLoad","");
          break;

        case "splashAdSuccessPresentScreen":
          onAdShow?.call("splashAdSuccessPresentScreen","");
          break;

        case "splashAdClicked":
          onAdClick?.call("splashAdClicked","");
          break;

        case "splashAdCountdownEnd":
          onCountdownEnd?.call("splashAdCountdownEnd","");
          break;

        case "splashAdClosed":
          onAdClose?.call("splashAdClosed","");
          break;

        case "splashAdError":
          onError?.call("splashAdError", event["error"]);
          break;
      }
    });
  }

```

#### <span id="jump2.1.2">2.1.2、开屏广告回调说明</span>
通过回调中的event获取
```
//开屏广告素材加载成功
splashAdDidLoad

//开屏广告成功展示
splashAdSuccessPresentScreen

//开屏广告点击回调
splashAdClicked

//开屏广告关闭回调
splashAdClosed

//应用进入后台时回调 详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 splashAdApplicationWillEnterBackground

//开屏广告倒记时结束
splashAdCountdownEnd;

//开屏广告错误
splashAdError;

```


### <span id="jump2.2">2.2、接入激励视频(RewardVideoAd)</span>

- 类型说明： 激励视频广告是一种全新的广告形式，用户可选择观看视频广告以换取有价物，例如虚拟货币、应用内物品和独家内容等等；这类广告的长度为 15-30 秒，不可跳过，且广告的结束画面会显示结束页面，引导用户进行后续动作。

#### <span id="jump2.2.1">2.2.1、激励视频调用</span>

```
/// show reward video ad
  static void showRewardVideoAd(String adId,String userId,
      {AdCallback onAdLoad,
      AdCallback onAdShow,
      AdCallback onReward,
      AdCallback onAdClick,
      AdCallback onVideoComplete,
      AdCallback onAdClose,
      AdCallback onError}) {
    _methodChannel.invokeMethod(
        "showRewardVideoAd", {"_channelId": ++_channelId, "adId": adId,"userId":userId});

    EventChannel eventChannel = EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "rewardVideoLoadSuccess":
          onAdLoad?.call("rewardVideoLoadSuccess","");
          break;

        case "rewardVideoAdDidShow":
          onAdShow?.call("rewardVideoAdDidShow","");
          break;

        case "rewardVideoDidRewardEffective":
          
          onReward?.call("rewardVideoDidRewardEffective",event["transId"]);
          break;

        case "rewardVideoAdDidClicked":
          onAdClick?.call("rewardVideoAdDidClicked","");
          break;

        case "rewardVideoAdDidPlayFinish":
          onVideoComplete?.call("rewardVideoAdDidPlayFinish","");
          break;

        case "rewardVideoAdDidClose":
          onAdClose?.call("rewardVideoAdDidClose","");
          break;

        case "onError":
          onError?.call("rewardVideoAdError", event["error"]);
          break;
      }
    });
  }

```

#### <span id="jump2.2.2">2.2.2、激励视频回调说明</span>
通过回调中的message获取
```
//视频数据下载成功回调
rewardVideoLoadSuccess

//视频广告展示
rewardVideoAdDidShow

//视频播放页关闭
rewardVideoAdDidClose

//视频广告信息点击
rewardVideoAdDidClicked

//奖励触发
rewardVideoDidRewardEffective

//视频广告视频播放完成
rewardVideoAdDidPlayFinish

//视频广告各种错误信息回调
rewardVideoAdError
```

### <span id="jump2.3">2.3、接入插屏广告(InterstitialAd)</span>

- 类型说明： 插屏广告是移动广告的一种常见形式，在应用开流程中弹出，当应用展示插页式广告时，用户可以选择点按广告，访问其目标网址，也可以将其关闭，返回应用。

#### <span id="jump2.3.1">2.3.1、插屏广告调用</span>

```
 /// show interstitial ad
  static void showInterstitialAd(String adId,
      {AdCallback onAdLoad,
      AdCallback onAdShow,
      AdCallback onAdClick,
      AdCallback onAdClose,
      AdCallback onAdDetailClose,
      AdCallback onError}) {
    _methodChannel.invokeMethod(
        "showInterstitialAd", {"_channelId": ++_channelId, "adId": adId});

    EventChannel eventChannel = EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "interstitialAdDidLoad":
          onAdLoad?.call("interstitialAdDidLoad","");
          break;

        case "interstitialAdDidPresentScreen":
          onAdShow?.call("interstitialAdDidPresentScreen","");
          break;

        case "interstitialAdDidClick":
          onAdClick?.call("interstitialAdDidClick","");
          break;

        case "interstitialAdDidClose":
          onAdClose?.call("interstitialAdDidClose","");
          break;

        case "interstitialAdDetailDidClose":
          onAdDetailClose?.call("interstitialAdDetailDidClose","");
          break;

        case "interstitialAdError":
          onError?.call("interstitialAdError", event["error"]);
          break;
      }
    });
  }
```

#### <span id="jump2.3.2">2.3.2、插屏广告回调说明</span>

```
//插屏广告数据加载成功回调
interstitialAdDidLoad

//插屏广告错误回调
interstitialAdError

//插屏广告展示
interstitialAdDidPresentScreen

//插屏广告点击
interstitialAdDidClick

//插屏广告关闭
interstitialAdDidClose

//插屏广告详情页关闭
interstitialAdDetailDidClose
```

### <span id="jump2.4">2.4、banner广告(BannerAd)</span>


#### <span id="jump2.3.1">2.4.1、banner广告调用</span>

```
class BannerAdView extends StatelessWidget {
  final String adId;
  final double width;
  final double height;
  final AdCallback onAdLoad;
  final AdCallback onAdShow;
  final AdCallback onAdClick;
  final AdCallback onAdClose;
  final AdCallback onError;
  final AdCallback onAdDetailClose;

  BannerAdView(
      {Key key,
      this.adId,
      this.width,
      this.height,
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


```

#### <span id="jump2.3.2">2.4.2、banner广告回调说明</span>

```

//banner广告加载成功
bannerAdViewDidLoad

//banner广告加载失败
bannerAdDidLoadFail

//banner广告曝光回调
bannerAdViewWillBecomVisible

//关闭banner广告回调
bannerAdViewDislike

//点击banner广告回调
bannerAdViewDidClick

//关闭banner广告详情页回调
bannerAdViewDidCloseOtherController
```


### 2.5、H5广告

#### 2.5.1、H5广告调用
```
   static void showH5Ad(String adId,String userID, String userName ,String userAvatar,
      {AdCallback onAdLoad,
      AdCallback onError,
      AdCallback onRewardAdLoad,
      AdCallback onRewardAdReward,
      AdCallback onRewardAdClick,
      AdCallback onRewardAdError}) {
    _methodChannel.invokeMethod(
        "showH5Ad", {"_channelId": ++_channelId, "adId": adId,"userID":userID,"userName":userName,"userAvatar":userAvatar});

    EventChannel eventChannel = EventChannel("com.zjsdk.adsdk/event_$_channelId");
    eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["event"]) {
        case "h5AdDidLoad":
          onAdLoad?.call("h5AdDidLoad","");
          break;

        case "h5AdError":
          onError?.call("h5AdError",event["error"]);
          break;

        case "h5_rewardAdDidLoad":
          onRewardAdLoad?.call("h5_rewardAdDidLoad","");
          break;

        case "h5_rewardAdRewardEffective":
          onRewardAdReward?.call("h5_rewardAdRewardEffective",event["transId"]);
          break;

        case "h5_rewardAdRewardClick":
          onRewardAdClick?.call("h5_rewardAdRewardClick","");
          break;

        case "h5_rewardAdRewardError":
          onRewardAdError?.call("h5_rewardAdRewardError", event["error"]);
          break;
      }
    });
  }
```
#### 2.5.2、H5广告回调说明
```
//H5广告加载成功
h5AdDidLoad

//H5广告错误回调
h5AdError

//H5广告 激励视频加载成功
h5_rewardAdDidLoad

//H5广告 激励视频触发奖励
h5_rewardAdRewardEffective

//H5广告 激励视频点击回调
h5_rewardAdRewardClick

//H5广告 激励视频错误回调
h5_rewardAdRewardError

```
### 2.6、接入视频内容(ZJContentPage)</span>
#### 2.6.1、<font color=red>ZJContentPage接入注意事项</font>
由于快手pod库不支持内容包，视频内容模块需要单独手动导入
视频内容集成注意事项：
一，手动引入libIPDSDKModuleKS.a（直接拉进项目里）
二，将KSAdSDK.framework和KSAdSDK.podspec，放在工程文件夹内（不是直接拉进项目里）
三，Podfile里指定本地快手KSAdSDK.podspec的相对路径，如demo中路径为： pod 'KSAdSDK', :path => '../ZJSDK/ZJSDKModuleKS' 
四：打包发布之前，去掉x86_64框架，具体的拆分合并命令参考以下
```
cd [KSAdSDK.framework所在的目录]
mkdir ./bak
cp -r KSAdSDK.framework ./bak
lipo KSAdSDK.framework/KSAdSDK -thin armv7 -output KSAdSDK_armv7
lipo KSAdSDK.framework/KSAdSDK -thin arm64 -output KSAdSDK_arm64
lipo -create KSAdSDK_armv7 KSAdSDK_arm64 -output KSAdSDK
mv KSAdSDK KSAdSDK.framework/
```

#### 2.6.2、ZJContentPage调用
以图文内容为例ContentVideoImageTextPageView
```
class ContentVideoImageTextPageView extends StatelessWidget {
  final String? adId;
  final double? width;
  final double? height;
//***********************所有样式均支持以下回调***********************/
  final AdCallback? onVideoDidStartPlay;
  final AdCallback? onVideoDidPause;
  final AdCallback? onVideoDidResume;
  final AdCallback? onVideoDidEndPlay;
  final AdCallback? onVideoDidFailedToPlay;
  final AdCallback? onContentDidFullDisplay;
  final AdCallback? onContentDidEndDisplay;
  final AdCallback? onContentDidPause;
  final AdCallback? onContentDidResume;

//***********************横版、图文版支持以下回调***********************/
  final AdCallback? onHorizontalextFeedDetailDidEnter;
  final AdCallback? onHorizontalextFeedDetailDidLeave;
  final AdCallback? onHorizontalextFeedDetailDidAppear;
  final AdCallback? onHorizontalextFeedDetailDidDisappear;

//***********************仅图文版支持以下回调***********************/
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
```
#### 2.6.3、ZJContentPage广告回调说明
```
//***********************视频播放状态回调***********************/
//视频开始播放
onVideoDidStartPlay

//视频暂停播放
onVideoDidPause

//视频恢复播放
onVideoDidResume

//视频停止播放
onVideoDidEndPlay

//视频播放失败
onVideoDidFailedToPlay


//***********************内容展示状态回调***********************/
//内容展示
onContentDidFullDisplay

//内容隐藏
onContentDidEndDisplay

//内容暂停显示，ViewController disappear或者Application resign active
onContentDidPause

//内容恢复显示，ViewController appear或者Application become active
onContentDidResume

//*****横版内容状态回调******
//进入横版视频详情页
onHorizontalextFeedDetailDidEnter

//离开横版视频详情页
onHorizontalextFeedDetailDidLeave

//视频详情页appear
onHorizontalextFeedDetailDidAppear

//详情页disappear
onHorizontalextFeedDetailDidDisappear

//***********************图文内容状态回调************************/
//进入图文详情页
onImageTextDetailDidEnter,

//离开图文详情页
onImageTextDetailDidLeave,

//图文详情页appear
onImageTextDetailDidAppear,

//图文详情页disappear
onImageTextDetailDidDisappear,

//图文详情加载结果
onImageTextDetailDidLoadFinish,

// 图文详情阅读进度
onImageTextDetailDidScroll
```


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [一、iOS SDK接入说明](#-span-idjump1一-ios-sdk接入说明span)
  - [1.1、工程设置导入framework](#-span-idjump1111-工程设置导入frameworkspan)
    - [1.1.1、申请应用的AppID](#-span-idjump111111-申请应用的appidspan)
    - [1.1.2、导入framework](#-span-idjump112112-导入frameworkspan)
  - [1.2、Xcode编译选项设置](#-span-idjump1212-xcode编译选项设置span)
    - [1.2.1、添加权限](#-span-idjump1121121-添加权限span)
    - [1.2.2、运行环境配置](#-span-idjump122122-运行环境配置span)
    - [1.2.3、位置权限](#-span-idjump123123-位置权限span)
  - [1.3、初始化SDK](#-span-idjump1313-初始化sdkspan)
- [二、加载广告](#-span-idjump2二-加载广告span)
  - [2.1、接入开屏广告(SplashAd)](#-span-idjump2121-接入开屏广告splashadspan)
    - [2.1.1、开屏广告调用](#-span-idjump211211-开屏广告调用span)
    - [2.1.2、开屏广告回调说明](#-span-idjump212212-开屏广告回调说明span)
  - [2.2、接入激励视频(RewardVideoAd)](#-span-idjump2222-接入激励视频rewardvideoadspan)
    - [2.2.1、激励视频调用](#-span-idjump221221-激励视频调用span)
    - [2.2.2、激励视频回调说明](#-span-idjump222222-激励视频回调说明span)
  - [2.3、接入插屏广告(InterstitialAd)](#-span-idjump2323-接入插屏广告interstitialadspan)
    - [2.3.1、插屏广告调用](#-span-idjump231231-插屏广告调用span)
    - [2.3.2、插屏广告回调说明](#-span-idjump232232-插屏广告回调说明span)
  - [2.4、banner广告(BannerAd)](#-span-idjump2424-banner广告banneradspan)
    - [2.4.1、banner广告调用](#-span-idjump231241-banner广告调用span)
    - [2.4.2、banner广告回调说明](#-span-idjump232242-banner广告回调说明span)
  - [2.5、H5广告](#-25-h5广告)
    - [2.5.1、H5广告调用](#-251-h5广告调用)
    - [2.5.2、H5广告回调说明](#-252-h5广告回调说明)
  - [2.6、接入视频内容(ZJContentPage)</span>](#-26-接入视频内容zjcontentpagespan)
    - [2.6.1、ZJContentPage接入注意事项](#-261-font-colorredzjcontentpage接入注意事项font)
    - [2.6.2、ZJContentPage调用](#-262-zjcontentpage调用)
    - [2.6.3、ZJContentPage广告回调说明](#-263-zjcontentpage广告回调说明)

<!-- /code_chunk_output -->






