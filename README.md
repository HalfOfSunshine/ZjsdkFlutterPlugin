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
|v0.1.3|2024-01-25|1，新增插件注册接口。<br> &emsp; 有开屏需求，仍然推荐在原生注册，并调用开屏，从flutter唤起到注册完成到展示开屏的耗时太长。 <br>2，插件环境配置优化|


历史版本信息见 [历史版本更新日志](#历史版本更新日志)
sdk更新内容请查看[ZJSDK_iOS接入文档](https://static-1318684143.cos.ap-shanghai.myqcloud.com/sdk-downloads/ios/docs/ZJSDK_iOS_optmize%E4%BD%BF%E7%94%A8%E6%96%87%E6%A1%A3.html?q-sign-algorithm=sha1&q-ak=AKIDvmUCeQMXAdhlooPP84Iy0uUu4CyEc1VVEA3Ge8PPbkDRFJoQobm3obw6NDrF-oc-&q-sign-time=1706178488;1706182088&q-key-time=1706178488;1706182088&q-header-list=host&q-url-param-list=&q-signature=d8d82b477cde0e41f29009336b84d9c79209756b&x-cos-security-token=7j2szizzk8WSlew7OqlM8fzEQ3qzJ4Bae598674c672b629358f674060a8dbb8dZQAsQHIGq1y4aszuK6Tn54swMN46qnmHNmB9KQuNG9zmuuvyf8KkLIF8A5bsnN5vKaMvjVrv9CpraerQM7X-P632S1dok5DKSOOE9Src3GmSI7YiYQS0Ae-wAa4IbFGGLoQfOs1H21sg6G0nPR0vJ7WabhYoi85hOjtZg7auFJnlxEP3Y_nXb7UqomLN-ZUm)
## 一、iOS SDK接入说明

### 1.1、工程设置导入framework

#### 1.1.1、申请应用的AppID

```
请找运营人员获取应用ID和广告位ID。
```

#### 1.1.2、导入framework
**1. pubspec.yaml接入方式**
**复杂度：** ★☆☆
**优缺点：** 桥接已写好，开发者只需导入package即可。
**适用：** 适用于大多数flutter开发者，集成、使用简单，省时省力。
```
  zjsdk_flutter: ^0.1.3
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

### 1.2、Xcode编译选项设置

#### 1.2.1、添加权限

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

#### 1.2.2、运行环境配置

- 支持系统 iOS 11.X 及以上;
- 支持架构： x86-64, armv7, arm64
- SDK编译环境 Xcode 14.0 + 

**添加依赖库**

工程需要在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库

- JavaScriptCore.framework

- AudioToolbox.framework

- QuickLook.framework

- MessageUI.framework

- AVKit.framework

- DeviceCheck.framework

- CFNetwork.framework

- CoreGraphics.framework

- SafariServices.framework

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

#### 1.2.3、位置权限

SDK 需要位置权限以更精准的匹配广告，需要在应用的 info.plist 添加相应配置信息，避免 App Store 审核被拒：
```
  Privacy - Location When In Use Usage Description
  Privacy - Location Always and When In Use Usage Description
  Privacy - Location Always Usage Description
  Privacy - Location Usage Description
```


### 1.3、初始化SDK



开发者需要在AppDelegate#application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法中调用以下代码来初始化sdk。

flutter项目初始化 参考demo的AppDelegate
#### 1.通过pub集成
原生注册方式
```
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // 初始化ZJSDK
  [ZJAdSDK registerAppId:@"zj_20201014iOSDEMO"];
  // 注册flutter插件
  [GeneratedPluginRegistrant registerWithRegistry:self];
}
```
Flutter注册方式，调用时机比较晚，推荐使用原生注册方式
```
   ZjsdkFlutter.initZJMethodChannel((msg) {
      print("iOS->flutter事件通道建立成功");
      //先建立事件通道，在所有广告请求前调用
      //确保ZJSDK插件的方法调用都在事件通道建立成功之后
      ZjsdkFlutter.registerAppId("zj_20201014iOSDEMO", onCallback: (msg, info) {
        print("注册完成: " + (msg) + info);
        if (msg == "success") {
          ZjsdkFlutter.showSplashAd(
            "J5621495755",
            5,
            ......
            ......
          );
        }
      });
    });
```


#### 2.通过其他方式集成
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



## 二、加载广告
### 2.1、<font color=red>注册ZJ事件通道</font>
加载广告之前先注册事件通道：
```
ZjsdkFlutter.initZJMethodChannel((msg) {
  //先建立事件通道
  //确保ZJSDK插件的方法调用都在事件通道建立成功之后
  print("iOS->flutter事件通道建立成功");
});
```

### 2.2、接入开屏广告(SplashAd)

- 类型说明： 开屏广告主要是 APP 启动时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### 2.2.1、开屏广告调用

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

#### 2.2.2、开屏广告回调说明
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


### 2.3、接入激励视频(RewardVideoAd)

- 类型说明： 激励视频广告是一种全新的广告形式，用户可选择观看视频广告以换取有价物，例如虚拟货币、应用内物品和独家内容等等；这类广告的长度为 15-30 秒，不可跳过，且广告的结束画面会显示结束页面，引导用户进行后续动作。

#### 2.3.1、激励视频调用

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

#### 2.3.2、激励视频回调说明
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

### 2.4、接入插屏广告(InterstitialAd)

- 类型说明： 插屏广告是移动广告的一种常见形式，在应用开流程中弹出，当应用展示插页式广告时，用户可以选择点按广告，访问其目标网址，也可以将其关闭，返回应用。

#### 2.4.1、插屏广告调用

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

#### 2.4.2、插屏广告回调说明

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

### 2.5、banner广告(BannerAd)

#### 2.5.1、banner广告调用

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

#### 2.5.2、banner广告回调说明

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


### 2.6、H5广告

#### 2.6.1、H5广告调用
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
#### 2.6.2、H5广告回调说明
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
### 2.7、接入视频内容(ZJContentPage)</span>
#### 2.7.1、<font color=red>ZJContentPage接入注意事项</font>
由于快手pod库不支持内容包，视频内容模块需要单独手动导入
视频内容集成注意事项：
1，将KSAdSDK.framework和KSAdSDK.podspec，放在工程文件夹内（不是直接拉进项目里）
2，Podfile里指定本地快手KSAdSDK.podspec的相对路径，如demo中路径为：pod 'KSAdSDK', :path => './'
3：打包发布之前，去掉x86_64框架，具体的拆分合并命令参考以下
```
cd [KSAdSDK.framework所在的目录]
mkdir ./bak
cp -r KSAdSDK.framework ./bak
lipo KSAdSDK.framework/KSAdSDK -thin armv7 -output KSAdSDK_armv7
lipo KSAdSDK.framework/KSAdSDK -thin arm64 -output KSAdSDK_arm64
lipo -create KSAdSDK_armv7 KSAdSDK_arm64 -output KSAdSDK
mv KSAdSDK KSAdSDK.framework/
```

#### 2.7.2、ZJContentPage调用
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
#### 2.7.3、ZJContentPage广告回调说明
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

##历史版本更新日志

| 历史版本更新日志 | 修订日期  | 修订说明       |
| ---------------- | --------- | -------------- |
| v0.0.1          |2020-1-14 | 首次提交，flutter插件化 |
| v0.1.0          |2022-11-17  |1，增加支持广告类型<br>2，空安全适配 |
| v0.1.1          |2023-02-22|1，增加视频内容插件样式，需要导入本地内容包才可调用<br>2，XCode14下视频内容接入方式更新|
| v0.1.2          |2023-05-13  |1，事件通道建立方式优化<br>2，插件文档更新与sdk文档更新分离|
|v0.1.3|2024-01-25|1，新增插件注册接口。<br> &emsp; 有开屏需求，仍然推荐在原生注册，并调用开屏，从flutter唤起到注册完成到展示开屏的耗时太长。 <br>2，插件环境配置优化|


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [一、iOS SDK接入说明](#一-ios-sdk接入说明)
  - [1.1、工程设置导入framework](#11-工程设置导入framework)
    - [1.1.1、申请应用的AppID](#111-申请应用的appid)
    - [1.1.2、导入framework](#112-导入framework)
  - [1.2、Xcode编译选项设置](#12-xcode编译选项设置)
    - [1.2.1、添加权限](#121-添加权限)
    - [1.2.2、运行环境配置](#122-运行环境配置)
    - [1.2.3、位置权限](#123-位置权限)
  - [1.3、初始化SDK](#13-初始化sdk)
    - [1.通过pub集成](#1通过pub集成)
    - [2.通过其他方式集成](#2通过其他方式集成)
- [二、加载广告](#二-加载广告)
  - [2.1、注册ZJ事件通道](#21-font-colorred注册zj事件通道font)
  - [2.2、接入开屏广告(SplashAd)](#22-接入开屏广告splashad)
    - [2.2.1、开屏广告调用](#221-开屏广告调用)
    - [2.2.2、开屏广告回调说明](#222-开屏广告回调说明)
  - [2.3、接入激励视频(RewardVideoAd)](#23-接入激励视频rewardvideoad)
    - [2.3.1、激励视频调用](#231-激励视频调用)
    - [2.3.2、激励视频回调说明](#232-激励视频回调说明)
  - [2.4、接入插屏广告(InterstitialAd)](#24-接入插屏广告interstitialad)
    - [2.4.1、插屏广告调用](#241-插屏广告调用)
    - [2.4.2、插屏广告回调说明](#242-插屏广告回调说明)
  - [2.5、banner广告(BannerAd)](#25-banner广告bannerad)
    - [2.5.1、banner广告调用](#251-banner广告调用)
    - [2.5.2、banner广告回调说明](#252-banner广告回调说明)
  - [2.6、H5广告](#26-h5广告)
    - [2.6.1、H5广告调用](#261-h5广告调用)
    - [2.6.2、H5广告回调说明](#262-h5广告回调说明)
  - [2.7、接入视频内容(ZJContentPage)</span>](#27-接入视频内容zjcontentpagespan)
    - [2.7.1、ZJContentPage接入注意事项](#271-font-colorredzjcontentpage接入注意事项font)
    - [2.7.2、ZJContentPage调用](#272-zjcontentpage调用)
    - [2.7.3、ZJContentPage广告回调说明](#273-zjcontentpage广告回调说明)
- [历史版本更新日志](#历史版本更新日志)

<!-- /code_chunk_output -->






